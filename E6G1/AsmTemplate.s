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
#define     DC	    1
#define     C	    0
  
R1	    EQU	    20H
R2	    EQU	    21H
R3	    EQU	    22H
R4	    EQU	    23H

	    ORG     00H
	    GOTO    CONFIG_PT
	    ORG     05H
        
// PORTA ENTRADA
// PORTB SALIDA
 
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

	   // PORTB salida.
	    CLRF    TRISB

	    // seleccionar el banco 0    
	    BCF     STATUS,RP1  // RP1 = 0
	    BCF     STATUS,RP0 // RP0 = 0

	    CLRF    PORTB

// 1. Realizar dos secuencias de leds diferentes.     
// a. cuando RA0 = 1 secuencia 1.
// b. cuando RA3 = 1 secuencia 2.
// c. cuando RA0 = 0 y RA3 = 0 leds apagados.
// d. cuando RA0 = 1 y RA3 = 1 leds apagados.
      
INICIO:     CLRF    PORTB
	    BTFSS   PORTA,0
	    GOTO    SIG1
	    GOTO    SEC1

SIG1:	    BTFSS   PORTA,3
	    GOTO    INICIO
	    GOTO    SEC2
    
SEC1:	    BTFSC   PORTA,3
	    GOTO    INICIO
	    MOVLW   0x01
	    MOVWF   PORTB
	    CALL    DELAY
	    MOVLW   0x02
	    MOVWF   PORTB
	    CALL    DELAY
	    MOVLW   0x04
	    MOVWF   PORTB
	    CALL    DELAY
	    MOVLW   0x08
	    MOVWF   PORTB
	    CALL    DELAY
	    GOTO    INICIO
    
SEC2:	    BTFSC   PORTA,0
	    GOTO    INICIO
	    MOVLW   0x01
	    MOVWF   PORTB
	    CALL    DELAY
	    MOVLW   0x03
	    MOVWF   PORTB
	    CALL    DELAY
	    MOVLW   0x07
	    MOVWF   PORTB
	    CALL    DELAY
	    MOVLW   0x0F
	    MOVWF   PORTB
	    CALL    DELAY  
	    GOTO    INICIO     
    
// for(i=0;i<255;i++) 0 --> 255  R1 = i     
//  for(j=0;j<255;j++) 0 --> 255 R2 = j     
    
DELAY:	    MOVLW    0xFF 
	    MOVWF    R1
   
LOOP2:	    MOVLW    0xFF 
	    MOVWF    R2
   
LOOP1:	    DECFSZ   R2,F
	    GOTO     LOOP1

	    DECFSZ   R1,F
	    GOTO     LOOP2
	    RETURN

	    END