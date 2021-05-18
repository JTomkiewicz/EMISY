;EMISY LABORATORY 2 TASK 3 Timer() and LED displays - multiplexing animations

;my student id number is 300183, last 4 digits are: 0183

;labels definitions
LETTER_BUS EQU P1 ;pins from P1.0 to P1.7
DECO_CS EQU P0.7 ;decoder CS pin
DECO_A EQU P3 ;decoder A0 and A1 pins connected to P3.3 and P3.4

;send 1s to display to make it clear -> nothing on display
mov LETTER_BUS, #11111111B

;jump to configuration
jmp configurationFirst

org 0BH ;instructions should be written in memory starting from given address

mov ACC, R0
;switch between displays
jb ACC.0, DISPLAY0
jb ACC.1, DISPLAY1
jb ACC.2, DISPLAY2
jb ACC.3, DISPLAY3

;letter 3 on display 0 
DISPLAY0:
    mov R0, #00000010B ;ID of display 1

    mov R1, #00000000B ;we are working on display nr0
    mov R2, #10110000B ;and sending letter 3 so abcdg needs to light

    lcall riseAndShine ;func to show letter on display 

    mov TH0, #0D8H ;high part
    mov TL0, #0F0H ;low part
reti

;letter 8 on display 1
DISPLAY1:
    mov R0, #00000100B ;ID of display 2

    mov R1, #00001000B ;we are working on display nr1
    mov R2, #10000000B ;and sending letter 8

    lcall riseAndShine ;func to show letter on display 

    mov TH0, #0D8H ;high part
    mov TL0, #0F0H ;low part
reti

;letter 1 on display 2
DISPLAY2:
    mov R0, #00001000B ;ID of display 3

    mov R1, #00110000B ;we are working on display nr2
    mov R2, #11111001B ;and sending letter 1

    lcall riseAndShine ;func to show letter on display

    mov TH0, #0D8H ;high part
    mov TL0, #0F0H ;low part 
reti

;letter 0 on display 3
DISPLAY3:
    mov R0, #00000001B ;ID of display 0

    mov R1, #00011000B ;we are working on display nr3
    mov R2, #11000000B ;and sending letter 0

    lcall riseAndShine ;func to show letter on display 

    mov TH0, #0D8H ;high part
    mov TL0, #0F0H ;low part
reti

;subroutine to light selected display parts on chosen display
riseAndShine:
    clr DECO_CS ;decoder OFF
    mov DECO_A, R1 ;chose on decoder display to work on
    mov LETTER_BUS, R2 ;chosen parts of the display to light
    setb DECO_CS ;decoder ON
ret

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