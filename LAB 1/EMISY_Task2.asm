;EMISY LABORATORY 1 TASK 2 Writing students name & index using 8 bit

;put data in RAM
mov 30H, #'3'
mov 31H, #'0'
mov 32H, #'0'
mov 33H, #'1'
mov 34H, #'8'
mov 35H, #'3'
mov 36H, #0 ;end of first line
mov 37H, #'J'
mov 38H, #'A'
mov 39H, #'K'
mov 3AH, #'U'
mov 3BH, #'B'
mov 3CH, #0 ;end of line

;labels definitions
LCD_RS EQU P3.0 ;RS pin
LCD_E EQU P3.1 ;E pin
LCD_BUS EQU P1 ;DB pins from P1.0 to P1.7

;send 0 to LCD_RS
clr LCD_RS

;BEGIN initialization
lcall delay_ms

mov LCD_BUS, #00111000B ;function set
lcall send_command
lcall delay_us
mov LCD_BUS, #00001110B ;display ON/OFF control
lcall send_command
lcall delay_us
mov LCD_BUS, #00000001B ;display clear
lcall send_command
lcall delay_ms
mov LCD_BUS, #00000110B ;entry mode set

;END initialization 
;send 300183
mov R1, #30H ;start at the location 30H

lcall go_to_position5
lcall short_delay

setb LCD_RS
lcall loop

send_name:
clr LCD_RS

mov R1, #37H ;start at the location 37H

lcall go_to_position2
lcall short_delay

setb LCD_RS
lcall loop2

loop:
	mov A, @R1
	jz send_name
	lcall send_data
	inc R1
	jmp loop

loop2:
	mov A, @R1
	jz finish
	lcall send_data
	inc R1
	jmp loop2

finish:
	jmp $ ;infinite loop, jmp to yourselve

go_to_position5:
	clr LCD_RS
	mov LCD_BUS, #10000100B 

	setb LCD_E
	clr LCD_E
ret

go_to_position2:
	clr LCD_RS
	mov LCD_BUS, #11000001B

	setb LCD_E
	clr LCD_E
ret

send_command: ;send 1 to LCD_E and then 0
	setb LCD_E
	clr LCD_E
ret

send_data: ;nearly identical to send_command, differs only with RS pin
	mov LCD_BUS, A
	setb LCD_E ;negative edge on E
	clr LCD_E
	lcall short_delay
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


