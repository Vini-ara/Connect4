.text

jal SET_UP

PRINT_INFO:
#	addi sp,sp,-40
#	sw s0,-36(sp)
#	sw s1,-32(sp)
#	sw ra, -28(sp)
#	sw t0, -24(sp)
#	sw t1, -20(sp)
#	sw t2, -16(sp)
#	sw t3, -12(sp)
#	sw t4, -8(sp)
#	sw t5, -4(sp)	
#	sw t6, 0(sp)

	addi sp,sp,-4
	sw ra,0(sp)
	la t0, reg_s8
	sw s8, (t0)
	la t0, reg_s9
	sw s9, (t0)
	#printa frequencia
	la a0,frequencia
	li a1,10
	li a2,10
	li a3,0x000000FF
	
	jal printString
	
	#printa valor float frequencia
	
	fmv.s fa0,fs6
	li a1,120
	li a2,10
	li a3,0x000000FF
	
	jal printFloat
	
	#mhz
	
	la a0,mhz
	li a1,250
	li a2,10
	li a3,0x000000FF
	jal printString
	
	#ciclos
	
	la a0,ciclos
	li a1,10
	li a2,30
	li a3,0x000000FF
	
	jal printString
	
	#numero ciclos
	
	mv a0,s7
	li a1,120
	li a2,30
	li a3,0x000000FF
	
	jal printInt
	
	#incstrucoes
	la a0,instrucoes
	li a1,10
	li a2,50
	li a3,0x000000FF
	
	jal printString
	
	#numero instrucoes
	la t0, reg_s8
	lw a0, 0(t0)
	li a1,120
	li a2,50
	li a3,0x000000FF
	
	jal printInt
	
	#tempo mediddo
	la a0,tempo_m
	li a1,10
	li a2,70
	li a3,0x000000FF
	
	jal printString
	
	#nue=mero tempo
	
	la t0, reg_s9
	lw a0, 0(t0)
	li a1,120
	li a2,70
	li a3,0x000000FF
	
	jal printInt
	
	#ms
	
	la a0,ms
	li a1,250
	li a2,70
	li a3,0x000000FF
	
	jal printString
	
	#cpi media
	
	la a0,cpi
	li a1,10
	li a2,90
	li a3,0x000000FF
	
	jal printString
	
	#n cpi
	
	mv a0,s10
	li a1,120
	li a2,90
	li a3,0x000000FF
	
	jal printInt
	
	#tempo calculado
	
	la a0,tempo
	li a1,10
	li a2,110
	li a3,0x000000FF
	
	jal printString
	
	#numero tempo
	
	fmv.s fa0,fs11
	li a1,120
	li a2,110
	li a3,0x000000FF

	jal printFloat
	
	
#	lw t6, 0(sp)
#	lw t5, 4(sp)
#	lw t4, 8(sp)
#	lw t3, 12(sp)
#	lw t2, 16(sp)
#	lw t1, 20(sp)
#	lw t0, 24(sp)
#	lw ra, 28(sp)
#	lw s1,32(sp)
#	lw s0,36(sp)
	
	
#	addi sp,sp,40
	lw ra,0(sp)
	addi sp,sp,4
	ret
