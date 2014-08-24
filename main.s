/*Proyecto 
  Daniel Gerendas 13158
  Kuk Chung
  Es un controlador de servomotor
  */
  
.section .init
.globl _start
_start:

b main
.section .text

main:
	mov sp, #0x8000
	
/*	
	mov r0, #7
	mov r1, #1
	bl SetGpioFunction
	
	mov r4,#5
	ldr r5, =sec
	
siguiente:
	cmp r4, #0
	beq infinito	
	ldr r6, [r5], #4
	ldr r8, =20000
	sub r8, r8, r6
	ldr r9, =5000000
	
	bl GetTimeStamp
	add r9, r9, r0

pulso:
	cmp r9, r0
	sublt r4, #1
	blt siguiente
	
	mov r0, #7
	mov r1, #1
	bl SetGpio
	
	mov r0, r6
	bl Wait
	
	mov r0, #7
	mov r1, #0
	bl SetGpio
	
	mov r0, r8
	bl Wait
	
	bl GetTimeStamp
	b pulso

infinito:
	b infinito

	*/
	mov r0, #7
	mov r1, #1
	bl SetGpioFunction
	
infinito:
	
	mov r0, #7
	mov r1, #1
	bl SetGpio
	
	ldr r0, =1500
	bl Wait
	
	mov r0, #7
	mov r1, #0
	bl SetGpio
	
	ldr r0, =18500
	bl Wait
	
	b infinito
/*
.data
.align 2

sec: .int 1500
*/
