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
	andi s0, t2, 0x3ff
	li s1, 0xd
	
	mv a0, s0
	mv a1, s1
	call KIEMTRA
	
	sw a0, 0(t0)
	j loop
	
KIEMTRA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t4, 10
	li a2, 0
	LAP:
		andi t3, a0, 0xf
		beq t3, a1, DEM
		srli a0, a0, 1
		beq t4, x0, DONE
		addi t4, t4, -1
		j LAP
	DONE:
	mv a0, a2
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
DEM:
	addi a2, a2, 1
	srli a0, a0, 1
	j LAP

.end