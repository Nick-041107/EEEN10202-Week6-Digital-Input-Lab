processor 18F8722
radix dec
    
CONFIG OSC = HS
CONFIG WDT = OFF
CONFIG LVP = OFF
    
TRISA equ 0xF92
LATA equ 0xF89
TRISC equ 0xF94
PORTC equ 0xF82
TRISF equ 0xF97
LATF equ  0xF8E
TRISH equ 0xF99
LATH equ 0xF90
PORTH equ 0xF87
ADCON1 equ 0xFC1
    
#include <xc.inc>
PSECT udata_acs
global r
r: ds 1
    
PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start
    
PSECT start, class=CODE, reloc=2
start:
    ;Read switches value and display on lEDs
    ;Use Q3, Port F, Port C, and r
    ;Set RA4 to be low and PORT F all zero before operations
    movlw 00111100B
    movwf TRISC, a
    clrf TRISF, a
    movlw 11101111B
    movwf TRISA, a
    movlw 00001111B
    movwf ADCON1
 
loop:
    bcf LATA, 4, a
    clrf LATF, a
    
    movf PORTC, W, a
    andlw 00111100B
    movwf r, a
    rrcf r, f, a
    rrcf r, W, a
    andlw 00001111B
    movwf r, a
    movwf LATF, a
    bsf LATA, 4, a
    bcf LATA, 4, a
    bra loop
    end
    
