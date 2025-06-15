.text
.equ LEDS, 0xff200000
.equ SWITCHES, 0xff200040
.equ KEY, 0xFF200050

.global _start
_start:
	li sp, 0x03fffffc
	la t0, LEDS
	la t1, SWITCHES
	la t2, KEY

	
LOOP:

	li s11, 2
	li s10, 4
	li s9, 8
	lw s8, 0(t0)
	CHECK_KEY:
		lh s0, 0(t2) 
		beq s0, x0, CHECK_KEY 
	WAIT:
		lh s1, 0(t2) 
		bne s1, x0, WAIT 

		andi s0, s0, 0xE 

		mv a0, s0
		mv a1, s8
		call KIEMTRA
		
		sw a1, 0(t0)
j LOOP

KIEMTRA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	#KEY1
	andi t3, a0, 2
	beq t3, s11, TEMP1
	J TEMP2
	TEMP1:
		slli a1, a1, 1
		
	TEMP2:
	andi t3, a0, 4
	beq t3, s10, TEMP3
	J TEMP4
	TEMP3:
		srli a1, a1, 1
		
	TEMP4:
	andi t3, a0, 8
	beq t3, s9, TEMP5
	j TEMP6
	TEMP5:
		lw a1, 0(t1)
		
	TEMP6:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.end