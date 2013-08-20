.section .init
.globl _start
_start:
#Load the address for GPIO
ldr r0,=0x20200000

#Enable the OK LED pin
mov r1,#1
lsl r1,#18
str r1,[r0,#4]

#Load a string with 1 at LED pin
mov r1,#1
lsl r1,#16

loop$:

#Turn the LED on!
str r1,[r0,#40]

#Wait by counting down
mov r2,#0x3F0001
wait1$:
sub r2, #1
cmp r2, #0
bne wait1$


#Turn the LED off
str r1,[r0,#28]

#Wait again
mov r2,#0x3F0001
wait2$:
sub r2, #1
cmp r2, #0
bne wait2$

b loop$

