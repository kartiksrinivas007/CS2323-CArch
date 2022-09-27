.data
.dword 100,101,102,103,104,105,106,107,108,109
size: .dword 10

.text
main:
    lui x3 0x10000 #this is a global pointer reserved for x3
    addi a0 x3 0
    ld a1 size
    jal x1, arraysum
    ecall
arraysum:
    #should a0 be modified ? it holds the parent pointer to the array.
    add t0 x0 x0 # t store the index and size of that which is seen yet
    add t1 x0 x0 # to store the position of the memory loc
    add a2 x0 x0
LOOP:    bge t0 a1 EXIT
    ld  a3 0(a0)
    add a2 a2 a3
    addi a0 a0 8
    addi t0 t0 1
    jal x0 LOOP
EXIT:
    jr x1