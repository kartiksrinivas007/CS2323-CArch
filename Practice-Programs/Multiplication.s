.data 
    aa:.dword 0x06
    bb:.dword 0x03
.text
    ld a1 aa
    ld a2 bb
LOOP:
    bge x0 a2 EXIT
    add x5 x5 a1
    addi a2 a2 -1
    beq x0 x0 LOOP
EXIT:
    xor x0 x0 x0