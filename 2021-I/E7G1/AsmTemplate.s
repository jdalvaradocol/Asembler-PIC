; PIC16F877A Configuration Bit Settings
; Assembly source line config statements


	processor 16F877A     
    
#include <xc.inc>    
PSECT code   
    
; CONFIG
  CONFIG  FOSC = XT            ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE = OFF           ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF           ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP = OFF           ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF           ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT = OFF           ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP = OFF           ; Flash Program Memory Code Protection bit (Code protection off)

#define     RP1     6
#define     RP0     5
#define     Z	    2
#define     DC	    1
#define     C	    0
  
REG1	    EQU     20H
REG2	    EQU     21H     
  
	    ORG	    00H
	    GOTO    CONFIG_INI
	    ORG	    05H

// Leer un numero de 0 a 15 en el puerto
// entrada y visualizarlo en el display 
// de 7 segmentos.

// PORTA ENTRADA
// PORTC SALIDA
// PORTD SALIDA

// Seleccionamos banco 01
CONFIG_INI: BCF	    STATUS,RP1  // RP1 = 0
	    BSF	    STATUS,RP0  // RP0 = 1 

	    // Puerto A como entrada
	    MOVLW   0x06
	    MOVWF   ADCON1
	    MOVLW   0x3F
	    MOVWF   TRISA

	    // Puerto C como entrada
	    CLRF    TRISC
	    CLRF    TRISD
	    // Seleccionamos banco 00
	    BCF	    STATUS,RP1  // RP1 = 0
	    BCF	    STATUS,RP0  // RP0 = 0

	    CLRF    PORTC
	    CLRF    PORTD

INICIO:	    CALL    DISPLAY
	    MOVWF   PORTC
	    MOVWF   PORTD
	    GOTO    INICIO

//  0  1  2  3  4  5  6  7  8  9 
// 40 79 24 30 19 12 02 78 00 10

DISPLAY:    MOVLW   0x00
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x40
	    MOVLW   0x01
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x79
	    MOVLW   0x02
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x24
	    MOVLW   0x03
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x30
	    MOVLW   0x04
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x19
	    MOVLW   0x05
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x12
	    MOVLW   0x06
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x02
	    MOVLW   0x07
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x78
	    MOVLW   0x08
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x00
	    MOVLW   0x09
	    SUBWF   PORTA,W
	    BTFSC   STATUS,Z
	    RETLW   0x10
	    RETLW   0xFF

// 40 79 24 30 19 12 2 78 0 10
// for(i = 0; i < 255 ; i++)
// for(j = 0; j < 255 ; j++)

RETARDO:    MOVLW   0x01
	    MOVWF   REG1

LOOP1:	    MOVLW   0x01
	    MOVWF   REG2

LOOP2:	    DECFSZ  REG2,F
	    GOTO    LOOP2

	    DECFSZ  REG1,F
	    GOTO    LOOP1
	    RETURN

	    END