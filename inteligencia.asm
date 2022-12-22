.text


ESCOLHA_DIFICIL:
	li a0,2
	jal melhor_jogada
	
	
	addi sp,sp,-8
	sw a0,4(sp)
	sw a1,0(sp)
	li a0,1
	jal melhor_jogada
	lw t1,0(sp)
	lw t0,4(sp)
	addi sp,sp,8
	blt t0,a0,FIM_ESCOLHA_DIFICIL
	mv a0,t0
	mv a1,t1
	
FIM_ESCOLHA_DIFICIL:
	jal zero,JOGADA_PC


ESCOLHA_MEDIA:
	li a0,2
	jal melhor_jogada
	jal zero,JOGADA_PC


ESCOLHA_FACIL:
	li a0,0
	li a1,7
	li a7,42
	la t0, altura
	Loop_Escolha_Facil:
		ecall
		add t1, t0, a0
		lb t1, 0(t1)
		li t2, 6
		beq t2, t1, Loop_Escolha_Facil
	mv a1,a0
	jal zero,JOGADA_PC


#>>>melhor_jogada: conta o numero de connects de todas as direçoes de todas
#as colunas de um jogador e retorna o numero maximo e sua coluna.
# argumeto: a0 = jogador
# retorno:
# a0 = numero maximo de connects
# a1 = coluna do numero maximo
melhor_jogada:
	li t0,0 #contador de colunas
	li t1,-1 #armazena maior numero de connects
	li t2,0 #armazana coluna do maior numero de connects
	
LOOP_melhor_jogada:
	li t4,6
	bgt t0,t4,FIM_melhor_jogada
	
	la t5,altura
	add t5,t5,t0
	lb t5,0(t5)
	blt t5,t4,possivel
	addi t0,t0,1
	jal zero,LOOP_melhor_jogada
	
possivel:
	addi sp,sp,-24
	sw t0,20(sp)
	sw t1,16(sp)
	sw t2,12(sp)
	sw ra,8(sp)
	sw a0,4(sp)
	
	addi sp,sp,-4
	sw ra,0(sp)
	
	la t3,altura
	add t3,t3,t0
	lb t3,0(t3) #t3 = linha(altura)
	mv a2,t0 #a2 = coluna
	la a0,grid
	mv a1,t3
	jal AJUSTA_XY
	mv t3,a0 #endereco ajustado do jogador na grid
	
	lw ra,0(sp)
	addi sp,sp,4
	sw t3,0(sp)
	

	
	
	#conta esquerda
	lw a0,20(sp)
	lw a1,4(sp)
	lw a2,0(sp)
	jal conta_esq
	la t0,vetor_maiores
	sb a0,0(t0)
	#conta direita
	lw a0,20(sp)
	lw a1,4(sp)
	lw a2,0(sp)
	jal conta_dir
	la t0,vetor_maiores
	lb t1,0(t0)
	add a0,a0,t1
	sb a0,0(t0)
	#conta baixo
	lw a0,20(sp)
	lw a1,4(sp)
	lw a2,0(sp)
	jal conta_baixo
	la t0,vetor_maiores
	sb a0,1(t0)
	
	#conta diagonal cima
	lw a0,20(sp)
	lw a1,4(sp)
	lw a2,0(sp)
	jal conta_diagonal_cima
	la t0,vetor_maiores
	sb a0,2(t0)
	
	#conta diagonal baixo
	lw a0,20(sp)
	lw a1,4(sp)
	lw a2,0(sp)
	jal conta_diagonal_baixo
	la t0,vetor_maiores
	sb a0,3(t0)
	
	
	
	la a0,vetor_maiores
	jal maior_elemento
	mv a1,a0
	
	lw t3,0(sp)
	lw a0,4(sp)	
	lw ra,8(sp)
	lw t2,12(sp)
	lw t1,16(sp)
	lw t0,20(sp)
	addi sp,sp,24
	
	
	bgt a1,t1,valor_melhor #testa se o valor obtido é maior q o anterior
	addi t0,t0,1
	jal zero,LOOP_melhor_jogada
	
valor_melhor:	
	mv t1,a1
	mv t2,t0
	addi t0,t0,1
	jal zero,LOOP_melhor_jogada

FIM_melhor_jogada:
	mv a0,t1 #a0 = maior quantidade existente de connects
	mv a1,t2 #a1 = coluna
	ret


