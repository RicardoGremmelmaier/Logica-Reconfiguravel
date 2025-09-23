### Relatório sobre Totalizadores de bit 1 no Modelsim

Esse arquivo visa esclarecer o aprendizado obtido ao realizar o projeto proposto: um **Totalizador de bits '1'** em uma palavra de 4 bits. O totalizador deve conter 5 tipos de saídas diferentes, entre elas:

* Usando **Variables** e loop **for**;
* Usando **Variables** e loop **while**;
* Usando **Variables** e **if-then**;
* Usando **Signals** e **case-when**;
* Usando **Signals** e **soma direta com conversão direta dos bits de entrada**;

Para isso, foi realizado 5 processos diferentes, um para cada tipo de totalizador, obedecendo as regras impostas.

## Resultados

Os resultados da simulação podem ser vistos a seguir:

* **Overview do programa**: como o programa inicia com um reset global, o valor é setado para 12.

    * Simulação RTL
    ![Simulação em RTL](./img/TotalizadorB_rtl.png)

    * Simulação Gate Level
    ![Simulação em GL](./img/TotalizadorB_gate.png)

* **Atrasos e diferenças de propagação**:

    * Atraso 1 em Gate Level
    ![Simulação em GL](./img/TotalizadorB_atrasoComparativo.png)
  
    * Atraso 2 em Gate Level
    ![Simulação em GL](./img/TotalizadorB_atraso2.png)

    * Atraso 3 em Gate Level
    ![Simulação em GL](./img/TotalizadorB_atraso3.png)
## Frequência máxima obtida

