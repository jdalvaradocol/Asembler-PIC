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

// 1. Realizar un algoritmo para saber si el 
// dato de entrada es igual a un número específico.
// a. Si el número es igual se debe activar 
// el led 0 y apagar el led 1.
// b. Si el número es diferente se debe activar
// el led 1 y apagar el led 0.

// PORTA ENTRADA
// PORTB SALIDA

// Seleccionamos banco 01
CONFIG_INI: BCF	    STATUS,RP1  // RP1 = 0
	    BSF	    STATUS,RP0  // RP0 = 1 

	    // Puerto A como entrada
	    MOVLW   0x06
	    MOVWF   ADCON1
	    MOVLW   0x3F
	    MOVWF   TRISA
	    // Puerto B como entrada
	    CLRF    TRISB
	    // Seleccionamos banco 00
	    BCF	    STATUS,RP1  // RP1 = 0
	    BCF	    STATUS,RP0  // RP0 = 0
	    
	    CLRF    PORTB

// XORWF W == F
// Z = 0 Diferentes.
// Z = 1 Iguales.

INICIO:	    MOVLW	0x08 // W = 8 
	    XORWF	PORTA,W // W xor F   
	    BTFSS	STATUS,Z
	    GOTO	DIFERENTES  // Z = 0 ejecuta este comando 
	    GOTO	IGUAL     // Z = 1 ejecuta este comando

IGUAL:	    BSF	PORTB,0
	    BCF	PORTB,1
	    GOTO	INICIO

DIFERENTES: BCF	    PORTB,0
	    BSF	    PORTB,1
	    GOTO    INICIO

	    END