.text
# dia chi port noi voi RED_LEDS
.equ LEDS, 0xff200000
.equ SWITCHES, 0xff200040

.global _start
_start:
	li sp, 0x03fffffc
	la t0, LEDS
	la t1, SWITCHES
	
loop:
	lw a0, 0(t1)			#lay trang thai switches
	and a0, a0, 0x3c
	srli a0, a0, 2
	
	call SUM

	sw a0, 0(t0)			#xuat ra trang thai leds
j loop

SUM:
	addi sp, sp, -4
	sw ra. 0(sp)
	
	li t3, 0
	lap:
		blt a0, x0, KQ
		add t2, a0, a0
		addi t2, t2, 1
		add t3, t3, t2
		addi a0,a0,-1
		j lap
	KQ: mv a0, t3
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
.end