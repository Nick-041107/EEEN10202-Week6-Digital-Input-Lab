processor 18F8722
radix dec
  
CONFIG OSC = HS
CONFIG WDT = OFF
CONFIG LVP = OFF
    
#include<xc.inc>

switches3 equ 0x20
    
PSECT resetVector, class=CODE, reloc=2
    resetVector:
    goto start
    
PSECT start, class=CODE, reloc=2
    start:
    ;Use Port C, F, H, Q3(RA4), Set Digital Mode
    ;LED 1
    ;RA4 1
    movlw 00111100B
    movwf TRISC, a
    clrf TRISF, a
    
    movlw 11110011B
    movwf TRISH, a
    movlw 11101111B
    movwf TRISA, a
    movlw 00001111B
    movwf ADCON1, a
    
    loop:
    clrf LATF, a
    bcf LATA, 4, a
    
    movf PORTC, W, a
    andlw 00111100B
    movwf switches3, a
    rrcf switches3, f, a
    rrcf switches3, W, a
    andlw 00001111B
    movwf switches3, a
    
    movf PORTH, W, a
    andlw 11110000B
    iorwf switches3, W
    movwf LATF, a
    bsf LATA, 4, a
    bra loop
    end

