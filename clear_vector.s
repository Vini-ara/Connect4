.text
# CLEAR_VECTOR: Zera todos os elementos de um vetor
#   > Parâmetros:
#       >> a0 --> Endereço do vetor
#       >> a1 --> Tamanho do vetor em bytes
CLEAR_VECTOR:
    # Salvando registradores temporários na pilha
    addi sp, sp, -28
    sw t0, 24(sp)
    sw t1, 20(sp)
    sw t2, 16(sp)
    sw t3, 12(sp)
    sw t4, 8(sp)
    sw t5, 4(sp)
    sw t6, 0(sp)

    # Inicializando variáveis
    mv t0, a0
    mv t1, a1
    mv t2, zero

    Loop_Clear_Vector:
        sb zero, (t0)
        addi t0, t0, 1
        addi t2, t2, 1
        bne t2, t1, Loop_Clear_Vector

    Ret_Clear_Vector:
        # Load dos resgistradores temporários
        lw t6, 0(sp)
        lw t5, 4(sp)
        lw t4, 8(sp)
        lw t3, 12(sp)
        lw t2, 16(sp)
        lw t1, 20(sp)
        lw t0, 24(sp)
        addi sp, sp, 28
        ret