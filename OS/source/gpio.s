.globl GetGpioAddress
GetGpioAddress:
ldr r0,=0x20200000
mov pc, lr

.globl SetGpioFunction
SetGpioFunction:
#Check the input
cmp r0, #53
cmpls r1, #7
movhi pc,lr

#Call GetGpioAddress
push {lr}
mov r2,r0
bl GetGpioAddress

#Figure out which block of 10 we're in
functionLoop$:
cmp r2,#9
subhi r2,#10
addhi r0,#4
bhi functionLoop$

add r2, r2, lsl #1
lsl r1, r2
str r1,[r0]
pop {pc}

