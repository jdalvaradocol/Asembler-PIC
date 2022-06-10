
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

VAR	    EQU	    20H  
i	    EQU	    21H  
j	    EQU	    22H  
	    
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
	    
	    BCF	    STATUS,RP0
	    BCF	    STATUS,RP1	; Seleccionamos el banco 0

; Inicio del programa (main)	    
	    
INICIO:	    
	    ; Rutina para evaluar si la entrada (PORTA) es igual a 0
    
	    CLRW		    ; Se asigna 0 a W
	    SUBWF   PORTA,W	    ; Se realiza la resta entre W = PORTA - W 
	    BTFSS   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    GOTO    NO_CERO	    ; Si el numero no es igual a 0 salta a la etiqueta NO_CERO	    
	    GOTO    SI_CERO	    ; Si el numero es igual a 0 salta a la etiqueta SI_CERO

	    ; Rutina para evaluar si la entrada (PORTA) es igual a 1
	    
NO_CERO:    MOVLW   0x01	    ; Se asigna 1 a W
	    SUBWF   PORTA,W	    ; Se realiza la resta entre W = PORTA - W
	    BTFSS   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    GOTO    NO_UNO	    ; Si el numero no es igual a 1 salta a la etiqueta NO_UNO
	    GOTO    SI_UNO	    ; Si el numero es igual a 1 salta a la etiqueta SI_UNO

	    ; Rutina para evaluar si la entrada (PORTA) es igual a 2
	    
NO_UNO:	    MOVLW   0x02	    ; Se asigna 2 a W
	    SUBWF   PORTA,W	    ; Se realiza la resta entre W = PORTA - W
	    BTFSS   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    GOTO    NO_DOS	    ; Si el numero no es igual a 2 salta a la etiqueta NO_DOS
	    GOTO    SI_DOS	    ; Si el numero es igual a 2 salta a la etiqueta SI_DOS

	    ; Rutina para evaluar si la entrada (PORTA) es igual a 1
	    
NO_DOS:	    MOVLW   0x03	    ; Se asigna 3 a W
	    SUBWF   PORTA,W	    ; Se realiza la resta entre W = PORTA - W
	    BTFSS   STATUS,Z	    ; Se evalua el estado del bit Z del registro STATUS
	    GOTO    INICIO	    ; Si el numero no es igual a 3 salta a la etiqueta INICIO
	    GOTO    SI_TRES	    ; Si el numero es igual a 3 salta a la etiqueta SI_TRES
	    
	    ; Si la entrada (PORTA) es igual a 0 se realiza la siguiente rutina.	    

SI_CERO:    MOVLW   0x01	    ; Se asigna W = 1
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 1
	    CALL    DELAY	    ; Se llama a la funcion Delay (retardo) para que se pueda visulizar la rutina   
	    MOVLW   0x02	    ; Se asigna W = 2
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 2
	    CALL    DELAY	    ; Se llama a la funcion Delay (retardo) para que se pueda visulizar la rutina.
	    MOVLW   0x04	    ; Se asigna W = 4
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 4
	    CALL    DELAY	    ; Se llama a la funcion Delay (retardo) para que se pueda visulizar la rutina.
	    MOVLW   0x08	    ; Se asigna W = 8
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 8
	    CALL    DELAY	    ; Se llama a la funcion Delay (retardo) para que se pueda visulizar la rutina.
	    CLRF    PORTB	    ; Se borra el PORTB = W = 8
	    GOTO    INICIO	    ; Finaliza la rutina y se salta a la etiqueta INICIO
	    
	    ; Si la entrada (PORTA) es igual a 1 se realiza la siguiente rutina.	    
	    
SI_UNO:	    MOVLW   0x0C	    ; Se asigna W = 12
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 12
	    GOTO    INICIO	    ; Finaliza la rutina y se salta a la etiqueta INICIO

	    ; Si la entrada (PORTA) es igual a 2 se realiza la siguiente rutina.	    

SI_DOS:	    MOVLW   0x09	    ; Se asigna W = 9
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 9
	    GOTO    INICIO	    ; Finaliza la rutina y se salta a la etiqueta INICIO
	    
	    ; Si la entrada (PORTA) es igual a 3 se realiza la siguiente rutina.	    
	    
SI_TRES:    MOVLW   0x06	    ; Se asigna W = 6
	    MOVWF   PORTB	    ; Se asigna PORTB = W = 6
	    GOTO    INICIO	    ; Finaliza la rutina y se salta a la etiqueta INICIO	    

; La siguiente rutina realza una fucncion de un retardo o espera para ajustra la
; frecuencia de operacaion del microcontrolador. 	    

; Para una frecuencia de 4M Hz el retardo por software es aprox. 196.865 mS
; Para i = 255 y j = 255.	    
	    
; El siguiente retardo (Delay) tiene la sigueinte estructura.
; for (i=0;i<255;i++)
; {
     ;for (j=0;j<255;j++)	    
; }
    
DELAY:	    MOVLW   0xFF	   ; Se asigna W = 255							    "1uS"
	    MOVWF   i		   ; Se asigna i = W = 255						    "1uS" 
	    
LOOPi:	    DECFSZ  i,F		   ; Se realiza la operacion i = i - 1					    1us
	    GOTO    LOOPj	   ; Si la resta no es igual a 0 se relizara salata a la rutina LOOPj	    2us		    
	    RETURN		   ; Si la resta es igual a 0 se finaliza la rutina y			    "1uS"
				   ; retorna una instruccion despues de donde fue llamado (CALL DELAY)	    "2uS"	

LOOPj:	    MOVLW   0xFF	   ; Se asigna W = 255							    1us
    	    MOVWF   j		   ; Se asigna i = W = 255						    1us
    
LOOP:	    DECFSZ  j,F		   ; Se realiza la operacion i = i - 1					    1us
	    GOTO    LOOP	   ; Si la resta no es igual a 0 se relizara la rutina LOOPj		    2us 
	    GOTO    LOOPi	   ; Si la resta es igual a 0 se finaliza la rutina y			    '2u5' 
	    
	    END
	