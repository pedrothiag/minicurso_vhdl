--fsmd_tb.vhd
--Testbench para o projeto da maquina de estados algoritmica
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use std.env.stop;       --Responsável por permitir usar a diretiva stop

--Entidade
entity fsmd_tb is
end;

--Arquitetura
architecture testbench of fsmd_tb is
    --Chamar o bloco no qual eu quero testar
    component fsmd is
        port(
            clk, rst, x : in std_logic;
            value : in std_logic_vector (7 downto 0);       --8 bits
            tot : out std_logic_vector (7 downto 0)         --Ultima linha do port nao tem ;
        );
    end component;

    --Declarar as entradas e saidas como signals
    signal Clk : std_logic := '0';                          --O valor inicial do clock é zero.
    signal Rst : std_logic;
    signal X : std_logic;
    signal Value : std_logic_vector (7 downto 0);
    signal Tot : std_logic_vector (7 downto 0);

    --Declarar o periodo de clock como uma constante
    constant clock_period : time := 10 ns;
begin
    --Instanciar o bloco que eu quero testar
    uut : fsmd port map (clk => Clk, rst => Rst, x => X, value => Value, tot => Tot);

    --Gerar o sinal de clock
    Clk <= not Clk after clock_period/2;

    --Processo de geração de estimulos. Esse processo não tem lista de sensibilidade
    process
    begin
        --Inicialmente, vou fazer um reset
        Rst <= '1';
        X <= '1';
        value <= "00000000";
        wait for 80 ns;                 --Permanecem nesses valores por 80 ns

        --Deixar de fazer o reset
        Rst <= '0';
        wait for 50 ns;                 --Permanece nesse valor por 50 ns

        --Setar o valor de value
        value <= "00001010";            --Coloca value em 10
        wait for 30 ns;                 --Permanece nesse valor por 30 ns;

        --Somar
        X <= '0';
        wait for 60 ns;

        --Tornar novamente X = 1
        X <= '1';
        wait for 100 ns;

        --Setar o valor de value
        value <= "00011011";
        wait for 20 ns;

        --Efetuar uma nova soma
        X <= '0';
        wait for 80 ns;

        --Tornar novamente X = 1
        X <= '1';
        wait for 30 ns;

        --Reset na máquina
        Rst <= '1';
        wait for 40 ns;

        --Encerrar a simulação
        stop;
    end process;
end testbench;