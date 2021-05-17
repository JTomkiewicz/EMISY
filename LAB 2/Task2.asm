;EMISY LABORATORY 2 TASK 2 Timer() configuration

;labels definitions
LETTER_BUS EQU P1 ;pins from P1.0 to P1.7
DECO_CS EQU P0.7 ;decoder CS pin
DECO_A EQU P3 ;decoder A0 and A1 pins connected to P3.3 and P3.4

;send 1s to display to make it clear -> nothing on display
mov LETTER_BUS, #11111111B

;jump to configuration
jmp configurationFirst

org 0BH ;instructions should be written in memory starting from given address

clr DECO_CS ;decoder OFF
mov DECO_A, #00010000B ;we are working on display nr3
xrl LETTER_BUS, #10000000B ;blink is done by xor, which then 
setb DECO_CS ;decoder ON

;reconstruct timer 
;65536 - 10000 (as we want 10ms) = 55536
mov TH0, #0D8H ;high part
mov TL0, #0F0H ;low part

reti ;return interrupt subroutine

;subroutine to configure T0
configurationFirst:
    setb TR0 ;T0 must be turned ON
    mov TMOD, #01H ;T0 must coung internal clock cycles

    ;T0 should count exact number of clock cycles
    ;65536 - 10000 (as we want 10ms) = 55536
    mov TH0, #0D8H ;high part
    mov TL0, #0F0H ;low part

    setb ET0 ;overflow interrupt ENABLE
    setb EA ;global interrupt ENABLE
    
    jmp $ ;inifinite loop at the end, jump to yourselfe