#>>>conta_esq: conta o numero de connects a esquerda na altura
#  da coluna fornecida
# argumentos: a0 = coluna
# a1 = jogador
# a2 = endereco da posicao desejada na grid
conta_esq:
	li t0,0 #contador
	li t2,4
LOOP_conta_esq:
	beq t0,t2,FIM_conta_esq
	beqz a0,FIM_conta_esq
	addi a0,a0,-1
	addi a2,a2,-1
	lb t3,0(a2) #carrega o tipo da moeda a esquerda
	bne t3,a1,FIM_conta_esq # se for diferente da do jogador sai do loop
	addi t0,t0,1
	jal zero,LOOP_conta_esq
	
FIM_conta_esq:
	mv a0,t0
	ret
	
#>>>conta_dir: conta o numero de connects a direita na altura
#  da coluna fornecida
# argumentos: a0 = coluna
# a1 = jogador
# a2 = endereco da posicao desejada na grid
conta_dir:
	li t0,0 #contador
	li t2,4
LOOP_conta_dir:
	beq t0,t2,FIM_conta_dir
	li t3,6
	beq a0,t3,FIM_conta_dir
	addi a0,a0,1
	addi a2,a2,1
	lb t3,0(a2) #carrega o tipo da moeda a direita
	bne t3,a1,FIM_conta_dir # se for diferente da do jogador sai do loop
	addi t0,t0,1
	jal zero,LOOP_conta_dir
	
FIM_conta_dir:
	mv a0,t0
	ret
	
#>>>conta_baixo: conta o numero de connects abaixo na altura
#  da coluna fornecida
# argumentos: a0 = coluna
# a1 = jogador
# a2 = endereco da posicao desejada na grid
# obs: caso não seja possivel fazer 4 connects(casas em branco<jogadas
# necessarias) ele retorna -1
conta_baixo:
	li t0,0 #contador
	li t2,4
	la t4,altura
	add t4,t4,a0
	lb t4,0(t4)
	mv t5,t4
LOOP_conta_baixo:
	beq t0,t2,FIM_conta_baixo
	beqz t4,FIM_conta_baixo
	addi t4,t4,-1
	addi a2,a2,7
	lb t3,0(a2) #carrega o tipo da moeda abaixo
	bne t3,a1,FIM_conta_baixo # se for diferente da do jogador sai do loop
	addi t0,t0,1
	jal zero,LOOP_conta_baixo
	
FIM_conta_baixo:
	mv a0,t0
	li t1,4
	li t2,6
	sub t1,t1,t0 #t1 = quantos faltam para fechar 4
	sub t2,t2,t5 #t2 = quantos espacos estao em branco
	ble t1,t2,FIM_MESMO_BAIXO
	li a0,-1
	
FIM_MESMO_BAIXO:
	ret
	
	
	
#>>>conta_diagonal_cima: conta o numero de connects da diagonal principal na altura
#  da coluna fornecida
# argumentos: a0 = coluna
# a1 = jogador
# a2 = endereco da posicao desejada na grid
conta_diagonal_cima:

	li t0,0
	li t1,4
	mv t2,a2 #t2 = posicao jogador
	mv t3,a0 #t3 = coluna
	la t6,altura
	add t6,t6,a0
	lb t6,0(t6)
LOOP1_diagonal_cima:
	beq t0,t1,FIM_LOOP1_diagonal_cima
	beqz t3,FIM_LOOP1_diagonal_cima
	li t4,5
	bge t6,t4,FIM_LOOP1_diagonal_cima
	addi t6,t6,1
	addi t3,t3,-1
	addi t2,t2,-8
	lb t4,0(t2)
	bne t4,a1,FIM_LOOP1_diagonal_cima
	addi t0,t0,1
	jal zero,LOOP1_diagonal_cima
	
FIM_LOOP1_diagonal_cima:
	mv t5,t0 # t5 = somado
	li t0,0
	li t1,4
	mv t2,a2 #t2 = posicao jogador
	mv t3,a0 #t3 = coluna
	la t6,altura
	add t6,t6,a0
	lb t6,0(t6)

LOOP2_diagonal_cima:
	beq t0,t1,FIM_LOOP2_diagonal_cima
	li t4,6
	beq t3,t4,FIM_LOOP2_diagonal_cima
	beqz t6,FIM_LOOP2_diagonal_cima
	addi t6,t6,-1
	addi t3,t3,1
	addi t2,t2,8
	lb t4,0(t2)
	bne t4,a1,FIM_LOOP2_diagonal_cima
	addi t0,t0,1
	jal zero,LOOP2_diagonal_cima

