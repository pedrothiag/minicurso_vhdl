--fsmd.vhd
--Maquina de estado algoritmica implementada em VHDL
--Autor: Pedro Thiago V. de Souza

--Biblioteca
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;           --Realizar operacoes aritmeticas

--Entidade
entity fsmd is
    port(
        clk, rst, x : in std_logic;
        value : in std_logic_vector (7 downto 0);       --8 bits
        tot : out std_logic_vector (7 downto 0)         --Ultima linha do port nao tem ;
    );
end fsmd;

--Arquitetura
architecture comportamento of fsmd is
    --Pre-ambulo
    type estado is (inicio, esperar, somar, esperar2);
    signal estadoatual, estadoproximo : estado;
    --Registrador referente ao tot
    signal tot_reg : std_logic_vector (7 downto 0);
begin
    --Process 1: Registrador de Estado - Sensibilidade: clk, rst
    registadorestado : process (clk, rst)
    begin
        --Reset --> Estado inicial = inicio
        if (rst='1') then
            estadoatual <= inicio;
        --Borda de subida do clock
        elsif (rising_edge(clk)) then
            estadoatual <= estadoproximo;
        end if;
    end process;

    --Process 2: Logica Combinacional - Sensibilidade: estadoatual, x, value
    logicacombinacional : process (estadoatual, x, value)
    begin
        case estadoatual is
            --inicio
            when inicio =>
                --Ações
                tot_reg <= (others => '0');             --Inicializa o tot_reg em zero
                --Estado proximo
                estadoproximo <= esperar;
            --esperar
            when esperar =>
                --O estado nao faz nenhuma ação
                --Estado proximo
                if (x='0') then
                    estadoproximo <= somar;
                else
                    estadoproximo <= esperar;
                end if;
            --somar
            when somar =>
                --Ações
                tot_reg <= std_logic_vector(unsigned(tot_reg) + unsigned(value));
                --Estado proximo
                estadoproximo <= esperar2;
            --esperar2
            when esperar2 =>
                --O estado nao faz nenhuma ação
                --Estado proximo
                if (x = '0') then
                    estadoproximo <= esperar2;
                else
                    estadoproximo <= esperar;
                end if;
        end case;
    end process;

    --A minha saida tot receba o valor tot_reg
    tot <= tot_reg;
end comportamento;