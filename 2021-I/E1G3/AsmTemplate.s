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


R1 	EQU 	20H
R2 	EQU 	21H
R3 	EQU 	22H
R4 	EQU 	23H

// R1 = 10, R2 = 20, R3 = 40
// R1 = R3 - R2 
// R2 = R1 + R3   

    		ORG     00H
    		GOTO    INICIO
		ORG     05H

INICIO: 	MOVLW   10     // W = 10
	   	MOVWF   R1      // R1 = W = 10
    
   		MOVLW   20     // W = 20
  		MOVWF   R2     // R2 = W = 20
    
  		MOVLW   40     // W = 40
  		MOVWF   R3     // R3 = W = 40
    
   		MOVF    R2,W    // W = R2 = 20
    
    		SUBWF   R3,W    // W = W - R2 = 40 - 20 = 20
    
    		MOVWF   R1     // R1 = W = 20
    
    		ADDWF   R3,W    // W = W + R3
    
    		MOVWF   R2     // R2 = W
    
    		CLRF    R1
    		CLRF    R2
    		CLRF    R3
    		CLRW
    
    		GOTO    INICIO
    
    		END