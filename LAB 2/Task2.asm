;EMISY LABORATORY 2 TASK 2 Timer() configuration

;labels definitions
LETTER_BUS EQU P1 ;pins from P1.0 to P1.7
DECO_CS EQU P0.7 ;decoder CS pin
DECO_A EQU P3 ;decoder A0 and A1 pins connected to P3.3 and P3.4

;send 1s to display to make it clear -> nothing on display
mov LETTER_BUS, #11111111B



;subroutine to configure T0
configurationFirst:
    setb TR0 ;T0 must be turned ON
    mov TMOD, #01H ;T0 must coung internal clock cycles

    ;T0 should count exact number of clock cycles
    mov TH0, #0FFH
    mov TL0, #0FCH

    setb ET0 ;overflow interrupt ENABLE
    setb EA ;global interrupt ENABLE
reti ;return interrupt subroutine
