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
	andi s0, t2, 0xf
	andi s1, t2, 0xf0
	srli s1, s1, 4
	
	mv a0, s0
	mv a1, s1
	call SO_DU
	
	sw a0, 0(t0)
	j loop
	
SO_DU:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t3, 3
	li t4, 1
	CHIA3_1:
		blt a0, t3, CHIA3_2
		addi a0, a0, -3
		j CHIA3_1
	CHIA3_2:
		blt a1, t3, KIEMTRA1
		addi a1, a1, -3
		j CHIA3_2
	KIEMTRA1:
		mv a2, x0
		beq a0, t4, DEM1
	KIEMTRA2:
		beq a1, t4, DEM2
	DONE:
	mv a0, a2
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
DEM1:
	addi a2, a2, 1
	j KIEMTRA2
DEM2:
	addi a2, a2, 1
	j DONE

.end