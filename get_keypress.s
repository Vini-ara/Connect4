.text
# GET_KEYPRESS
#     -Essa funcao retorna um valor da tecla sendo pressionada no momento da chamada
#     -Retorno:
#         > a0 = codigo ASCII do caractere sendo pressionado

GET_KEYPRESS:
  #salvar os registradores utilizados
  addi sp, sp, -12
  sw ra, 8(sp)
  sw t0, 4(sp)
  sw t1, 0(sp)

  #verificando se ha uma tecla pressionada
  mv a0, zero
  li t1, 0xFF200000 # endereco do KDMMIO
  lw t0, 0(t1) # Le o bit de Controle
  andi t0, t0, 0x0001 # mascara o bit menos significativo
  beq t0, zero, RET_KEYPRESS
  lw a0, 4(t1)
  sw a0, 12(t1)

  RET_KEYPRESS:
    #carrega os registradores salvos de volta
    lw t1, 0(sp)
    lw t0, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    #Retorna 
    ret
