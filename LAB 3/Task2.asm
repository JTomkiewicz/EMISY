;EMISY LABORATORY 3 TASK 2 checking if matrix keyboard is pressed with external interrupt INT1

;labels definitions
LED_BUS EQU P1 ;pins from P1.0 to P1.7

;send 1s to display to make it clear -> nothing on display
mov LED_BUS, #00000000B

jmp $ ;inifinite loop at the end, jump to yourselfe
