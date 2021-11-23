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
        
// 1.      Realizar un algoritmo para saber si el dato de entrada es igual a un número específico.
// a.      Si el numero es igual se debe activar el led 0 y apagar el led 1.
// b.      Si el numero es diferente se debe activar el led 1 y apagar el led 0.     

// NUMERO DE COMPARACION EN 10     
// Z = 1 Operacaion es igual a 0. 
// Z = 0 Operacaion no es igual a 0.
// Operacaiones aritmeticas y logicas.
// RESTA.     
    
INICIO:     CLRF    PORTB
	    MOVLW   10 // W = 10
	    SUBWF   PORTA,W // W = PORTA - W

	    BTFSS   STATUS,Z
	    GOTO    NOIGUAL // EJECUTA LA SIG INT 0 Z = 0
	    GOTO    IGUAL // SALTA A LA SIG INT 1 Z = 1
    
NOIGUAL:    BSF     PORTB,0
	    BCF     PORTB,1
	    GOTO    INICIO
    
IGUAL:     BCF      PORTB,0
	    BSF     PORTB,1
	    GOTO    INICIO

	    END