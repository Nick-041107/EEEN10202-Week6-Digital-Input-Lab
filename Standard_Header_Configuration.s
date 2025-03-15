processor 18F8722
radix dec
 
CONFIG OSC = HS
CONFIG WDT = OFF
CONFIG LVP = OFF
    
#include<xc.inc>
 
;Configure GPIO(Geeral-Purpose Input/Output)
;TRIS(Tri-State Register): Determines whether a pin is an input/output
;PORT Register: Reads the current state of input pins
;LAT(Latching)Register: Holds the output value for digital output pins
;SFRs(Special Function Registers): Control and configure function modulus
    
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

PSECT udata_acs
global example_variable1, example_variable2
example_variable1: ds 1
example_variable2: ds 1
    
PSECT resetVector, class=CODE, reloc=2
resetVector:
    goto start
    
PSECT start, class=CODE, reloc=2
start:
    movlw 00001111B
    movwf 0xFC1,a 
    
    movlw 11111111B
    movwf TRISC, a 
    
    movf PORTC, W, a
    
loop_inf: bra loop_inf
    end
    


