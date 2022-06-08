
	    PROCESSOR   16F877A

; PIC16F877A Configuration Bit Settings

; Assembly source line config statements

#include <xc.inc>
PSECT code	
	
; CONFIG
  CONFIG  FOSC	= XT             ; Oscillator Selection bits (XT oscillator)
  CONFIG  WDTE	= OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF		 ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = OFF            ; Brown-out Reset Enable bit (BOR disabled)
  CONFIG  LVP	= OFF            ; Low-Voltage (Single-Supply) In-Circuit Serial Programming Enable bit (RB3 is digital I/O, HV on MCLR must be used for programming)
  CONFIG  CPD	= OFF            ; Data EEPROM Memory Code Protection bit (Data EEPROM code protection off)
  CONFIG  WRT	= OFF            ; Flash Program Memory Write Enable bits (Write protection off; all program memory may be written to by EECON control)
  CONFIG  CP	= OFF            ; Flash Program Memory Code Protection bit (Code protection off)

#define	    RP1	    6
#define	    RP0	    5
#define	    Z	    2
#define	    DC	    1
#define	    C	    0  
  
  
	    ORG	    0x00	; Reset Vector
	    GOTO    PUERTOS
	    ORG	    0x04	; Interrupt Vector

PUERTOS:    BSF	    STATUS,RP0
	    BCF	    STATUS,RP1	; Seleccionamos el banco 1
	    
	    MOVLW   0x06	; Configure all pins
	    MOVWF   ADCON1	; as digital inputs
	    
	    MOVLW   0x3F
	    MOVWF   TRISA	; Configuro el PORTA como entrada
	    
	    CLRF    TRISB
	    
	    BCF	    STATUS,RP0
	    BCF	    STATUS,RP1	; Seleccionamos el banco 0
	   
LED:	    BTFSS   PORTA,0
	    GOTO    BIT0_0
	    GOTO    BIT0_1
	    
BIT0_0:	    BTFSS   PORTA,1
	    GOTO    CERO
	    GOTO    DOS	    
	    
BIT0_1:	    BTFSS   PORTA,1
	    GOTO    UNO
	    GOTO    TRES	 
    
CERO:	    MOVLW   0x03
	    MOVWF   PORTB
	    GOTO    LED
	    
UNO:	    MOVLW   0x0C
	    MOVWF   PORTB
	    GOTO    LED

DOS:	    MOVLW   0x09
	    MOVWF   PORTB
	    GOTO    LED
	    
TRES:	    MOVLW   0x06
	    MOVWF   PORTB
	    GOTO    LED	    
	    
	    END
	