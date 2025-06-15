.text
.equ LEDS, 0xff200000
.equ SWITCHES, 0xff200040
.global _start
_start:
	li sp, 0x03fffffc
	la t0, LEDS
	la t1, SWITCHES
loop:
	lw a0, 0(t1)
	andi a1, a0, 0xf0
	srli a1, a1, 4
	andi a0, a0, 0xf
	
	call UCLN
	
	sw a0, 0(t0)
	j loop
	
UCLN:
	add sp, sp, -4
	sw ra, 0(sp)
	
	lap:
		ble a0, x0, TEMP2
		ble a1, x0, TEMP2
		blt a0, a1, TEMP1
		beq a0, a1, TEMP2
		sub a0, a0, a1
		j lap
	TEMP1: 
		sub a1, a1, a0
		j lap
	TEMP2:
	lw ra, 0(sp)
	add sp, sp, 4
	ret
	
.end