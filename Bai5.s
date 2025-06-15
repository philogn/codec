.text
.equ LEDS, 0xff200000
.equ SWITCHES, 0xff200040
.global _start
_start:
	li sp, 0x03fffffc
	la t0, LEDS
	la t1, SWITCHES
loop:
	lw a2, 0(t1)
	andi a3, a2, 0xf0
	srli a3, a3, 4
	andi a2, a2, 0xf
	
	mv a1, x0
	call NHAN
	
	sw a1, 0(t0)
	j loop
	
NHAN:
	add sp, sp, -4
	sw ra, 0(sp)
	
	li t4, 4
	LAP:
		andi t3, a3, 1
		bgt t3, x0, ACTIVE
		QUAYLAI:
		srli a1, a1, 1
		srli a3, a3, 1
		addi t4, t4, -1
		beq t4, x0, DONE
		j LAP
	DONE:
	lw ra, 0(sp)
	add sp, sp, 4
	ret

ACTIVE:
	slli a2, a2, 4
	add a1, a1, a2
	srli a2, a2, 4
	j QUAYLAI

.end