### Relatório sobre Cascateamento de contadores no Modelsim

Esse arquivo visa esclarecer o aprendizado obtido ao realizar o projeto proposto: um **contador módulo 57** (de 12 a 68) utilizando dois contadores **módulo 16**. O contador utiliza um clock síncrono e igual para todos os contadores, onde o primeiro contador representa os 4 bits menos significativos e o segundo representa os bits mais significativos. 

Para que o projeto funcione corretamente, foi necessário alterar a forma em que o *EN* do segundo contador funciona. Para realizar essa ativação, devemos manter o sinal em nível lógico alto apenas quando o primeiro contador realizar um ciclo completo, ou seja, quando ele chegar no valor "1111" e for cair para "0000". Dessa forma, o cascateamento ocorre de forma que o segundo contador funcione como os bits mais significativos.

Para realizar o módulo 57, foi realizado um LOAD sempre que necessário, ou seja, quando o valor chegar em 68 é realizado um *LOAD* diretamente para 12, de forma similar para *RST* ou *CLR*.

## Resultados

Os resultados da simulação podem ser vistos a seguir:

* **Início do programa**: como o programa inicia com um reset global, o valor é setado para 12.

    * Simulação RTL
    ![Simulação em RTL](./img/rtl_start.png)

    * Simulação Gate Level
    ![Simulação em GL](./img/gate_start.png)

* **Delay**: a simulação em RTL não gera atrasos, porém a com gate level sim, a fim de simular o que aconteceria na placa.

    * Simulação Gate Level - podemos observar a variação dos valores antes de chegar no correto (de 23 para 24).
    ![Simulação em GL](./img/gate_delay.png)

* **CLEAR**: Ao realizar um CLR no sistema, ambos voltam para 12.

    * Simulação RTL
    ![Simulação em RTL](./img/rtl_clear.png)

    * Simulação Gate Level - podemos observar aqui uma das diferenças causadas pelo atraso: o CLR só ocorreu no valor 33 no Gate Level, enquanto no RTL ocorreu no 32, para mesmo tempo setado de CLR.
    ![Simulação em GL](./img/gate_clear.png)

* **LOAD**: um dos requisitos era que a função de LOAD funcionasse no contador módulo 57. Ambos ocorreram de forma correta.

    * Simulação RTL
    ![Simulação em RTL](./img/rtl_load.png)

    * Simulação Gate Level
    ![Simulação em GL](./img/gate_load.png)

* **EN off**: caso o en seja desabilitado, ambos os contadores irão parar.

    * Simulação RTL
    ![Simulação em RTL](./img/rtl_en_off.png)

    * Simulação Gate Level
    ![Simulação em GL](./img/gate_en_off.png)

* **Transição de estado**: como foi pedido módulo 57 (e reinício em 68), ambos respeitaram essa demanda.

    * Simulação RTL
    ![Simulação em RTL](./img/rtl_transition.png)

    * Simulação Gate Level
    ![Simulação em GL](./img/gate_transition.png)    

## Conclusão

É nítida a diferença entre os dois módulos de simulação (**RTL e Gate Level**), demonstrando então a importância de efetuar corretamente ambas as simulações para entender caso ocorra inconsistências na hora de executar algum programa na placa.

