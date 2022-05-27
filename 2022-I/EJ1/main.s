
        PROCESSOR   16F877A

#include <xc.inc>
PSECT code
		
R1	EQU	20H	; Declarar R1
R2	EQU	21H	; Declarar R2
R3	EQU	22H	; Declarar R3
R4	EQU	23H	; Declarar R4
	
	ORG	0x00	; Reset Vector
	GOTO	CODIGO
	ORG	0x04	; Interrupt Vector

	; 5.	L -> W -> R1
CODIGO:	MOVLW	0x0A	; W = 10
	MOVWF	R1	; R1 = W = 10
	; 6.	L -> W -> R2
	MOVLW	0x14	; W = 20
	MOVWF	R2	; R2 = W = 20
	; 7.	L -> W -> R3
	MOVLW	0x1E	; W = 30
	MOVWF	R3	; R3 = W = 30
	; 8.	R1 -> W
	MOVF	R1,W
	; 9.	R2 + W = W
	ADDWF	R2,W
	; 10.	R3 + W = W
	ADDWF	R3,W
	; 11.	R4 = 4
	MOVWF	R4
	
	CLRF	R1
	CLRF	R2
	CLRF	R3
	CLRF	R4
	CLRW	
	
	GOTO	CODIGO
	
	
	
	END
	