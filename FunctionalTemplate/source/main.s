/*Proyecto 
  Daniel Gerendas 13158
  Kuk zHo Chung 13279
  Es un controlador de servomotor
  */

.section .data
.align 2

sec: .int 0,0,0,0,0

.section .init
.globl _start
_start:

b main
.section .text

main:
	mov sp, #0x8000
	
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
	
revisar:
	
	ldr r4,=0x20200000
	
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, #4
	and r7, r7 ,r9
	
	teq r7, #0
	bne grabar
	beq _0grados
	
_0grados:
	
	ldr r4,=0x20200000
	
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, #18
	and r7, r7 ,r9
	
	teq r7, #0
	beq _45grados
	
	mov r0, #16
	mov r1, #0
	bl SetGpio
	
	ldr r0, =900
	mov r2, #7
	bl moverServo
	b revisar
	
_45grados:
	ldr r4,=0x20200000
	
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, #17
	and r7, r7 ,r9
	
	teq r7, #0
	beq _90grados
	
	ldr r0, =1350
	mov r2, #7
	bl moverServo
	b revisar
	
_90grados:
	ldr r4,=0x20200000
	
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, #15
	and r7, r7 ,r9
	
	teq r7, #0
	beq _135grados
	
	ldr r0, =1850
	mov r2, #7
	bl moverServo
	b revisar
	
_135grados:
	ldr r4,=0x20200000
	
	ldr r7,[r4,#0x34]
	mov r9,#1
	lsl r9, #14
	and r7, r7 ,r9
	
	teq r7, #0
	beq revisar
	
	ldr r0, =2350
	mov r2, #7
	bl moverServo
	b revisar
	
grabar:
	mov r0, #16
	mov r1, #1
	bl SetGpio

	@prender el LED
	mov r0, #23
	mov r1, #1
	bl SetGpioFunction
	
	mov r0, #23
	mov r1, #1
	bl SetGpio
	
	@Revisar si se apachó un botón y cual fue
	mov r8, #5 @contador
	ldr r5, =sec
siguiente:
	sub r8, r8, #1
	cmp r8, #-1
	beq terminoGrabacion
esperar:
		mov r6, #18
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq boton2
		ldr r4,=900
		str r4, [r5], #4
		
		mov r0, #16
		mov r1, #0
		bl SetGpio
		
		ldr r0, =500000
		bl Wait
		
		mov r0, #16
		mov r1, #1
		bl SetGpio
		b siguiente
	
	boton2:
		mov r6, #17
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq boton3
		ldr r4,=1350
		str r4, [r5], #4
		mov r0, #16
		mov r1, #0
		bl SetGpio
		
		ldr r0, =500000
		bl Wait
		
		mov r0, #16
		mov r1, #1
		bl SetGpio
		b siguiente
	
	boton3:
	
		mov r6, #15
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq boton4
		ldr r4,=1850
		str r4, [r5], #4
		mov r0, #16
		mov r1, #0
		bl SetGpio
		
		ldr r0, =500000
		bl Wait
		
		mov r0, #16
		mov r1, #1
		bl SetGpio
		b siguiente
	
	boton4:
		
		mov r6, #14
		ldr r4,=0x20200000
		ldr r7,[r4,#0x34]
		mov r9,#1
		lsl r9, r6
		and r7, r7 ,r9
		
		teq r7, #0
		beq esperar
		ldr r4,=2350
		str r4, [r5], #4
		mov r0, #16
		mov r1, #0
		bl SetGpio
		
		ldr r0, =500000
		bl Wait
		mov r0, #16
		mov r1, #1
		bl SetGpio
		
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
	beq revisar1

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
	ldr r9, =3000000
	
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
	b revisar
	
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


