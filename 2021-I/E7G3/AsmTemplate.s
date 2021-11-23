; PIC16F877A Configuration Bit Settings

; Assembly source line config statements
 
	processor   16F877A
    
#include <xc.inc>
PSECT	code
; CONFIG
  CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF           ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP = OFF             ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT = OFF             ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)

#define	    RP0	    5  
#define	    RP1	    6
#define	    Z	    2
#define	    DC	    1
#define	    C	    0
  
R1	EQU	20H
R2	EQU	21H
R3	EQU	22H
DATO	EQU	23H
VAR1	EQU	24H
VAR2	EQU	25H
		
	    ORG	    00H
	    GOTO    CONFIG_PT
	    ORG	    05H
	    
// Visulizacion dinamica display 7 segmentos.
// dos digitos	    
 
// TRIS bit = 1 entrada
// TRIS bit = 0 salida
	    
	    // seleccionar el banco 1
CONFIG_PT:  BCF	    STATUS,RP1  // RP1 = 0
	    BSF	    STATUS,RP0	// RP0 = 1
	    
    	    // PORTD salida.
	    CLRF    TRISB
	    CLRF    TRISC
	    CLRF    TRISD
	    
	    // seleccionar el banco 0    
	    BCF	    STATUS,RP1  // RP1 = 0
	    BCF	    STATUS,RP0	// RP0 = 0
	    
	    CLRF   PORTB
	    CLRF    PORTD
	    CLRF    VAR1
	    CLRF    VAR2

INICIO:	    MOVLW   4
	    CALL    DISPLAY
	    MOVWF   PORTD
	    MOVLW   1
	    MOVWF   PORTC
	    CALL    DELAY
	    
	    MOVLW   8
	    CALL    DISPLAY
	    MOVWF   PORTD
	    MOVLW   2
	    MOVWF   PORTC
	    CALL    DELAY
	    
	    GOTO    INICIO

DISPLAY:    MOVWF   DATO
	    MOVLW   0
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xBF   
	    
	    MOVLW   1
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x86   
	    
	    MOVLW   2
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xDB   
	    
	    MOVLW   3
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xCF   
	    
	    MOVLW   4
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xE6   
	    
	    MOVLW   5
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xED   
	    
	    MOVLW   6
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xFD   
	    
	    MOVLW   7
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x87   
	    
	    MOVLW   8
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xFF   
	    
	    MOVLW   9
	    XORWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0xEF   
	    RETLW   0x00   
   	    
DELAY:	    MOVLW	0x02
	    MOVWF	R1
		
LOOP1:	    MOVLW	0xFF
	    MOVWF	R2

LOOP2:	    DECFSZ	R2,F
	    GOTO	LOOP2
		
	    DECFSZ	R1,F
	    GOTO	LOOP1
	    RETURN

	    END

