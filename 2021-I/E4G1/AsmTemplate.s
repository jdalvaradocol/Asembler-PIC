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


REG1		EQU     20H
REG2		EQU     21H     
  
		ORG     00H
		GOTO    CONFIG_INI
		ORG	05H

// PORTA ENTRADA
// PORTB ENTRADA
// PORTC SALIDA
// PORTD SALIDA
// bit = 1 Entrada
// bit = 0 Salida

CONFIG_INI: // Seleccionamos banco 01
		BCF	STATUS,RP1  // RP1 = 0
		BSF	STATUS,RP0  // RP0 = 1 

		// Puerto A como entrada
		MOVLW	0x06
		MOVWF	ADCON1
		MOVLW	0x3F
		MOVWF	TRISA

		// Puerto B como entrada
		MOVLW	0xFF
		MOVWF	TRISB

		// Puerto C y D como salida

		CLRF	TRISC
		CLRF	TRISD

		// Seleccionamos banco 00
		BCF	STATUS,RP1  // RP1 = 0
		BCF	STATUS,RP0  // RP0 = 0

		CLRF	PORTC
		CLRF	PORTD

// PORTC = PORTB + PORTA
// W = W + PORTB
// PORTC = W --> PORTC = PORTB + PORTA


//  R = SUMA ES MAYOR QUE 255
//  R = SUMA ES MENOR QUE 255

// STATUS = ??? C - DC - Z

INICIO:		MOVF	PORTA,W     // W = PORTA
		ADDWF	PORTB,W     // W = W + PORTB
		MOVWF	PORTC     // PORTC = W --> PORTC = PORTB + PORTA

//  R = RESTA ES NEGATIVA 
//  R = RESTA ES POSITIVA 

// STATUS = ??? C - DC - Z

// PORTD = PORTB - PORTA
// W = PORTA
// SUBWF   F - W
// SUBWF   W = PORTB - W 
// PORTd = W --> PORTD = PORTD + PORTD

		MOVF	PORTA,W     // W = PORTA
		SUBWF	PORTB,W     // W = PORTB - W
		MOVWF	PORTD     // PORTD = W --> PORTD = PORTB - PORTA

// AND -- XOR -- OR
// PORTC = PORTB AND PORTA
// PORTD = PORTB XOR PORTA
// PORTC = PORTB OR PORTA

		GOTO	INICIO

		END