
.data
aa: .dword 5
bb:.dword 6
.text
lui x3 0x10000
li a0 16500
sh a0 0(x3)

