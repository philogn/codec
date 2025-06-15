.text
.equ HEX3_HEX0, 0xFF200020
.equ SWITCHES, 0xff200040
.global _start
_start:
	li sp, 0x03fffffc
	la t0, HEX3_HEX0
	la t1, SWITCHES
	la s11, SEVEN_SEG_DECODE_TABLE
	la s10, HEX_SEGMENTS
	
loop:
	lw t2, 0(t1)
	lw s9, 0(s10)
	andi s0, t2, 0x3ff
	li t3, 10
	li t5, 10
	
	mv a0, s0
	call KIEMTRA
	
	add a1, a1, s11
	lb s9, 0(a1)
	sb s9, 0(s10)
	add a0, a0, s11
	lb s9, 0(a0)
	sb s9, 1(s10)
	
	lw s9, 0(s10)
	sw s9, 0(t0)
	j loop
	
KIEMTRA:
	addi sp, sp, -4
	sw ra, 0(sp)
	

	li a1, 0
	LAP:
		beq t3, x0, CHUC_DONVI
		andi t4, a0, 0x1
		ble t4, x0, TEMP
		addi a1, a1, 1
		TEMP:
		srli a0, a0, 1
		addi t3, t3, -1
		J LAP
	CHUC_DONVI:
		blt a1, t5, DONE
		li a0, 1
		li a1, 0
	DONE:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
	
.section .data

SEVEN_SEG_DECODE_TABLE:
.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
.byte 0b01111111, 0b01100111, 0b00000000, 0b00000000
.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
HEX_SEGMENTS:
.word 0
.end

