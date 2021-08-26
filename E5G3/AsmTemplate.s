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

// 1. Realizar tres secuencias de leds 
//    diferentes. X = A      
// a. Cuando RX0 = 1 secuencia 1.
// b. Cuando RX3 = 1 secuencia 2.
// c. Cuando RX0 = 0, RX3 = 0  leds apagados.
// d. Cuando existen dos o más entradas en 
//    estado activo los leds deben estar 
//    apagados.

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

INICIO:	    CLRF    PORTB
	    BTFSS   PORTA,0
	    GOTO    SIG1
	    GOTO    SEC1

SIG1:	    BTFSS   PORTA,3
	    GOTO    INICIO
	    GOTO    SEC2

SEC1:	    BTFSC   PORTA,3
	    GOTO    INICIO
	    MOVLW   0x08
	    MOVWF   PORTB
	    CALL    RETARDO
	    MOVLW   0x04
	    MOVWF   PORTB
	    CALL    RETARDO
	    MOVLW   0x02
	    MOVWF   PORTB
	    CALL    RETARDO
	    MOVLW   0x01
	    MOVWF   PORTB
	    CALL    RETARDO
	    GOTO    INICIO

SEC2:	    BTFSC   PORTA,0
	    GOTO    INICIO
	    MOVLW   0x08
	    MOVWF   PORTB
	    CALL    RETARDO
	    MOVLW   0x0C
	    MOVWF   PORTB
	    CALL    RETARDO
	    MOVLW   0x0E
	    MOVWF   PORTB
	    CALL    RETARDO
	    MOVLW   0x0F
	    MOVWF   PORTB
	    CALL    RETARDO
	    GOTO    INICIO

// for(i = 0; i < 255 ; i++)
// for(j = 0; j < 255 ; j++)

RETARDO:    MOVLW   0xFF
	    MOVWF   REG1

LOOP1:	    MOVLW   0xFF
	    MOVWF   REG2

LOOP2:	    DECFSZ  REG2,F
	    GOTO    LOOP2

	    DECFSZ  REG1,F
	    GOTO    LOOP1
	    RETURN

	    END