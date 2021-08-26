; PIC16F877A Configuration Bit Settings
; Assembly source line config statements
 
processor   16F877A
    
#include <xc.inc>
PSECT code
; CONFIG
  CONFIG  FOSC = XT             ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF           ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP = OFF             ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT = OFF             ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)

#define     RP0     5  
#define     RP1     6
  
R1	    EQU	    20H
R2	    EQU	    21H
R3	    EQU	    22H
R4	    EQU	    23H

//  PORTB = PORTA. -->  W = PORTA  PORTB = W.

	    ORG     00H
	    GOTO    CONFIG_PT
	    ORG     05H
        
// PORTA PORTB ENTRADA
// PORTC PORTD SALIDA
 
// TRIS bit = 1 entrada
// TRIS bit = 0 salida
    
CONFIG_PT:  // seleccionar el banco 1
    
	    BCF     STATUS,RP1  // RP1 = 0
	    BSF     STATUS,RP0 // RP0 = 1

	    // PORTA y PORTB entrada
	    MOVLW   0x07
	    MOVWF   ADCON1      
	    MOVLW   0x3F
	    MOVWF   TRISA

	    MOVLW   0xFF
	    MOVWF   TRISB
		// PORTC y PORTD salida.    
	    CLRF    TRISC
	    CLRF    TRISD

	    // seleccionar el banco 0    
	    BCF     STATUS,RP1  // RP1 = 0
	    BCF     STATUS,RP0 // RP0 = 0

	    CLRF    PORTC
	    CLRF    PORTD


// PORTC = PORTB + PORTA
// W = PORTB
// W = W + PORTA
// PORTC = W     
    
INICIO:     MOVF    PORTB,W // W = PORTB
	    ADDWF   PORTA,W // W = W + PORTA
	    MOVWF   PORTC // PORTC = W     

// PORTD = PORTB - PORTA
// W = PORTA
// W = PORTB - W 
// PORTD = W     
    
	    MOVF    PORTA,W // W = PORTA
	    SUBWF   PORTB,W // W = PORTB - W
	    MOVWF   PORTD // PORTD = W     

	    GOTO    INICIO

	    END