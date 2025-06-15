.text
.equ LEDS, 0xff200000
.equ SWITCHES, 0xff200040
.global _start
_start:
	li sp, 0x03fffffc
	la t0, LEDS
	la t1, SWITCHES
loop:
	lw t2, 0(t1)
	andi s0, t2, 0xfc
	srli s0, s0, 2
	li s1, 14
	li s2, 41
	
	mv a0, s0
	mv a1, s1
	call KIEMTRA
	
	li t3, 1
	li t4, 0
	beq a0, t3, L30
	TEMP2:
	bgt a0, t3, L74
	TEMP3:
	sw t4, 0(t0)
	j loop
	
L30:
	ori t4, x0, 0xf
	j TEMP2
L74:
	ori t4, x0, 0x3ff
	j TEMP3
	
KIEMTRA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t3, a0
	li t4, 0
	KIEMTRA_1:
		blt a0, s1, KIEMTRA_2
		sub a0, a0, s1
		j KIEMTRA_1
	KIEMTRA_2:
		ble t3, s2, KIEMTRA_DEM
		addi t4, t4, 1
	KIEMTRA_DEM:
		beq a0, x0, DEM
	TEMP:
	mv a0, t4
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
DEM:
	addi t4, t4, 1
	j TEMP
.end