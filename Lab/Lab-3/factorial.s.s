#factorial function 
.data
    aa:.dword 5
    
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
        sd t1 8(sp)
        sd ra 0(sp)
        addi sp sp 16
        jr x1
        end:
            addi a0 t0 1
            jr x1
    exit:
        li a7, 4
        ecall
        
        