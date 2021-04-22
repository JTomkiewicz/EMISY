;EMISY LABORATORY 1 TASK 1 Interfacing display and MCU using 8 bit

;labels definitions
LCD_RS EQU P3.0 ;RS pin
LCD_E EQU P3.1 ;E pin
LCD_BUS EQU P1 ;DB pins from P1.0 to P1.7

;send 0 to LCD_RS
clr LCD_RS

;BEGIN initialization
lcall long_delay

mov LCD_BUS, #00111000B ;function set
lcall send_command
lcall short_delay
mov LCD_BUS, #00001110B ;display ON/OFF control
lcall send_command
lcall short_delay
mov LCD_BUS, #00000001B ;display clear
lcall send_command
lcall long_delay
mov LCD_BUS, #00000110B ;entry mode set

;END initialization
;my name is Jakub so send J to LCD
mov LCD_BUS, #'J'
lcall send_data
lcall long_delay

jmp $ ;infinite loop, jmp to yourselve

send_command: ;send 1 to LCD_E and then 0
	setb LCD_E
	clr LCD_E
ret

send_data: ;nearly identical to send_command, differs only with RS pin
	setb LCD_RS	
	setb LCD_E ;negative edge on E
	clr LCD_E
ret

short_delay: ;short delay (microseconds)
	mov A, #40 ;we want 40us
	lcall delay_us ;wait
ret

long_delay: ;long delay (milliseconds)
	mov A, #30 ;we want 30ms
	lcall delay_ms ;wait
ret

delay_us: ;one microsecond delay function
	mov R0, A
	djnz R0, $
ret

delay_ms: ;one millisecond delay function
	;we need two varibles to store numbers, as we are operating on 8 bit nrs
	mother_var:
		mov R1, #10
	child_var:
		mov R2, #50
	djnz R2, $ ;decrement child untill 0
	djnz R1, child_var ;decrement mother
	djnz R0, mother_var
ret 


