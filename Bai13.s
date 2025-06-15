.text
.equ LEDS, 0xff200000
.equ SWITCHES, 0xff200040
.global _start
_start:
	li sp, 0x03fffffc
	la t0, LEDS
	la t1, SWITCHES
loop:
	lw s0, 0(t1)
	andi s0, s0, 0xff
	li s11, 2
	li s10, 1
	
	mv a0, s0
	call KIEMTRA
	
	beq a1, s10, GAN0
	j GAN1
	GAN0:
		li a1, 0xffffffff
		J LOAD
	GAN1:
		li a0, 0
	LOAD:
	sw a1, 0(t0)
	j loop
	
KIEMTRA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	li t3, 1
	li a1, 0
	beq a0, s11, TEMP2
	LAP:
		beq t3, a0, DONE
		mv t2, a0
		addi t3, t3, 1
		CHIA_HET:
			blt t2, t3, TEMP1
			sub t2, t2, t3
			j CHIA_HET
		TEMP2:
			li t2, 1
			li a1, 1
			J DONE
		TEMP1:
			beq t2, x0, DONE
			li a1, 1
		J LAP
	
	DONE:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.end