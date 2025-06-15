.text
.equ HEX3_HEX0, 0xFF200020
.equ SWITCHES, 0xff200040
.global _start
_start:
	li sp, 0x03fffffc
	la t0, HEX3_HEX0
	la t1, SWITCHES
	la s11, HEX_SEGMENTS
	la s10, SEVEN_SEG_DECODE_TABLE
	
loop:
	lw t2, 0(t1)
	andi s1, t2, 0xf0
	srli s1, s1, 4			#B
	andi s0, t2, 0xf		#A
	li s2, 10
	
	mv a0, s0
	mv a1, s1
	call TINH_TONG
	
	add a0, a0, s10
	lb a2, 0(a0)
	sb a2, 0(s11)
	
	add a1, a1, s10
	lb a2, 0(a1)
	sb a2, 1(s11)
	
	lw a2, 0(s11)
	sw a2, 0(t0)
	j loop
	
TINH_TONG:
	addi sp, sp, -4
	sw ra, 0(sp)
	
	add a2, a0, a1
	mv a3, x0
	CHUC_DONVI:
		blt a2, s2, DONE
		addi a2, a2, -10
		add a3, a3, 1
		J CHUC_DONVI
	DONE:
		mv a0, a2 
		mv a1, a3
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
	
.section .data

SEVEN_SEG_DECODE_TABLE:
.byte 0b00111111, 0b00000110, 0b01011011, 0b01001111
.byte 0b01100110, 0b01101101, 0b01111101, 0b00000111
.byte 0b01111111, 0b01100111, 0b00000000, 0b00000000
.byte 0b00000000, 0b00000000, 0b00000000, 0b00000000
# cấp phát 1 word (4 byte) giá trị 0
HEX_SEGMENTS:
.word 0
.end