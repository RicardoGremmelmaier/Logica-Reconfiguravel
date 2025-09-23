### Relatório sobre Cascateamento de contadores no Modelsim

Esse arquivo visa esclarecer o aprendizado obtido ao realizar o projeto proposto: um **Totalizador de bits '1'** em uma palavra de 4 bits. O totalizador deve contar 1 bit por ciclo de clock. 

Para isso, foi realizado uma maquina de estados para sincronização das contagens, usando um iterador (módulo 4, incrementando e usando ele para verificar a posição da palavra) e um contador, que deve somar 1 ao seu valor quando encontrar um bit 1.

## Resultados

Os resultados da simulação podem ser vistos a seguir:

* **Início do programa**: como o programa inicia com um reset global, o valor é setado para 12.

    * Simulação RTL
    ![Simulação em RTL](./img/TotalizadorA_rtl.png)

    * Simulação Gate Level
    ![Simulação em GL](./img/TotalizadorA_gate.png)

    * Atraso em Gate Level
    ![Simulação em GL](./img/TotalizadorA_atraso.png)
  
## Frequência máxima obtida

