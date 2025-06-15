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
	andi s1, s0, 0x3c
	srli s1, s1, 4
	andi s0, s0, 0xf
	beq s1, x0, DONE
	
	mv a0, s0
	mv a1, s1
	call LUY_THUA
	TEMP2:
	sw a1, 0(t0)
	j loop
DONE:
	li a1, 1
	j TEMP2
LUY_THUA:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	mv t2, a0
	addi a1, a1, -1
	beq a1, x0, TEMP1
	call LUY_THUA
	
	li t3, 0
	li t4, 1
	NHAN:
		add t3, t3, t2
		addi t4, t4, 1
		ble t4, a0, NHAN
	mv t2, t3	
	mv a1, t3 
	TEMP1:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

.end