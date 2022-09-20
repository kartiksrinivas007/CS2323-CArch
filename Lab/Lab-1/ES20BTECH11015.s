.data
    .dword 0x26
.text
    lui x3 0x10000 #first 20 bits form 31 to 12 loaded 
    lui x14 0x10003
    ld x12 0(x3)
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12
    add x11 x11 x12