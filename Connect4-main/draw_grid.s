.text
# DRAW_GRID
# 

DRAW_GRID:
    # Salavar registradores na pilha
    addi sp, sp, -32
    sw ra, 28(sp)
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)

    # t5 = Endereco do grid
    la t5, grid
    # t0 = 0 (Posição X inicial)
    mv t0, zero
    # t1 = 48 (Posição Y inicial)
    li t1, 48
    # t2 = 0 (Número de vezes que o loop já foi executado)
    mv t2, zero
    # t3 = 42 (Número de vezes que o loop é executado - 42 posições)
    li t3, 42
    LOOP_DRAW_GRID:
    	# t4 = x (valor da posicao no grid) 
    	lb t4, 0(t5)
    	# t4 == 0 ? Desenha um tile vazio
    	beqz t4, DRAW_BLANK
    	# t6 = 2 (valor que representa uma moeda amarela no gird)
    	li t6, 2
    	# t4 == t6 ? Desenha a moeda amarela
    	beq t4, t6, DRAW_AI_COIN
    	# Se nao desenhou nenhuma das anteriores desenha a vermelha
    	mv a0, s2
    	jal zero, LOOP_DRAW_COIN
    
    DRAW_AI_COIN:
    	mv a0, s3	
    	jal zero, LOOP_DRAW_COIN
    	
    DRAW_BLANK:
    	la a0, tile
    
    LOOP_DRAW_COIN:
        # Desenhar a imagem na tela
        mv a1, t0 
        mv a2, t1
        mv a3, zero
        jal DRAW_IMAGE
        
        addi t5, t5, 1
        
        # Calcular posição X da próxima imagem
        addi t0, t0, 32
        # Aumentar o número de vezes que o loop foi executado
        addi t2, t2, 1
        # Verificar se o loop já foi executado 42 vezes
        beq t2, t3, RET_DRAW_GRID
        # t4 = 7
        li t4, 7
        # t4 = resto(t2/t4) (Verificar se t2 é multiplo de 7)
        rem t4, t2, t4 
        # Se t4 não é multiplo de 7 (t4 != 0), voltar para o início do loop
        bnez t4, LOOP_DRAW_GRID
        # Se for múltiplo, 
        # Resetar a posição X para a posição inicial (x = 0)
        mv t0, zero
        # Aumentar a posição Y em 32 (Passar para a próxima linha)
        addi t1, t1, 32
        # Voltar para o início do loop
        j LOOP_DRAW_GRID

    RET_DRAW_GRID:
        # Dando load nos valores salvos na pilha
        lw t6, 0(sp)
        lw t5, 4(sp)
        lw t4, 8(sp)
        lw t3, 12(sp)
        lw t2, 16(sp)
        lw t1, 20(sp)
        lw t0, 24(sp)
        lw ra, 28(sp)
        addi sp, sp, 32
        # Retornar
        ret

