.text
# DRAW_IMAGE
#   - A função limpa a tela pintado-a de preto
#   - Parâmetros:
#       > a0 = Frame (0 ou 1)
#   - Registradores Temporários
#       > t0 = Endereço do Bitmap Display
#       > t1 = Endereço da imagem  
#       > t2 = Contador de linha
#       > t3 = Contador de coluna
#       > t4 = Largura da imagem   
#       > t5 = Comprimento da imagem
CLEAR_SCREEN:
    # Guardando valores dos registradores temporários na pilha
    addi sp, sp, -8
    sw t0, 4(sp)
    sw t1, 0(sp)
    # Calculando endereço do Frame
    li t0, 0xFF0                    # Inicializando t0 = 0xFF0
    add t0, t0, a0                  # t0 = t0 + a3
    slli t0, t0, 20                 # Shiftando 20 bits a esquerda de t0

    li t1, 0 # contador de pixels
    li t2, 76800 # tamanho da tela 
    # Loop - Desenha a imagem linha a linha
    CLEAR:
      sb zero, 0(t0)
      addi t1, t1, 1
      addi t0, t0, 1

      blt t1, t2, CLEAR
      # Recarregar os valores dos registradores temporários
      lw t1, 0(sp)
      lw t0, 4(sp)
      addi sp, sp, 8
      ret
