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

loop$:

#Turn the LED on!
pinNum .req r0
pinVal .req r1
mov pinNum,#16
mov pinVal,#0
bl SetGpio

#Wait by counting down
mov r2,#0x3F0000
wait1$:
sub r2, #1
cmp r2, #0
bne wait1$


#Turn the LED off
mov pinNum,#16
mov pinVal,#1
bl SetGpio

#Wait again
mov r2,#0x3F0000
wait2$:
sub r2, #1
cmp r2, #0
bne wait2$

b loop$

.unreq pinNum
.unreq pinVal

