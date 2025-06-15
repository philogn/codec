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
	call BIEUTHUC
	
	sw a0, 0(t0)
	j loop

BIEUTHUC:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	#a^2
	mv t3, a0
	li t4, 0
	NHAN_A:
		add t4, t4, a0
		addi t3, t3, -1
		bgt t3, x0, NHAN_A
	mv a0, t4
	
	#3b
	li t3, 3
	li t4, 0
	NHAN_B:
		add t4, t4, a1
		addi t3, t3, -1
		bgt t3, x0, NHAN_B
	mv a1, t4
	
	#TONG
	add a0, a0, a1
	addi a0, a0, 25
		
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.end