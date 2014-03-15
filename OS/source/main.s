.section .init
.globl _start
_start:

b main

.section .text
main:
mov sp,#0x8000

#Enable LED pin
pinNum .req r0
pinFunc .req r1
mov pinNum,#16
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc

#Load the blink pattern into r4
#and 0 into r5
ptrn .req r4
ldr ptrn,=pattern
ldr ptrn,[ptrn]


pinNum .req r0
pinVal .req r1


loop$:

#Use and with 1 to get the last bit
mov pinVal, ptrn
and pinVal, #1

#move the pattern to the next position
ror ptrn, #1

#Set the correct LED state!
mov pinNum,#16
bl SetGpio

#Wait by counting down
mov r2,#0x3F0000
wait1$:
sub r2, #1
cmp r2, #0
bne wait1$

b loop$

.unreq pinNum
.unreq pinVal


.section .data
.align 2
pattern:
.int 0b11111111101010100010001000101010

