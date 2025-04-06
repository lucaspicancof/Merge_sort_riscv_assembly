.global main
              
.data
    tamanho: .byte 4            # Defina isso de acordo com o tamanho do testArray
    lista: .byte 10,22,-12,47
    linha: .string "\n"
	virgula: .string " , "

.text
main:
    la a0, lista             	# Carrega o endereço de testArray em a0
    lb t0, tamanho              # Carrega o tamanho do array em t0
    add a1, a0, t0              # Calcula o endereço do último elemento do array
    jal ra, merge_sort          # Chama a função merge_sort

    la a0, lista             	# Carrega o endereço de testArray em a0
    lb a1, tamanho              # Carrega o tamanho do array em a1
    jal ra, print_lista         # Chama a função print_array

    li a7, 10              
    ecall

.text

merge_sort:

   addi sp, sp, -32              # Ajusta o ponteiro da pilha
   sw ra, 0(sp)                  # Salva o endereço de retorno
   sw a0, 8(sp)                  # Salva o endereço do primeiro elemento
   sw a1, 16(sp)                 # Salva o endereço do último elemento

   li t1, 1                      # Tamanho de um elemento
   sub t0, a1, a0                # Calcula o número de elementos
   ble t0, t1, fim_merge_sort    # Se restar apenas um elemento, retorne

   srli t0, t0, 1                # Divide o tamanho do array para obter a metade
   add a1, a0, t0                # Calcula o endereço do ponto médio do array
   sw a1, 24(sp)                 # Armazena o ponto médio na pilha

   jal merge_sort                 # Chama recursivamente a função para a primeira metade do array

   lw a0, 24(sp)                 # Carrega o ponto médio da pilha
   lw a1, 16(sp)                 # Carrega o endereço do último elemento da pilha

   jal merge_sort                 # Chama recursivamente a função para a segunda metade do array

   lw a0, 8(sp)                  # Carrega o endereço do primeiro elemento da pilha
   lw a1, 24(sp)                 # Carrega o endereço do ponto médio da pilha
   lw a2, 16(sp)                 # Carrega o endereço do último elemento da pilha

   jal merge                     # Chama a função merge para mesclar as duas metades ordenadas

fim_merge_sort:
   lw ra, 0(sp)
   addi sp, sp, 32
   ret

merge:
   addi sp, sp, -32              # Ajusta o ponteiro da pilha
   sw ra, 0(sp)                  # Salva o endereço de retorno
   sw a0, 8(sp)                  # Salva o endereço do primeiro elemento do primeiro array
   sw a1, 16(sp)                 # Salva o endereço do primeiro elemento do segundo array
   sw a2, 24(sp)                 # Salva o endereço do último elemento do segundo array
   mv s0, a0                     # Cópia do endereço da primeira metade 
   mv s1, a1                     # Cópia do endereço da segunda metade

merge_loop:
   mv t0, s0                     # Cópia do endereço da posição da primeira metade
   mv t1, s1                     # Cópia do endereço da posição da segunda metade
   lb t0, 0(t0)                  # Carrega o valor da posição da primeira metade
   lb t1, 0(t1)                  # Carrega o valor da posição da segunda metade   
   bgt t1, t0, pula_desloca      # Se o valor da segunda metade for maior, não há necessidade de operações

   mv a0, s1                     # a0 -> elemento a mover
   mv a1, s0                     # a1 -> endereço para mover o elemento
   jal desloca                   # Chama a função desloca
      
   addi s1, s1, 1

pula_desloca: 
   addi s0, s0, 1                # Incrementa o índice da primeira metade para o próximo elemento
   lw a2, 24(sp)                 # Carrega de volta o endereço do último elemento

   bge s0, a2, fim_merge_loop
   bge s1, a2, fim_merge_loop
   beq x0, x0, merge_loop

fim_merge_loop:
   lw ra, 0(sp)
   addi sp, sp, 32
   ret

desloca:
   ble a0, a1, fim_desloca       # Se o local estiver alcançado, pare o deslocamento
   addi t3, a0, -1               # Vai para o elemento anterior no array
   lb t4, 0(a0)                  # Pega o ponteiro do elemento atual
   lb t5, 0(t3)                  # Pega o ponteiro do elemento anterior
   sb t4, 0(t3)                  # Copia o ponteiro do elemento atual para o endereço do elemento anterior
   sb t5, 0(a0)                  # Copia o ponteiro do elemento anterior para o endereço do elemento atual
   mv a0, t3                     # Desloca a posição atual para trás
   beq x0, x0, desloca           # Loop novamente

fim_desloca:
   ret


print_lista:
    addi t0, a0, 0                # Endereço do array
    addi t1, a1, 0                # Tamanho do array
    addi t2, x0, 0                # Índice do loop

print:
    lb t3, 0(t0)                  # Carrega o byte atual do array em t3
    mv a0, t3                     # Move o valor de t3 para a0 para impressão
    li a7, 1                      # Código do ecall para imprimir caractere
    ecall                         # Chama o ecall para imprimir
    addi t0, t0, 1                # Incrementa o endereço do array
    addi t2, t2, 1                # Incrementa o índice
    bge t2, t1, fim_print         # Se o índice atingir o tamanho, termina a impressão
    la a0, virgula                # Carrega o endereço da vírgula
    li a7, 4                      # Código do ecall para imprimir string
    ecall                         # Chama o ecall para imprimir
    jal x0, print                 # Salta de volta para o início do loop

fim_print:
    la a0, linha                  # Carrega o endereço da nova linha
    li a7, 4                      # Código do ecall para imprimir string
    ecall                         # Chama o ecall para imprimir
    jalr x0, ra, 0                # Retorna da função

