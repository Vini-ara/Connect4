.text
#   COIN_ANIMATION
#       >>> a0 = Endereço da matriz do jogo
#       >>> a1 = Coluna (número de 0 a 6)
#       >>> a2 = Endereço da imagem da moeda
#
#	A funcao pode ser otimizada para somente apagar a ultima posicao da moeda, 
# 	ao inves de desenhar o grid todo novamente

COIN_ANIMATION:
    # Salvando registradores na pilha
    addi sp, sp, -32
    sw ra, 28(sp)
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    # t0 = Endereço da matriz do jogo
    mv t0, a0
    # t1 = Endereço do primeiro elemento da coluna a1
    li t1, 1 
    mul t1, t1, a1
    add t1, t1, a0
    # t2 = Endereço da imagem da moeda
    mv t2, a2
    # t3 = Posição Y inicial do grid (48)
    li t3, 48
    # t4 = Posição X inicial do grid (Depende da coluna)
    li t4, 32
    mul t4, t4, a1
    LOOP_COIN_ANIMATION:
        # Redenhar o grid
        jal DRAW_GRID
        # Desenhar a moeda no grid
        mv a0, t2
        mv a1, t4
        mv a2, t3
        mv a3, zero
        jal DRAW_IMAGE
        # Para o programa por alguns segundos
        li a0, 200
        #li a7, 32
        #ecall
        
        csrr a1,3073
        jal zero,LOOP_SLEEP
        # Calcular a posição da próxima moeda
volta_sleep:
        addi t1, t1, 7
        addi t3, t3, 32
        # Verificar se chegou na última linha
        li t5, 239
        bgt t3, t5, RET_COIN_ANIMATION
        # Verificar se a próxima posição já tem uma moeda
        lb t5, (t1)
        beqz t5, LOOP_COIN_ANIMATION

    RET_COIN_ANIMATION:
    # Dando load nos valores salvos da pilha
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    #Retornar
    ret


LOOP_SLEEP:
	csrr a6,3073
	sub t6,a6,a1
	blt t6,a0,LOOP_SLEEP
	jal zero,volta_sleep
	

