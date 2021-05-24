;EMISY LABORATORY 3 TASK 2 checking if matrix keyboard is pressed with external interrupt INT1

;labels definitions
LED_BUS EQU P1 ;pins from P1.0 to P1.7
INT1 EQU P3.3 ;INT1 external interrupt
KBRD_BUS EQU P0 ;keyboard bus pins from P0.0 to P0.7

mov KBRD_BUS, #11110000B

;jump to configuration
jmp configurationFirst

org 013H ;INT1 external interrupt

xrl LED_BUS, #11111111B
jnb INT1, $

reti ;return interrupt subroutine

configurationFirst:
	setb EA ;global interrupt ENABLE
	setb EX1 ;INT1 interrupt ENABLE
	setb IT1 ;falling edge on input signal

	jmp $ ;inifinite loop at the end, jump to yourselfe

