/*Proyecto 
  Daniel Gerendas 13158
  Kuk zHo Chung 13279
  Es un controlador de servomotor
  */

.section .init
.globl _start
_start:

b main
.section .text

main:
	mov sp, #0x8000
	
revisar:
	mov r6, #24
	ldr r4,=0x20200000
	/*
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, r6
	and r7, r7 ,r9
	
	teq r7, #0
	bne grabar
	beq revisar
	
grabar:

	@prender el LED
	mov r0, #23
	mov r1, #1
	bl SetGpioFunction
	
	mov r0, #23
	mov r1, #1
	bl SetGpio
	
	@Revisar si se apachó un botón y cual fue
	mov r8, #5 @contador
siguiente:
	sub r8, r8, #1
	cmp r8, #-1
	beq terminoGrabacion
	
		mov r6, #18
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq boton2
		ldr r4,=1000
		ldr r5, =sec
		str r4, [r5], #4
		b siguiente
	
	boton2:
		mov r6, #17
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq boton2
		ldr r4,=1250
		ldr r5, =sec
		str r4, [r5], #4
		b siguiente
	
	boton3:
	
		mov r6, #15
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq boton2
		ldr r4,=1500
		ldr r5, =sec
		str r4, [r5], #4
		b siguiente
	
	boton4:
		
		mov r6, #14
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq siguiente
		ldr r4,=1750
		ldr r5, =sec
		str r4, [r5], #4
		b siguiente
	
terminoGrabacion:
	@apagar el LED
	mov r0, #23
	mov r1, #0
	bl SetGpio
	
	@Revisar boton reproducir para ver cuando se debe empezar a reproducir la seuencia
revisar1:
	mov r6, #25
	ldr r4,=0x20200000
	
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, r6
	and r7, r7 ,r9
	
	teq r7, #0
	bne reproducir
*/
reproducir:
	mov r0, #7
	mov r1, #1
	bl SetGpioFunction
	
	mov r4,#5
	ldr r5, =sec
	
siguiente1:
	cmp r4, #0
	beq infinito	
	ldr r6, [r5], #4
	ldr r8, =20000
	sub r8, r8, r6
	ldr r9, =2000000
	
	bl GetTimeStamp
	add r9, r9, r0

pulso:
	cmp r9, r0
	sublt r4, #1
	blt siguiente1
	
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
	
/*
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
*/	

.section .data
.align 2

sec: .int 1500,1250,1750,1000,1500

