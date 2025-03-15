processor 18F8722
radix dec
   
CONFIG OSC = HS
CONFIG WDT = OFF
CONFIG LVP = OFF
    
#include<xc.inc>
Button equ 0x20
 
PSECT resetVector, class=CODE, reloc=2
 resetVector:
    goto start
  
PSECT start, class=CODE, reloc=2
    start:
    ;Use Port F,B,and J,  Q3(RA4),Set digital Mode
    ; RA4 1, LED 1
    clrf TRISF, a
    movlw 00000001B
    movwf TRISB, a
    movlw 11101111B
    movwf TRISA, a
    movlw 00100000B
    movwf TRISJ, 
    
    loop:
    clrf LATF, a
    bcf LATA, 4, a
    
    movf PORTB, W, a
    andlw 00000001B
    xorlw 11111111B
    andlw 00000001B
    movwf Button, a
    
    movf PORTJ, W, a
    andlw 00100000B
    xorlw 11111111B
    andlw 00100000B
    iorwf Button, W
    andlw 00100001B
    movwf LATF, a
    bsf LATA, 4, a
    bcf LATA, 4, a
    
    bra loop
    end
    
