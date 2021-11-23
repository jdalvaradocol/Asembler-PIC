    
; R1 = 80 
; R2 = 58 
; R3 = R1-R2     

	    PROCESSOR   16F877A

; PIC16F877A Configuration Bit Settings

; Assembly source line config statements

#include <xc.inc>
PSECT code

; CONFIG
  CONFIG  FOSC	= XT      ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE	= OFF     ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF     ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF     ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP	= OFF     ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD	= OFF     ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT	= OFF     ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP	= OFF     ; Flash Program Memory Code Protection bit (Code protection off)

#define	    RP0	    5
#define	    RP1	    6
  
;**********************************************
	    ORG	    00H
	    GOTO    SETTINGS
	    ORG	    05H
;**********************************************
; Entrada   = 1	    
; Salida    = 0  	    
    
	    
SETTINGS:   BCF	    STATUS,RP1	    ; RP1 = 0
	    BSF	    STATUS,RP0	    ; RP0 = 1 Sel Banco 1

; PORTA 6 bits como entrada
; TRISA  = 0011 1111 = 0x3F 	    
; ADCON1 = 0x06 para el puerto A y E.      
	    
	    MOVLW   0x06
	    MOVWF   ADCON1
	    
	    MOVLW   0x3F
	    MOVWF   TRISA	       
	    
; PORTB 8 bits como salida
; TRISB = 0000 0000 = 0x00
	    
	    CLRF    TRISB	

; PORTC 4 entradas y 4 salidas
; TRISC = 1111 0000 = 0xF0 
	    
	    MOVLW   0xF0
	    MOVWF   TRISC

; PORTD 2 entradas, 2 salidas, 2 entradas, 2 salidas
; TRISD = 1100 1100 = 0xCC	    
	    
	    MOVLW   0xCC
	    MOVWF   TRISD
	    
	    BCF	    STATUS,RP1	    ; RP1 = 0
	    BCF	    STATUS,RP0	    ; RP0 = 0 Sel Banco 0

INICIO:	    MOVLW   0x0F
	    MOVWF   PORTB
	    
	    MOVLW   0xF0
	    MOVWF   PORTB
	    
	    GOTO    INICIO

	    END