.data
.dword 0x39933939a55aa5a5
.dword 0xa55aa5a539933939
.text
    lui x1, 0x10000
main:
    lhu x3, 0(x1)
    lh x3, 0(x1) # sign extends for the 'a'
    lh x3, 2(x1) #loads form 3rd byte onwards and sign extends (if necessary)
    ld x3, 0(x1) # loads the whole of the first one 
    ld x3, 4(x1) #reads like contiguous memory
    lbu x3, 7(x1)#reads unsigned byte 8 
    lb x3, 7(x1)#stays the same (since 3 has no set bit)
    lb x3, 6(x1)#9 = 1 + 8 (set bit, sign extension will happen)
