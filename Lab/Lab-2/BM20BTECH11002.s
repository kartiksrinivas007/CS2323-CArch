.data 
.dword 5 #number of fibonaccii values to evaluate
num_addr: .dword 0x1000000
.text 
.main:
    lui a0 0x10000
    lui a1 0x10000
    la a4 num_addr
    addi a1 a1 256 #adding the last 12 bits after the lui 
    lui a2 0x10000
    addi a2 a2 16 # adding the last 12 bits after the lui
    jal x1 fibonacci
    jal x1 exit
fibonacci:
    addi t0 t0 0 
    addi t1 t1 1 # the first fibonacci number
    sd t1 0(a1)
    addi a1 a1 8
    add a5 a5 t1
    #t5 will contain the counter, which must count to n - 1 (first 1 is already present)
    add t5 x0 x0
    ld t4 0(a0) #t4 contains the maximum number of iterations
    addi t4 t4 -1 #1 is already done.
    loop_start:    
        bge t5 t4 loop_exit
        addi t5 t5 1
        add t2 t0 t1
        sd t2 0(a1)
        add a5 a5 t2
        addi t0 t1 0
        addi t1 t2 0
        addi a1 a1 8
        jal x0 loop_start
loop_exit:
    
exit:
    sd a5 0(a2) #store the sum in location pointed by a2
    li a7 10
    ecall
    