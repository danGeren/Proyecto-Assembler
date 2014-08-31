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
	
	mov r0, r6
	mov r1, #1
	bl SetGpio
	
	mov r0, r4
	bl Wait
	
	mov r0, r6
	mov r1, #0
	bl SetGpio
	
	mov r0, r7
	bl Wait
	
	ldmfd	sp!, {r4, r12}
	pop {pc}

/*
Subrutina que devuelve 0 si no se apacho el boton y algún numero si si
r0...puerto
r0...sale resultado	
*/	
.globl GetGpio
GetGpio:
	push {lr}
	stmfd	sp!, {r4, r12}
	
	mov r6, r0
	ldr r4,=0x20200000
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, r6
	and r0, r7 ,r9

	ldmfd	sp!, {r4, r12}
	pop {pc}

/*
Subrutina que setea las entradas y salidas de la raspberry
*/
.globl SetearRaspberry
SetearRaspberry:
	push {lr}
	stmfd	sp!, {r4, r12}
	
	mov r0, #16
	mov r1, #1
	bl SetGpioFunction
	
	mov r0, #18
	mov r1, #0
	bl SetGpioFunction
	
	mov r0, #17
	mov r1, #0
	bl SetGpioFunction
	
	mov r0, #15
	mov r1, #0
	bl SetGpioFunction
	
	mov r0, #4
	mov r1, #0
	bl SetGpioFunction
	
	mov r0, #25
	mov r1, #0
	bl SetGpioFunction
	
	mov r0, #14
	mov r1, #0
	bl SetGpioFunction
	
	mov r0, #7
	mov r1, #1
	bl SetGpioFunction
	
	ldmfd	sp!, {r4, r12}
	pop {pc}