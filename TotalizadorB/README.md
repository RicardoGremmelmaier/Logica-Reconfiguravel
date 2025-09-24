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

### Na simulação gate_level

Para realizar a frequência máxima obtida, foi necessário visualizar o tempo aproximado entre o delay gerado e o início da subida do clock em que era pra ocorrer a mudança do valor.

Desse modo, fazendo uma média dos valores de atraso obtido para cada um dos totalizadores, temos:

* **Totalizador usando variables e loop for**:

$T_{delay} = \frac{(56.6 - 50) + (116.6 - 110) + (136,4 - 130)}{3} = 6.5\ ns$

$f_{max} = \frac{1}{T_{delay}} = \frac{1}{6.5\ ns} \approx 154\ MHz$

* **Totalizador usando variables e loop while**:

$T_{delay} = \frac{(56.6 - 50) + (116.6 - 110) + (136,4 - 130)}{3} = 6.5\ ns$

$f_{max} = \frac{1}{T_{delay}} = \frac{1}{6.5\ ns} \approx 154\ MHz$

* **Totalizador usando variables e if-then**:

$T_{delay} = \frac{(56.3 - 50) + (116.4 - 110) + (136,3 - 130)}{3} = 6.3\ ns$

$f_{max} = \frac{1}{T_{delay}} = \frac{1}{6.3\ ns} \approx 159\ MHz$

* **Totalizador usando signals e case-when**:

$T_{delay} = \frac{(56.3 - 50) + (116.4 - 110) + (136,3 - 130)}{3} = 6.3\ ns$

$f_{max} = \frac{1}{T_{delay}} = \frac{1}{6.3\ ns} \approx 159\ MHz$

* **Totalizador usando signals e soma direta com conversão direta**:

$T_{delay} = \frac{(56.3 - 50) + (116.4 - 110) + (136,2 - 130)}{3} = 6.3\ ns$

$f_{max} = \frac{1}{T_{delay}} = \frac{1}{6.3\ ns} \approx 159\ MHz$


Por não ser utilizado uma grande quantidade de algarismos significativos, os três últimos totalizadores mantiveram uma frequência máxima muito similar, no entanto, através das simulações, é possível observar que o totalizador 5 foi o que obteve uma melhor performance, já que seu hardware consiste em cascateamento de somadores, o que é bem simples.