FIM_LOOP2_diagonal_cima:
	add a0,t0,t5
	ret
	
#>>>conta_diagonal_baixo: conta o numero de connects da diagonal secundaria na altura
#  da coluna fornecida
# argumentos: a0 = coluna
# a1 = jogador
# a2 = endereco da posicao desejada na grid
conta_diagonal_baixo:

	li t0,0
	li t1,4
	mv t2,a2 #t2 = posicao jogador
	mv t3,a0 #t3 = coluna
	la t6,altura
	add t6,t6,a0
	lb t6,0(t6)
	
LOOP1_diagonal_baixo:
	beq t0,t1,FIM_LOOP1_diagonal_baixo
	beqz t3,FIM_LOOP1_diagonal_baixo
	beqz t6,FIM_LOOP1_diagonal_baixo
	addi t6,t6,-1
	addi t3,t3,-1
	addi t2,t2,6
	lb t4,0(t2)
	bne t4,a1,FIM_LOOP1_diagonal_baixo
	addi t0,t0,1
	jal zero,LOOP1_diagonal_baixo
	
FIM_LOOP1_diagonal_baixo:
	mv t5,t0 # t5 = somado
	li t0,0
	li t1,4
	mv t2,a2 #t2 = posicao jogador
	mv t3,a0 #t3 = coluna
	la t6,altura
	add t6,t6,a0
	lb t6,0(t6)

LOOP2_diagonal_baixo:
	beq t0,t1,FIM_LOOP2_diagonal_baixo
	li t4,6
	beq t3,t4,FIM_LOOP2_diagonal_baixo
	li t4,5
	beq t6,t4,FIM_LOOP2_diagonal_baixo
	addi t6,t6,1
	addi t3,t3,1
	addi t2,t2,-6
	lb t4,0(t2)
	bne t4,a1,FIM_LOOP2_diagonal_baixo
	addi t0,t0,1
	jal zero,LOOP2_diagonal_baixo

FIM_LOOP2_diagonal_baixo:
	add a0,t0,t5
	ret
	
	

		


#>>maior_elemento: dado um vetor a funcao encontra o seu maior elemento
# argumento: a0 = endereco do vetor
# retorno : a0 = maior valor
maior_elemento:
	li t0,1 #t1 = contador
	li t1,5
	lb t2,0(a0) #t2 = maior elemento
	addi a0,a0,1
LOOP_maior_elemento:
	beq t0,t1,FIM_maior_elemento
	lb t3,0(a0)
	ble t3,t2,menor
	mv t2,t3
menor:	
	addi a0,a0,1
	addi t0,t0,1
	jal zero,LOOP_maior_elemento
	
FIM_maior_elemento:
	mv a0,t2
	ret
	
#a0 = endereco data, a1 = linha, a2 = coluna, a3 = tamanho do conteudo(4 = word, 1 = byte ...)
#retorno : a0 = posicao x,y

#>>>AJUSTA_XY: recebe a linha e a coluna do endereco desejado e encontra o 
# endereço ajustado dessa posicao.
# argumentos:
# a0 = endereco base
# a1 = linha
# a2 = coluna
# retorno:
# a0 = endereco ajustado

AJUSTA_XY:
	li t1,7 #t1 = numero de colunas
	li t2,5 #t2 = numero de linhas
	sub a1,t2,a1
	mul t2,a1,t1 # linha * coluna
	add t2,t2,a2 #quantidade que deve ser somada
#	li a7,1
#	mv t1,a0
#	mv a0,t2
#	ecall
#	li a7,11
#	li a0,' '
#	ecall
	
#	mv a0,t1
	add a0,a0,t2
	
	
	ret


#funcao para debug : printa a matriz no terminal

PRINTA_MATRIZ:
	la t0,grid
	li t1,0 # t1 = contador colunas
	li t2,0 #t2 = contador linhas
	
LOOP_PRINTA_MATRIZ:
	li t3,7
	beq t1,t3,NOVA_LINHA
	li a7,1
	lb a0,0(t0)
	addi t0,t0,1
	addi t1,t1,1
	ecall
	li a0, ' '
	li a7,11
	ecall
	jal zero,LOOP_PRINTA_MATRIZ
NOVA_LINHA:
	li a0, '\n'
	li a7,11
	ecall
	addi t2,t2,1
	li t1,0
	li t3,6
	bne t3,t2,LOOP_PRINTA_MATRIZ
	ret
	
	
	
	
