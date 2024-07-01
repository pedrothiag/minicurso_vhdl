---somador4b.vhd
--Somador de 4 bits utilizando a abordagem estrutural
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
--Nao vamos precisar da numeric_std pois nao vamos utilizar operacoes aritméticas
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity somador4b is
    port(
        A : in std_logic_vector(3 downto 0);        --a3a2a1a0 = 4 bits
        B : in std_logic_vector(3 downto 0);        --b3b2b1b0 = 4 bits
        Cin : in std_logic;
        S: out std_logic_vector(3 downto 0);        --s3s2s1s0 = 4 bits
        Cout: out std_logic                         --ultima linha do port nao tem ;
    );
end somador4b;

--Arquitetura
architecture stucture of somador4b is
--Pre-ambulo = components e signals
--Component do somadorcompleto
component somadorcompleto IS
    port(
        a, b, cin   :   in std_logic;
        s, cout     :   out std_logic       --Ultima linha do PORT nao tem ;
    );
end component;
--Signals
signal c1, c2, c3 : std_logic;
begin
    u0 : somadorcompleto port map (a=>A(0), b=>B(0), cin=>Cin, s=>S(0), cout=>c1);
    u1 : somadorcompleto port map (a=>A(1), b=>B(1), cin=>c1, s=>S(1), cout=>c2);
    u2 : somadorcompleto port map (a=>A(2), b=>B(2), cin=>c2, s=>S(2), cout=>c3);
    u3 : somadorcompleto port map (a=>A(3), b=>B(3), cin=>c3, s=>S(3), cout=>Cout);
end stucture;