; PIC16F877A Configuration Bit Settings
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
; Assembly source line config statements

	processor	16F877A     
    
#include <xc.inc>    
PSECT	code   
    
; CONFIG
  CONFIG  FOSC	= XT            ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE	= OFF           ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF           ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP	= OFF           ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD	= OFF           ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT	= OFF           ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP	= OFF           ; Flash Program Memory Code Protection bit (Code protection off)

#define	    RP1	    6
#define	    RP0	    5
#define	    Z	    2
#define	    DC	    1
#define	    C	    0
  
REG1		EQU	    20H
REG2		EQU	    21H	    
VAR		EQU	    22H
CONTA		EQU	    23H
CONTB		EQU	    24H
REPETIR		EQU	    25H
		
		ORG	00H
		GOTO	CONFIG_INI
		ORG	05H


// Visualizacion dinamica dos displays. 
		
// PORTB salida.
// PORTC salida.
// PORTD salida.
		
		// Seleccionamos banco 01
CONFIG_INI:	BCF	STATUS,RP1  // RP1 = 0
		BSF	STATUS,RP0  // RP0 = 1 
						
		// Puerto B, C y D como salida
		CLRF	TRISB
		CLRF	TRISC
		CLRF	TRISD

		// Seleccionamos banco 00
		BCF	STATUS,RP1  // RP1 = 0
		BCF	STATUS,RP0  // RP0 = 0

		CLRF	PORTC
		CLRF	PORTD
		CLRF	PORTB
		CLRF	CONTA
		CLRF	CONTB
		
INICIO:		CALL	VISULIZAR 
		INCF	CONTA,F
		MOVLW	9
		SUBWF	CONTA,W
		BTFSS	STATUS,Z
		GOTO	INICIO
		CLRF	CONTA
		
		INCF	CONTB,F
		MOVLW	9
		SUBWF	CONTB,W
		BTFSS	STATUS,Z
		GOTO	INICIO
		CLRF	CONTB
			
		GOTO	INICIO
		
VISULIZAR:	MOVLW	0xFF
		MOVWF	REPETIR	
		
LOOP_REP:	MOVF	CONTA,W
		CALL	DISPLAY
		MOVWF	PORTD
		MOVLW	0x01
		MOVWF	PORTC
		CALL	RETARDO
		
		MOVF	CONTB,W
		CALL	DISPLAY
		MOVWF	PORTD
		MOVLW	0x02
		MOVWF	PORTC
		CALL	RETARDO

		DECFSZ	REPETIR,F
		GOTO	LOOP_REP
		RETURN

DISPLAY:        MOVWF   VAR
		MOVLW   0
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xBF   

		MOVLW   1
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0x86   

		MOVLW   2
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xDB   

		MOVLW   3
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xCF   

		MOVLW   4
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xE6   

		MOVLW   5
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xED   

		MOVLW   6
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xFD   

		MOVLW   7
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0x87   

		MOVLW   8
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xFF   

		MOVLW   9
		XORWF   VAR,W
		BTFSC   STATUS,Z
		RETLW   0xEF   
		RETLW   0x00  		
		
RETARDO:	MOVLW	0x02
		MOVWF	REG1
		
LOOP1:		MOVLW	0xFF
		MOVWF	REG2

LOOP2:		DECFSZ	REG2,F
		GOTO	LOOP2
		
		DECFSZ	REG1,F
		GOTO	LOOP1
		RETURN
		
		END