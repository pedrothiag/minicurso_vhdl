--fsm.vhd
--Maquina de estados implementada em VHDL
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity fsm is
    port(
        x, clk, rst: in std_logic;
        y : out std_logic           --Ultima linha do port nao tem ;
    );
end fsm;

--Arquitetura
architecture comportamento of fsm is
    --Pre-Ambulo
    --Definir um novo tipo, chamado estado, que assume os valores alfa, beta, gamma e delta
    type estado is (alfa, beta, gamma, delta);
    --Crio as variaveis de estado atual e estado proximo
    signal estadoatual, estadoproximo : estado;
begin
    --Process 1: Registrador de estado - lista de sensibilidade: clk, rst
    registradordeestado : process (clk, rst)
    begin
        if (rst = '1') then
            estadoatual <= alfa;            --Estado inicial é o alfa
        elsif (rising_edge(clk)) then
            estadoatual <= estadoproximo;   --As variaveis de estado proximo passam a ser as variaveis de estado atual
        end if;
    end process;
    
    --Process 2: Logica Combinacional - listado de sensibilidade: estadoatual, x
    logicacombinacional : process (estadoatual, x)
    begin
        case estadoatual is
            --Estado alfa
            when alfa =>
                y <= '0';                   --Saida
                --Estado proximo
                if (x='1') then
                    estadoproximo <= alfa;
                else
                    estadoproximo <= beta;
                end if;
            --Estado beta
            when beta =>
                y <= '1';                   --Saida
                --Estado proximo
                if (x='1') then
                    estadoproximo <= gamma;
                else
                    estadoproximo <= beta;
                end if;
            --Estado gamma
            when gamma =>
                y <= '1';                   --Saida
                estadoproximo <= delta;     --Estado proximo
            --Estado delta
            when delta =>
                y <= '0';
                estadoproximo <= alfa;
        end case;
    end process;
end comportamento;