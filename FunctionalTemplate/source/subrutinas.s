/*Proyecto 
  Daniel Gerendas 13158
  Kuk zHo Chung 13279
  Es un controlador de servomotor
  */
  
/*
Mueve el servo según un parámetro que se le envía
r0...pulso
r2...pinServo
*/
.globl moverServo
moverServo:
	push {lr}
	stmfd	sp!, {r4, r12}
	
	mov r4, r0
	mov r6, r2
		
	ldr r7, =20000
	sub r7, r7, r4
	
	mov r0, r2
	mov r1, #1
	bl SetGpio
	
	mov r0, r4
	bl Wait
	
	mov r0, r2
	mov r1, #0
	bl SetGpio
	
	mov r0, r7
	bl Wait
	
	ldmfd	sp!, {r4, r12}
	pop {pc}
