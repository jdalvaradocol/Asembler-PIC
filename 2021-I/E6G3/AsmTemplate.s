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
#define     Z	    2
#define     CD	    1
#define     C	    0
  
R1	    EQU	    20H
R2	    EQU	    21H
R3	    EQU	    22H
R4	    EQU	    23H

	    ORG     00H
	    GOTO    CONFIG_PT
	    ORG     05H

// Decodificador de binario a 7 segmentos.
// Para los numeros de 0 a 9.        
// PORTA ENTRADA
// PORTD SALIDA
 
// TRIS bit = 1 entrada
// TRIS bit = 0 salida
    
    // seleccionar el banco 1
CONFIG_PT:  BCF     STATUS,RP1  // RP1 = 0
	    BSF     STATUS,RP0 // RP0 = 1

	   // PORTA entrada.
	    MOVLW   0x07
	    MOVWF   ADCON1      
	    MOVLW   0x3F
	    MOVWF   TRISA

	    // PORTD salida.
	    CLRF    TRISC
	    CLRF    TRISD

	    // seleccionar el banco 0    
	    BCF     STATUS,RP1  // RP1 = 0
	    BCF     STATUS,RP0 // RP0 = 0

	    CLRF    PORTC
	    CLRF    PORTD

INICIO:     CALL    DISPLAY
	    MOVWF   PORTC
	    MOVWF   PORTD
	    GOTO    INICIO

DISPLAY:    MOVLW   0
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x40   

	    MOVLW   1
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x79   

	    MOVLW   2
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x24   

	    MOVLW   3
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x30   

	    MOVLW   4
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x19   

	    MOVLW   5
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x12   

	    MOVLW   6
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x02   

	    MOVLW   7
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x78   

	    MOVLW   8
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x00   

	    MOVLW   9
	    XORWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x10   
	    RETLW   0xFF   
        
//  0  1  2  3  4  5  6  7  8  9
// 40 79 24 30 19 12 02 78 00 10

DELAY:    MOVLW    0xFF 
	  MOVWF    R1
   
LOOP2:    MOVLW    0xFF 
	   MOVWF    R2
   
LOOP1:    DECFSZ   R2,F
	  GOTO     LOOP1

	  DECFSZ   R1,F
	  GOTO     LOOP2
	  RETURN

	  END