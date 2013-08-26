
############# Get Gpio Address #############
.globl GetGpioAddress
GetGpioAddress:
ldr r0,=0x20200000
mov pc, lr


############# Set Gpio Function#############
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


############# Set Gpio #############
.globl SetGpio
SetGpio:
pinNum .req r0
pinVal .req r1

#Return if pinNum < 53
cmp pinNum,#53
movhi pc,lr

#Get the gpio address
push {lr}
mov r2,pinNum
.unreq pinNum
pinNum .req r2
bl GetGpioAddress
gpioAddr .req r0

# Add 4 to the gpioAddr if
# pinNum > 32 (We're in the 
# second set of banks)
pinBank .req r3
lsr pinBank,pinNum,#5
lsl pinBank,#2
add gpioAddr,pinBank
.unreq pinBank

#Calculate correct setBit
and pinNum,#31
setBit .req r3
mov setBit,#1
lsl setBit,pinNum
.unreq pinNum

#Set the pin to pinVal
teq pinVal,#0
.unreq pinVal
#Turn pin off
streq setBit,[gpioAddr,#40]
#Turn pin on
strne setBit,[gpioAddr,#28]
.unreq setBit
.unreq gpioAddr
pop {pc}

