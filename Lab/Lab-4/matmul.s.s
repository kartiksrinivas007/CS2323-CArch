.data
L1: .word 0       #This location indicates the error of the result. It is 0 if no error else 1.
m_1: .word 2 
n_1: .word 3         #x and y dimensions of MATRIX-1
p_1: .word 1 2 3 4 5 6
m_2: .word 3 
n_2: .word 2
p_2: .word 1 2 3 4 5 6
m_3: .word 24 #garbage value
n_3: .word 24 #garbage value
p_3: .word 0
.text
la gp L1
la t0 n_1
lw t2 0(t0)
la t1 m_2
lw t3 0(t1)
bne t2 t3 bad_exit
la a1 p_1
la a2 p_2
la a3 p_3
la t0 m_1
lw a4 0(t0)
la t0 n_1
lw a5 0(t0)
la t0 m_2
lw a6 0(t0)
la t0 n_2
lw a7 0(t0)
jal x1 matmul
# now do a mat-mul
# jal x0 matmul
jal x0 exit

matmul:
    addi sp sp -28
    sd ra 20(sp)
    sw a2 16(sp)
    sw a1 12(sp)
    sw s5 8(sp)
    sw s6 4(sp)
    sw s0 0(sp)
    

    #now use them as counters as you move through the pointer values
    #argument registers are a1 for p_1 , a2 for p_2 and a_3 for p_3
    #sizes stored in a4 = m_1 a5 = n_1 a6 = m_2, a7  = n_2
    mv t1 x0
    mv t2 x0 # set counters to 0
    mv t3 x0
    #t5 t6 are not being saved
    mv t5 a1
    mv t6 a2
    mv t0 a3
    
    
row_start: 
    beq t1 a4 matmul_exit
        col_start: 
            beq t2 a5 col_exit
            #save t0 for reset aftera term_mult is done 
            mv s1 t0 
            term_mult: 
                beq t3 a7 term_mult_exit
                #operation
                lw s5 0(t5)
                lw s6 0(t6)
                mv a1 s5
                mv a2 s6
                jal x1 mul
                #once over , get back original a1 and a2
                lw a1 12(sp)
                lw a2 16(sp)
                # mult stored in a0
                lw s5 0(t0)
                add s5 s5 a0
                sw s5 0(t0)
                addi t0 t0 4 # increment the storage counter
                addi t3 t3 1 #increment the storage col counter
                addi t6 t6 4 # go to next element in the col of M_1
                jal x0 term_mult
            term_mult_exit:
            addi t5 t5 4
            #reset t0 to beginning of row 
            addi t3 zero 0 #reset t3
            mv t0 s1 #reset t0 to what it was earlier
            addi t2 t2 1
            jal x0 col_start
        col_exit: 
            addi t1 t1 1 #incrrement row counter
            addi t2 zero 0 #reset t2 to zero
            mv t6 a2 #resetting t6 to the beginning
            #increment the t0 to the next row
            addi s5 zero 4
            mv s6 a7
            mv a1 s5
            mv a2 s6
            jal x1 mul
            #once over , get back original a1 and a2
            lw a1 12(sp)
            lw a2 16(sp)
            add t0 t0 a0 # increment
            jal x0 row_start         
matmul_exit:
    ld ra 20(sp)
    lw a2 16(sp)
    lw a1 12(sp)
    lw s5 8(sp)
    lw s6 4(sp)
    lw s0 0(sp)
    addi sp sp 28   
    jr x1
mul:
    #assumes args in a1, a2
    #result in a0
    #make space for temporary regs I am going to use
    # now perform operations without touching the arguments
    mv s9 a1
    mv s10 a2
    addi a0 zero 0
    start_loop:
        beq s10 x0 exit_loop
        add a0 a0 a1
        addi s10 s10 -1
        beq zero zero start_loop
    exit_loop:
    jr x1
bad_exit:
    addi t0 x0 1
    sw t0 0(gp)
    jal x0 exit
exit:
    li a7 4
    ecall
