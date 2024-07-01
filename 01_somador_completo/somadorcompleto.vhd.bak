--somadorcompleto.vhd
--Somador completo em VHDL
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
LIBRARY ieee;
USE ieee.std_logic_1164.all;

--Entity
ENTITY somadorcompleto IS
    PORT(
        a, b, cin   :   IN STD_LOGIC;
        s, cout     :   OUT STD_LOGIC       --Ultima linha do PORT nao tem ;
    );
END somadorcompleto;

--Architecture
ARCHITECTURE dataflow OF somadorcompleto IS
BEGIN 
    s <= a XOR b XOR cin;
    cout <= (a AND b) OR (a AND cin) OR (b AND cin);
END dataflow;