# Merge Sort em Assembly RISC-V

Este repositório contém uma implementação do algoritmo de ordenação Merge Sort em assembly RISC-V, desenvolvido como parte de um trabalho para a disciplina de Arquitetura de Computadores.

## Descrição

O algoritmo Merge Sort é uma técnica de ordenação eficiente que utiliza a estratégia "dividir para conquistar". Este projeto implementa o Merge Sort em assembly RISC-V, demonstrando a manipulação de arrays, recursão e operações de memória em baixo nível.

## Características

- Implementação completa do Merge Sort em assembly RISC-V
- Ordenação de array de bytes com suporte a números negativos
- Uso de recursão para dividir o problema em subproblemas menores
- Função de mesclagem (merge) para combinar sub-arrays ordenados
- Rotina de impressão para visualizar o array ordenado

## Requisitos

Para executar este código, você precisará de:

- [RARS (RISC-V Assembler and Runtime Simulator) versão 1.6](https://github.com/TheThirdOne/rars)

## Estrutura do Código

O código está organizado nas seguintes seções:

- `.data`: Definição do array a ser ordenado e strings para impressão
- `main`: Ponto de entrada do programa que chama as funções principais
- `merge_sort`: Implementação recursiva do algoritmo Merge Sort
- `merge`: Função que combina dois sub-arrays ordenados
- `desloca`: Função auxiliar para deslocar elementos durante a mesclagem
- `print_lista`: Função para imprimir o array ordenado

## Como Executar

1. Abra o arquivo `merge-sort.asm` no RARS
2. Compile o código (Assemble)
3. Execute o programa (Run)
4. O resultado será exibido na saída do console

## Entendendo o Código

Embora a maioria das linhas do código contenha comentários explicando sua função, para uma compreensão mais profunda recomenda-se executar o programa no RARS em modo passo a passo (utilizando a opção "Step"). Isso permite observar as mudanças na memória e nos registradores após cada instrução, facilitando o entendimento do algoritmo de ordenação. O RARS oferece visualizações de memória e registradores que são extremamente úteis para acompanhar o fluxo de execução e as manipulações de dados.

## Funcionamento

O algoritmo implementado segue os seguintes passos:

1. Divide o array em duas metades
2. Chama recursivamente a função `merge_sort` para cada metade
3. Combina as duas metades ordenadas usando a função `merge`
4. A função `desloca` é usada para inserir elementos na posição correta durante a mesclagem
5. O array ordenado é impresso na tela

## Exemplo de Saída

Para o array de entrada `[10, 22, -12, 47, 0, 6, 7, 8, 9, -11]`, a saída será:
```
-12 , -11 , 0 , 6 , 7 , 8 , 9 , 10 , 22 , 47
```
