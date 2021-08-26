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


#define     RP0     5
#define     RP1     6
  
  
	    ORG	    00H
	    GOTO    CONFIG_INI
	    ORG	    05H


CONFIG_INI: // Seleccionamos banco 01
	    BCF	    STATUS,RP1  // RP1 = 0
	    BSF	    STATUS,RP0  // RP0 = 1 
    
// bit = 1 Entrada
// bit = 0 Salida

// Puerto A como entrada
    
// RA7 - RA6 - RA5 - RA4 - RA3 - RA2 - RA1 - RA0
// X=0 - X=0 -   1 -   1 -   1 -   1 -   1 -  1 = 0x3F

	    MOVLW   0x06
	    MOVWF   ADCON1

	    MOVLW   0x3F
	    MOVWF   TRISA

// Puerto B como salida

// RB7 - RB6 - RB5 - RB4 - RB3 - RB2 - RB1 - RB0
//   0 -   0 -   0 -   0 -   0 -   0 -   0 -  0 = 0x00

	    MOVLW   0x00
	    MOVWF   TRISB

// Puerto C 4 bits entrada  RC0 - RC3
// Puerto C 4 bits salida   RC4 - RC7

// RC7 - RC6 - RC5 - RC4 - RC3 - RC2 - RC1 - RC0
//   0 -   0 -   0 -   0 -   1 -   1 -   1 -  1 = 0x0F

	    MOVLW   0x0F
	    MOVWF   TRISC

	    // Seleccionamos banco 00
	    BCF	    STATUS,RP1  // RP1 = 0
	    BCF	    STATUS,RP0  // RP0 = 0

// PORTB = PORTA. --> 1. W = PORTA. 2. PORTB = W.

INICIO:	    MOVF    PORTA,W
	    MOVWF   PORTB
	    GOTO    INICIO

	    END