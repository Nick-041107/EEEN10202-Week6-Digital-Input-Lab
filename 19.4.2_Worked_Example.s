processor 18F8722
radix dec
   
CONFIG OSC = HS
CONFIG WDT = OFF
CONFIG LVP = OFF
    
#include<xc.inc>
PSECT udata_acs
global switches1, switches2
switches1: ds 1
switches2: ds 2

PSECT resetVector, class=CODE, reloc=2
    resetVector:
    goto start
 
PSECT start, class=CODE, reloc=2
    start:
    ;Use Port C,H, and F, Q3(RA4) and Q2(RH1)
    ;Read value from right switches to control middle 4 LEDs
    ;Control seven segment by using left 4 switches
    ;LED 1, 7 segment 0
    ;Q3 1, Q2 0
    ;Configure Digital Mode
    clrf TRISF, a   
    movlw 11101111B
    movwf TRISA, a
    movlw 11111101B
    movwf TRISH, a
    movlw 00111100B
    movwf TRISC, a 
    movlw 00001111B
    movwf ADCON1
    
    loop:
    clrf LATF, a
    bcf LATA, 4, a
    bsf LATH, 1, a
    
    movf PORTC, W, a
    andlw 00111100B
    movwf LATF, a
    bsf LATA, 4, a
    bcf LATA, 4, a
    movlw 11111111B
    movwf LATF, a
    
    movf PORTH, W, a
    andlw 11110000B
    movwf LATF, a
    bcf LATH, 1, a
    bsf LATH, 1, a
    
    bra loop
    end
    
    


