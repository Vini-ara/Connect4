.text
# CHECK_TIE: Verifica se ocorreu um emapte, ou seja, todas as posições
#            do grid foram ocupadas e ninguém ganhou.
#   > Argumentos:
#       >> a0 --> Endereço do vetor de alturas
#   > Retorno:
#       >> a0 = 0 --> Não houve empate
#       >> a0 = 1 --> Empate

CHECK_TIE:
    # Salvar registradores temporários na pilha
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
    mv a0, zero
    li t1, 6
    mv t2, zero
    addi t3, t0, 7
    
    # Loop que verifica quantas colunas possuem altura 6 (estão lotadas)
    Loop_Check_Tie:
        lb t4, 0(t0)                # Load da altura em t0
        addi t0, t0, 1              # t0 += 1 (Próximo endereço)
        bne t4, t1, End_Loop_Check_Tie  # Se a altura não for 6, retornar ao início do loop
        addi t2, t2, 1              # Se for, t2 += 1
        End_Loop_Check_Tie:
        bne t0, t3, Loop_Check_Tie  # Se t0 != t3, continuar a executar o loop

    li t1, 7                        # t1 = 7
    bne t2, t1, Ret_Check_Tie       # Se t2 != t1, retornar 0
    li a0, 1                        # Se t2 == t1, retornar 1

    Ret_Check_Tie:
        lw t6, 0(sp)
        lw t5, 4(sp)
        lw t4, 8(sp)
        lw t3, 12(sp)
        lw t2, 16(sp)
        lw t1, 20(sp)
        lw t0, 24(sp)
        addi sp, sp, 28
        ret