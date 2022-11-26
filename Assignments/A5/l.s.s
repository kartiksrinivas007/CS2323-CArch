.data
L1: .dword 8, 8
A:

.text
la x3, L1
ld x4, 0(x3)
ld x5, 8(x3)
addi x3, x3, 16

    addi x10, x0, 0
    add x12, x3, x0
If1: beq x4, x10, end1
       addi x11, x0, 0
If2:    beq x5, x11, end2
           ld x20, 0(x12)
           addi x12, x12, 8
           addi x11, x11, 1
           beq x0, x0, If2
end2:   addi x10, x10, 1
       beq x0, x0, If1
end1: nop

