.text
#   CHECK_VICTORY: Verifica se um jogador ganhou
#       > Argumentos:
#           >> a0 = Jogador (1 ou 2)
#           >> a1 = Enderço da lista de moedas

CHECK_VICTORY:
    addi sp, sp, -32
    sw ra, 28(sp)
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)

    mv t0, a0
    mv t1, a1

    Loop_Check_Victory:
        li t2, 42
        slli t2, t2, 2
        add t2, t2, t1
        beq t1, t2, Ret_Check_Victory

        # Load no endereço da peça
        lw t3, 0(t1)
        beqz t3, Ret_Check_Victory
        
        # Load na coluna da peça
        lb t4, 4(t1)
        
        # Verificar se é possível ter 3 peças a esquerda
        li t5, 3
        blt t4, t5, Victory_Right

        # Verificar condição de vitória pela esquerda
        mv a0, t3
        mv a1, t0
        jal CHECK_LEFT
        bnez a0, Victory

        
        Victory_Right:
            # Verificar se é possível ter 3 peças a direita 
            li t5, 3
            bgt t4, t5, Victory_Up

            # Verificar condição de vitória pela direita
            mv a0, t3
            mv a1, t0
            jal CHECK_RIGHT
            bnez a0, Victory

        Victory_Up:
            # Verificar se é possível ter 3 peças acima
            blt t3, s2, Victory_Down

            # Verificar condição de vitória por cima
            mv a0, t3
            mv a1, t0
            jal CHECK_UP
            bnez a0, Victory

        Victory_Down:
            # Verificar se é possível ter 3 peças acima
            bge t3, s2, Victory_Diagonal_Up_Right

            # Verificar condição de vitória por cima
            mv a0, t3
            mv a1, t0
            jal CHECK_DOWN
            bnez a0, Victory

        Victory_Diagonal_Up_Right:
            # Verificar se é possível ter 3 peças acima
            ble t3, s4, Victory_Diagonal_Down_Right
            li t5, 3
            bgt t4, t5, Victory_Diagonal_Up_Left 

            # Verificar condição de vitória por cima
            mv a0, t3
            mv a1, t0
            jal CHECK_DIAGONAL_UP_RIGHT
            bnez a0, Victory

        Victory_Diagonal_Up_Left:
            # Verificar se é possível ter 3 peças acima
            ble t3, s4, Victory_Diagonal_Down_Right
            li t5, 3
            blt t4, t5, Victory_Diagonal_Down_Right 

            # Verificar condição de vitória por cima
            mv a0, t3
            mv a1, t0
            jal CHECK_DIAGONAL_UP_LEFT
            bnez a0, Victory
        
        Victory_Diagonal_Down_Right:
            # Verificar se é possível ter 3 peças acima
            bgt t3, s4, End_Loop_Check_Victory
            li t5, 3
            bgt t4, t5, Victory_Diagonal_Down_Left

            # Verificar condição de vitória por cima
            mv a0, t3
            mv a1, t0
            jal CHECK_DIAGONAL_DOWN_RIGHT
            bnez a0, Victory

        Victory_Diagonal_Down_Left:
            # Verificar se é possível ter 3 peças acima
            bgt t3, s4, End_Loop_Check_Victory
            li t5, 3
            blt t4, t5, End_Loop_Check_Victory

            # Verificar condição de vitória por cima
            mv a0, t3
            mv a1, t0
            jal CHECK_DIAGONAL_DOWN_LEFT
            bnez a0, Victory

        End_Loop_Check_Victory:
        # Nenhuma condição foi atendida --> Retornar 0
        addi t1, t1, 8
        mv a0, zero
        j Loop_Check_Victory

    Victory:
    # Alguma das condições foi atendida --> Retornar 1
    li a0, 1

    Ret_Check_Victory:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    lw ra, 28(sp)
    addi sp, sp, 32
    ret



# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_DOWN:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça abaixo
    lb t2, 7(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça abaixo
    lb t2, 14(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça abaixo
    lb t2, 21(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Down:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_UP:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, -7(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, -14(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, -21(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Up:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_LEFT:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, -1(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, -2(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, -3(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Left:    
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_RIGHT:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, 1(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, 2(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, 3(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Right:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_DIAGONAL_UP_RIGHT:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, -6(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, -12(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, -18(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Diagonal_Up_Right:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_DIAGONAL_UP_LEFT:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, -8(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, -16(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, -24(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Diagonal_Up_Left:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_DIAGONAL_DOWN_RIGHT:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, 8(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, 16(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, 24(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Diagonal_Down_Right:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret


# Verifica se existem 3 peças iguais embaixo de uma peça
# a0 --> Endereço da peça base
# a1 --> Jogador/IA
# Retorna 1 se o Jogador/IA ganhou
CHECK_DIAGONAL_DOWN_LEFT:
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)
    
    # Inicializando registradores
    mv t0, a0
    mv t1, a1
    mv a0, zero

    # Verificando primeira peça acima
    lb t2, 6(t0)
    bne t2, t1, Ret_Check_Down

    # Verificando segunda peça acima
    lb t2, 12(t0)
    bne t2, t1, Ret_Check_Down
    
    # Verificando terceira peça acima
    lb t2, 18(t0)
    bne t2, t1, Ret_Check_Down
    
    # As três peças são iguais
    li a0, 1

    Ret_Check_Diagonal_Down_Left:
    lw t6, 0(sp)
    lw t5, 4(sp)
    lw t4, 8(sp)
    lw t3, 12(sp)
    lw t2, 16(sp)
    lw t1, 20(sp)
    lw t0, 24(sp)
    addi sp, sp, 28
    ret
