;------------------------------------------------------------------------------
; Purpose: Blink an LED connected to Port 1 at approximately 1 Hz using memory-mapped I/O
;------------------------------------------------------------------------------
        THUMB                       ; Use the Thumb instruction set
        AREA    My_code, CODE, READONLY
        EXPORT  __MAIN              ; Entry label exported for linker
        ENTRY

__MAIN                              ; Do not rename - matches startup_LPC1768.s

;------------------------------------------------------------------------------
; Section 1: Initialize GPIO base address and disable LEDs on Port 1 and 2
;------------------------------------------------------------------------------
        MOV     R2, #0xC000         ; Offset for GPIO base address
        MOV     R4, #0x0            ; Clear R4 to build base address
        MOVT    R4, #0x2009         ; Set upper half to 0x20090000
        ADD     R4, R4, R2          ; R4 now holds 0x2009C000 (GPIO base)

        MOV     R3, #0x7C           ; Value to turn off Port 2 LEDs
        STR     R3, [R4, #0x40]     ; Write to Port 2 (offset 0x40)

        MOV     R3, #0xB0000000     ; Value to turn off Port 1 LEDs (bits 28–30)
        STR     R3, [R4, #0x20]     ; Write to Port 1 (offset 0x20)

        MOV     R2, #0x20           ; Save Port 1 offset to R2 for reuse

;------------------------------------------------------------------------------
; Section 2: Initialize delay counter
;------------------------------------------------------------------------------
        MOVW    R0, #0x2C2A         ; Lower 16 bits for delay
        MOVT    R0, #0xA            ; Upper 16 bits for delay (R0 = 0x000A2C2A)

;------------------------------------------------------------------------------
; Section 3: LED Blink Loop
;------------------------------------------------------------------------------
loop
        SUBS    R0, #1              ; Decrement delay counter, set flags
        BGT     loop                ; If R0 > 0, keep looping to delay ~0.5s

        MOVW    R0, #0x2C2A         ; Reset delay counter lower 16 bits
        MOVT    R0, #0xA            ; Reset delay counter upper 16 bits

        EOR     R3, R3, #0x10000000 ; Toggle bit 28 of Port 1 (LED on/off)
        STR     R3, [R4, R2]        ; Write updated LED state to Port 1

        B       loop                ; Repeat forever

        END                         ; End of program