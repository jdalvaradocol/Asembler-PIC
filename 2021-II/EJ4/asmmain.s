    
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
#define	    Z	    2
#define	    DC	    1
#define	    C	    0
  
VAR1	    EQU	    20H
VAR2	    EQU	    21H
DATO	    EQU	    22H	 
CONTA	    EQU	    23H	
CONTB	    EQU	    24H	
	    
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
; PORTC 8 bits como salida
; PORTD 8 bits como salida
	    
	    CLRF    TRISB	
	    CLRF    TRISC
	    CLRF    TRISD
	    
	    BCF	    STATUS,RP1	    ; RP1 = 0
	    BCF	    STATUS,RP0	    ; RP0 = 0 Sel Banco 0

	    MOVLW   0xFF
	    MOVWF   PORTC
	    MOVWF   PORTD
	    CLRF    CONTA
	    CLRF    CONTB
	     
INICIO:	    MOVF    CONTA,W
	    CALL    DISPLAY
	    MOVWF   PORTC
	    MOVF    CONTB,W
	    CALL    DISPLAY
	    MOVWF   PORTD
	    CALL    DELAY
	    
	    INCF    CONTA,F
	    
	    MOVLW   0x0A
	    SUBWF   CONTA,W
	    BTFSS   STATUS,Z
	    GOTO    INICIO
	    CLRF    CONTA
 	    
	    INCF    CONTB,F
	    
	    MOVLW   0x06
	    SUBWF   CONTB,W
	    BTFSS   STATUS,Z
	    GOTO    INICIO
	    CLRF    CONTB
	    GOTO    INICIO

DISPLAY:    MOVWF   DATO	    
	    
	    MOVLW   0x00
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x40
	    
	    MOVLW   0x01
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x79
	  
	    MOVLW   0x02
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x24
    
	    MOVLW   0x03
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x30
	    
	    MOVLW   0x04
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x19
	    
	    MOVLW   0x05
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x12
	    
	    MOVLW   0x06
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x02
	    
	    MOVLW   0x07
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x78
	    
	    MOVLW   0x08
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x00
	    
	    MOVLW   0x09
	    SUBWF   DATO,W
	    BTFSC   STATUS,Z
	    RETLW   0x10
	    RETLW   0xFF
	    	    
DELAY:	    MOVLW   0xFF
	    MOVWF   VAR1

LOOPA:	    MOVLW   0xFF
	    MOVWF   VAR2
	    
LOOPB:	    DECFSZ  VAR2,F
	    GOTO    LOOPB
	       
	    DECFSZ  VAR1,F
	    GOTO    LOOPA
	    RETURN  
	    
	    END