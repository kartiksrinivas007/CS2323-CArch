.data 
.dword 5
.text    
    lui x3, 0x10000
    # Stores the address to write the sum
    lui x14, 0x10000010
    # x4 stores the value of 'n'
    ld x4, 0(x3)
    # x5 stores the Base Address
    lui x5, 0x10000100
    # temporary register to store initial value of 1
    addi x6,x0,1
    
    # Stores the sum
    addi x18,x0,0
    
    # Storing first two Fibonacci Numbers to Base Address 
    # and the next address
    sd x6, 0(x5)
    addi x7,x5,8
    sd x6, 0(x7)
    
    addi x18,x18,2
    # Now x5 contains the first number and x7 the second
    # number of the Fibonacci Series
    
    # Function
    
    # x8 stores the number current number of index of the sequence
    addi x8,x0,2
    
    Fib:
        bge x8,x4,Exit
        # Load data from address in x5
        ld x10, 0(x5)
        # Load data from address in x7
        ld x11, 0(x7)
        add x12,x10,x11
        # Add the current value to the sum
        add x18,x18,x12
        # Incrementing the Addresses
        addi x7,x7,8
        addi x5,x5,8
        # Storing the Fibonacci Number in x7
        sd x12, 0(x7)
        addi x8,x8,1
        beq x0,x0,Fib
    Exit:
        sd x18, 0x10(x3)
    