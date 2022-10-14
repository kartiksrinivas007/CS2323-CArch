.data

aa: .dword 4

.text

lui gp 0x10000
ld a2 0(gp) #store the argument inside the argument register
jal ra Fib 
jal x0 Exit
Fib:
    beq a2 x0 zero_case
    addi t0 x0 1
    beq a2 t0 one_case
    addi sp sp -16
    sd a2 8(sp)
    sd ra 0(sp)
    #now ready to call fib(n -1)
    addi a2 a2 -1
    jal ra Fib
    #result assumed to be stored in a0
    li a7 4
    ecall
    #calc fib(n-2)
    addi a2 a2 -1
    jal ra Fib


    ld ra 0(sp)
    ld a2 8(sp)
    addi sp sp 16
    #then add both and store in a0
    mv a0 t1
    jr ra
zero_case:
    addi a0 x0 0
    jr ra 
one_case:
    addi a0 x0 1
    jr ra 
Exit:
    addi x0 x0 0
    li a7 4
    ecall
