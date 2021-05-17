;EMISY LABORATORY 2 TASK 1 Turning on proper LED segments in LED display

;labels definitions
LETTER_BUS EQU P1 ;pins from P1.0 to P1.7
DECO_CS EQU P0.7 ;decoder CS pin
DECO_A EQU P3 ;decoder A0 and A1 pins connected to P3.3 and P3.4

;send 1s to display to make it clear -> nothing on display
mov LETTER_BUS, #11111111B

;according to recorded kitchen clock we want digit 3 on the display nr3
mov R0, #00010000B ;we are working on display nr3
mov R1, #10110000B ;and sending letter 3 so abcdg needs to light

lcall riseAndShine ;func to show letter on display 

jmp $ ;inifinite loop at the end, jump to yourselfe

;subroutine to light selected display parts on chosen display
riseAndShine:
    clr DECO_CS ;decoder OFF
    mov DECO_A, R0 ;chose on decoder display to work on
    mov LETTER_BUS, R1 ;chosen parts of the display to light
    setb DECO_CS ;decoder ON
ret