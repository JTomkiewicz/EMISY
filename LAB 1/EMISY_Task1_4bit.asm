;labels definitions
LCD_RS EQU P3.0 ;RS pin
LCD_E EQU P3.1 ;E pin
LCD_BUS EQU P1 ;DB pins from P1.0 to P1.7

clr LCD_RS

;initialization
lcall delay_ms

mov LCD_BUS, #00100000B ;function set
lcall send_command
lcall delay_us
lcall send_command
lcall delay_us

mov LCD_BUS, #10000000B
lcall send_command
lcall delay_us

mov LCD_BUS, #00000000B ;display ON/OFF control
lcall send_command
lcall delay_us

mov LCD_BUS, #11100000B 
lcall send_command
lcall delay_us

mov LCD_BUS, #00000000B ;display clear
lcall send_command
lcall delay_ms

mov LCD_BUS, #00010000B
lcall send_command
lcall delay_ms

mov LCD_BUS, #00000000B ;entry mode set
mov LCD_BUS, #01100000B 

;initialization END, now send J to LCD
mov LCD_BUS, #'J'
lcall send_data
lcall delay_ms
mov A, #'J'

;shift 4 newest bits to 4 oldest
rl A
rl A
rl A
rl A
mov LCD_BUS, A
lcall send_data
lcall delay_ms

jmp $ ;infinite loop, jmp to yourselve

send_command: ;send 1 to LCD_E and then 0
	setb LCD_E
	clr LCD_E
ret

send_data: ;nearly identical to send_command, differs only with RS pin
	setb LCD_RS	
	setb LCD_E
	clr LCD_E
ret

short_delay: ;short delay (microseconds)
	mov A, #40 ;we want 40us
	lcall delay_us ;wait
ret

long_delay: ;long delay (milliseconds)
	mov A, #15 ;30/2=15ms as the loop takes 2ms
	lcall delay_ms ;wait
ret

delay_us: ;one microsecond delay
	mov R0, A
	djnz R0, $
ret

delay_ms: ;two millisecond delay
	;we need two varibles to store numbers, as we are operating on 8 bit nrs
	mother_var:
		mov R1, #10
	child_var:
		mov R2, #50
	djnz R2, $ ;decrement child untill 0
	djnz R1, child_var ;decrement mother
	djnz R0, mother_var
ret 


