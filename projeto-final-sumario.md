 README – Projeto Final – XTEA DE2-2
=========================================

## Autores: Pedro Augusto Scalcon, Ricardo Marthus Gremmelmaier

Este projeto implementa um sistema completo de criptografia em HARDWARE 
usando o algoritmo XTEA na placa Altera DE2-2. A comunicação ocorre
via TCP/IP utilizando sockets tradicionais. O sistema conta também
com um periférico físico (LCD 16x2) para exibição de status.

Estrutura do projeto:
---------------------
/DE2_NET/          → Projeto do Quartus + Qsys + NIOS \
/Outputs/          → Saída de arquivos processados \
/VHD_files/ Encypher/ → Módulos VHDL (XTEA + Interface Avalon) \
/web-page/         → Front-end React \
RelatorioProjetoFinal.pdf \
Projeto_Final.zip

## 1. Objetivo do Sistema

- Receber textos ou arquivos através do servidor Python.
- Enviar os dados para a placa via socket TCP/IP.
- Processar criptografia/descriptografia usando o módulo XTEA em VHDL.
- Retornar o resultado ao servidor e ao front-end.
- Exibir mensagens no LCD durante o processo:
      "Encrypting..."
      "Done!"

O projeto demonstra comunicação completa entre:
Front-end → Servidor Python → Placa DE2/NIOS II → Hardware VHDL.

## 2. Componentes do Projeto

#### 2.1 HARDWARE (VHDL)

O hardware XTEA é composto por:

- XTEA_Encrypt.vhd
- XTEA_Decrypt.vhd
- XTEA_Controller.vhd   (FSM de controle)
- Avalon_Interface.vhd   (registradores)
- LCD_Controller.vhd     (controle do LCD 16x2)

Interface Avalon-MM:
- 4 registradores de chave (128 bits total)
- 2 registradores de entrada de dados (64 bits)
- 2 registradores de saída de dados (64 bits)
- registrador START
- registrador FINISHED

#### 2.2 Cliente NIOS II (C)

Responsável por:
- Conectar via socket TCP a um servidor Python.
- Receber comandos ('k', 'a', 'b', 'f', 'e', 'd').
- Escrever/ler registradores Avalon do hardware XTEA.
- Manipular blocos de 64 bits.
- Mostrar status no LCD:

Durante criptografia:
    lcd_show("Encrypting...", "");
Ao finalizar:
    lcd_show("Done!", "");

#### 2.3 Servidor Python

- API REST para comunicação com o front-end.
- Conversão e padding de blocos de 64 bits.
- Envio dos comandos para a placa DE2.
- Recebimento de blocos processados.
- Escrita final de resultados na pasta Outputs.

#### 2.4 Front-end React

- Envio de arquivos e textos para criptografia.
- Comunicação com o servidor via Axios.
- Exibição dos outputs retornados.

## 3. Como Reconstruir o Projeto

#### 3.1 FRONT-END (React)

cd web-page \
npm install \
npm start

#### 3.2 SERVIDOR PYTHON

pip install flask cryptography \
python server.py

Configurar IP da placa editando:
server.py → variável HOST

#### 3.3 HARDWARE (Quartus)

1) Abrir DE2_NET/DE2_NET.qpf
2) Compilar o projeto
3) Programar a placa com Tools → Programmer → Start

#### 3.4 SOFTWARE (NIOS II Eclipse)

1) Abrir "Nios II Software Build Tools for Eclipse"
2) Gerar BSP:
      Right click → NIOS II → Generate BSP
3) Build Project
4) Ajustar IP em init.c:
      sa.sin_addr.s_addr = inet_addr("SEU_IP_AQUI");
5) Run as → Nios II Hardware


## 4. LCD – Funcionamento


O LCD 16x2 é manipulado via módulo LCD_Controller.vhd e
registradores dedicados no Avalon.

Durante qualquer operação de criptografia:
    "Encrypting..."

Após finalizar:
    "Done!"

O LCD é atualizado automaticamente pelo cliente em C no NIOS II.

## 5. Notas Importantes

- O algoritmo utilizado é XTEA (64-bit block cipher, 128-bit key).
- O servidor aplica padding baseado em blocos de 8 bytes.
- Todos os arquivos gerados vão para /Outputs/.

