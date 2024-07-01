--alu.vhd
--Unidade Logico-Aritmetica em VHDL
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;           --Serve para realizar operacoes aritmeticas

--Entidade
entity alu is
    port(
        a, b : in std_logic_vector (7 downto 0);       --a7 a6 a5 a4 a3 a2 a1 a0 == 8 bits
        sel  : in std_logic_vector (2 downto 0);       --sel2 sel1 sel0 == 3 bits (xyz)
        s    : out std_logic_vector (7 downto 0)       --ultima linha do port nao tem ;
    );
end alu;

--Arquitetura
architecture comportamento of alu is
begin
    --with select when
    --a variavel de selecao eh sel
    with sel select
        --Para realizar as operacoes aritmeticas, os dados devem ser unsigned ou signed
        --Porem unsigned(a) + unsigned(b) resulta em unsigned, a saida s eh std_logic_vector
        --Entao eh necessario a conversao de unsigned para std_logic_vector
        s <= std_logic_vector(unsigned(a) + unsigned(b)) when "000",       --usar , ao inves do ;
             std_logic_vector(unsigned(a) - unsigned(b)) when "001",
             std_logic_vector(unsigned(a) + 1) when "010",
             a when "011",
             a and b when "100",    --As operacoes logicas sao realizadas somente com dados std_logic ou std_logic_vector
             a or b when "101",
             a xor b when "110",
             not a when "111",
             (others => '0') when others;           --Condicao nula
                                                    --(others => '0') indica que a saida vai ser toda em 0
                                                    --Na ultima condicao, usar ;
end comportamento;