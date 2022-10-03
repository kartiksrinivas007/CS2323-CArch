#factorial function 
.data
    aa:.dword 3
    
.text 
    ld gp aa
    addi a3 gp 0
    jal x1 fact
    jal x0 exit
    fact:
        #argument stored in a3
        #create space in stack for n and the return address 
        addi t0 zero 1
        ble a3 t0 end
        addi sp sp -16
        sd a3 8(sp)
        sd ra 0(sp)
        #now make a call to fact(n -1)
        addi a3 a3 -1
        jal ra fact
        #now the result is assumed to be stored in a0
        ld a3 8(sp)
        addi a4 a0 0 #note that the ra is still on the stack before calling mul
        jal ra mul
        ld ra 0(sp) #load back the return address
        addi sp sp 16 # pop the positions
        jr ra
        end:
            addi a0 t0 0
            jr ra
    mul:
        #multiply two values stored in a3 and a4 and return in a0
        add t0 x0 a4
        addi a0 x0 0 #initialize with zero! crucial     
        loop:
            ble t0 x0 loop_exit
            add a0 a0 a3
            addi t0 t0 -1
            jal x0 loop
        loop_exit:
            jr ra
    exit:
        lui gp 0x10000
        addi gp gp 16
        sd a0 0(gp) #store at the correct position
        li a7, 4
        ecall
        
        