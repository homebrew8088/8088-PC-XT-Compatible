INT09:
	PUSH AX			;STORE AX
	PUSH BX			;STORE BX
	PUSH DS			;STORE DS
	PUSH CS
	POP DS

	MOV AH, 0X00	;CLEAR AH
	IN AL, 0X60		;GET SCANCODE
	CMP AL, 0XE0	;EXTENDED
	JZ .END			;DO NOTHING FOR NOW
	CMP AL, 0X80	;BREAK CODES
	JAE .END		;DO NOTHING FOR NOW
	
	MOV BX, AX		;SET INDEX
	MOV AH, AL		;SCAN CODE TO UPPER
	MOV AL, [BX+.CHARACTER_CODE_UPPER_CASE]
	PUSH AX			;STORE SCAN CODE/ CHAR CODE
		
	MOV AX, 0X0040	;BIOS DATA SEGMENT 
	MOV DS, AX		;SET DATA SEGMENT
	MOV BX, [0X001C];KEYBOARD HEAD LOCA
	POP AX			;GET SCAN CODE/ CHAR CODE
	
	MOV [BX], AX		;STORE IN KEYBOARD BUFFER
	ADD BX, 0X02		;INC TWICE
	CMP BX, [0X0082]	;CHECK TO SEE IF ATT END OF BUFFER
	JB .NOT_END_OF_BUFFER;JUMP OVER NEXT STEP IF NOT AT END
	MOV BX, [0X0080]	;SET INDEX TO BEGINING  
    .NOT_END_OF_BUFFER:
	MOV [0X001C], BX	;STORE NEW  LOCATION
	
	
	
	JMP .END

	
.END:
	POP DS			;RESTORE DS
	POP BX			;RESTORE BX
	MOV AL, 0x20		;END OF INTERRUPT
	OUT 0x20, AL	
	POP AX
	IRET	

.CHARACTER_CODE_UPPER_CASE:
DB 0X00, 0X1B, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '_', '+', 0X08, 0X09	;0X0_
DB 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', 0X0D, 0X00, 'A', 'S'	;0X1_
DB 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', 0X27, '~', 0X00, 0X5C, 'Z', 'X', 'C', 'V'	;0X2_
DB 'B', 'N', 'M', '<', '>', '?', 0X00, '*', 0X00, ' ', 0X00
	
.FILL:
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00

DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00

DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00

DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00

DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00

DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
DB 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00, 0X00
