--somador4b.vhd
--Somador de 4 bits em VHDL utilizando operadores aritmeticos
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;       --Operacoes aritmeticas exigem a numeric_std

--Entidade
entity somador4b is
    port(
        a : in std_logic_vector (3 downto 0);       --a3 a2 a1 a0 == 4 bits
        b : in std_logic_vector (3 downto 0);
        s : out std_logic_vector (3 downto 0)       --ultima linha do port nao tem ;
    );
end somador4b;

--Arquitetura
architecture dataflow of somador4b is
begin
    --A operacao de soma so pode ser feita em cima de unsigned ou signed
    --unsigned(a) + unsigned(b) é do tipo unsigned, mas s eh tipo std_logic_vector
    s <= std_logic_vector(unsigned(a) + unsigned(b));
end dataflow;