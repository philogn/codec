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
	
	mv a0, s0
	call GIAI_THUA
	
	sw a1, 0(t0)
	j loop
	
GIAI_THUA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	
	mv a1, a0
	bgt a0, x0, LAP
	li a1, 1
	LAP:
		addi a0, a0, -1
		li t3, 0
		li t4, 1
		NHAN:
			add t3, t3, a1
			addi t4, t4, 1
			ble t4, a0, NHAN
		mv a1, t3
	bgt a0, x0, LAP
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.end