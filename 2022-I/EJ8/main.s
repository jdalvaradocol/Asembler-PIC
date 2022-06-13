
	    PROCESSOR   16F877A

; PIC16F877A Configuration Bit Settings

; Assembly source line config statements

#include <xc.inc>
PSECT code	
	
; CONFIG
  CONFIG  FOSC	= XT             ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE	= OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF		 ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF            ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP	= OFF            ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD	= OFF            ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT	= OFF            ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP	= OFF            ; Flash Program Memory Code Protection bit (Code protection off)
  
#define	    RP1	    6
#define	    RP0	    5
#define	    Z	    2
#define	    DC	    1
#define	    C	    0  

DATO_DIS    EQU	    20H  
i	    EQU	    21H  
j	    EQU	    22H  
CONT_U	    EQU	    23H  
CONT_D	    EQU	    24H  
VIS	    EQU	    25H  
	    
	    ORG	    0x00	; Reset Vector
	    GOTO    PUERTOS
	    ORG	    0x04	; Interrupt Vector

PUERTOS:    BSF	    STATUS,RP0
	    BCF	    STATUS,RP1	; Seleccionamos el banco 1
	    
	    MOVLW   0x06	; Se asigna 6 a W
	    MOVWF   ADCON1	; Se configuran el Puerto A y E como I/O digitales.
	    
	    MOVLW   0x3F
	    MOVWF   TRISA	; Configuro el PORTA como entrada
	    
	    CLRF    TRISB	; Configuro el PORTB como salida
	    CLRF    TRISC	; Configuro el PORTC como salida
	    CLRF    TRISD	; Configuro el PORTD como salida
	    
	    BCF	    STATUS,RP0
	    BCF	    STATUS,RP1	; Seleccionamos el banco 0
	    
	    CLRF    CONT_U	; CONT_U = 0
	    CLRF    CONT_D	; CONT_D = 0
	    CLRF    PORTB	; PORTB = 0
	    CLRF    PORTC	; PORTC = 0
	    COMF    PORTC	; PORTC = FF
	    CLRF    PORTD	; PORTD = 0
	    COMF    PORTD	; PORTC = FF
	    
	    ; Inicio del programa (main)	    
	    
INICIO:	    CALL    VISUALIZAR
	    INCF    CONT_U,F	    
	    MOVLW   10
	    SUBWF   CONT_U,W
	    BTFSS   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    GOTO    INICIO
	    CLRF    CONT_U
	    INCF    CONT_D,F
	    MOVLW   6
	    SUBWF   CONT_D,W
	    BTFSS   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    GOTO    INICIO
	    CLRF    CONT_D	    
	    GOTO    INICIO
	    
VISUALIZAR: MOVLW   25
	    MOVWF   VIS
	    
LOOPV:	    MOVLW   2
	    MOVWF   PORTC
	    MOVF    CONT_D,W
	    CALL    DISPLAY
	    MOVWF   PORTD
	    CALL    DELAY
    
	    MOVLW   1
	    MOVWF   PORTC
	    MOVF    CONT_U,W
	    CALL    DISPLAY
	    MOVWF   PORTD
	    CALL    DELAY
	    
	    DECFSZ  VIS,F
	    GOTO    LOOPV
	    RETURN
	    
DISPLAY:    MOVWF   DATO_DIS
	    
	    ; Se evalua si la entrada es igual a 0
	    ; si es 0 se asigna el valor para visualizar
	    ; el dato en el display
	   	    
	    CLRW		    ; Se asigna W = 0    
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xBF	    ; el numero es igual a 0 retorna con W = 0xBF

	    ; Se evalua si la entrada es igual a 1
	    ; si es 1 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x01	    ; Se asigna W = 1
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0x86	    ; el numero es igual a 1 retorna con W = 0x86
	    
	    ; Se evalua si la entrada es igual a 2
	    ; si es 2 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x02	    ; Se asigna W = 2
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xDB	    ; el numero es igual a 1 retorna con W = 0xDB

	    ; Se evalua si la entrada es igual a 3
	    ; si es 3 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x03	    ; Se asigna W = 3
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xCF	    ; el numero es igual a 1 retorna con W = 0xCF

	    ; Se evalua si la entrada es igual a 4
	    ; si es 4 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x04	    ; Se asigna W = 4
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xE6	    ; el numero es igual a 1 retorna con W = 0xE6
	    
	    ; Se evalua si la entrada es igual a 5
	    ; si es 5 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x05	    ; Se asigna W = 5
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xED	    ; el numero es igual a 1 retorna con W = 0xED
	  
	    ; Se evalua si la entrada es igual a 6
	    ; si es 6 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x06	    ; Se asigna W = 6
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xFD	    ; el numero es igual a 1 retorna con W = 0xFD
	  
	    ; Se evalua si la entrada es igual a 7
	    ; si es 7 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x07	    ; Se asigna W = 7
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0x87	    ; el numero es igual a 1 retorna con W = 0x87
	  
	     ; Se evalua si la entrada es igual a 8
	    ; si es 8 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x08	    ; Se asigna W = 8
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xFF	    ; el numero es igual a 1 retorna con W = 0xFF
	  
	     ; Se evalua si la entrada es igual a 9
	    ; si es 9 se asigna el valor para visualizar
	    ; el dato en el display
	    
	    MOVLW   0x09	    ; Se asigna W = 9
	    XORWF   DATO_DIS,W	    ; Se realiza la operacion W = DATO_DIS XOR W
	    BTFSC   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    RETLW   0xEF	    ; el numero es igual a 1 retorna con W = 0xEF
	    RETLW   0x00	    ; el numero no esta entre 0 y 9 retorna con W = 0x00
	    
; La siguiente rutina realiza una funcion de un retardo o espera para ajustra la
; frecuencia de operacaion del microcontrolador. 	    

; Para una frecuencia de 4MHz el retardo por software es aprox. 196.865 mS
; Para i = 255 y j = 255.	    
	    
; El siguiente retardo (Delay) tiene la sigueinte estructura.
; for (i=0;i<255;i++)
; {
     ;for (j=0;j<255;j++)	    
; }
    
DELAY:	    MOVLW   20		   ; Se asigna W = 255							    "1uS"
	    MOVWF   i		   ; Se asigna i = W = 255						    "1uS" 
	    
LOOPi:	    DECFSZ  i,F		   ; Se realiza la operacion i = i - 1					    1us
	    GOTO    LOOPj	   ; Si la resta no es igual a 0 se relizara salata a la rutina LOOPj	    2us		    
	    RETURN		   ; Si la resta es igual a 0 se finaliza la rutina y			    "1uS"
				   ; retorna una instruccion despues de donde fue llamado (CALL DELAY)	    "2uS"	

LOOPj:	    MOVLW   170		   ; Se asigna W = 255							    1us
    	    MOVWF   j		   ; Se asigna i = W = 255						    1us
    
LOOP:	    DECFSZ  j,F		   ; Se realiza la operacion i = i - 1					    1us
	    GOTO    LOOP	   ; Si la resta no es igual a 0 se relizara la rutina LOOPj		    2us 
	    GOTO    LOOPi	   ; Si la resta es igual a 0 se finaliza la rutina y			    '2u5' 
	    
	    END
	