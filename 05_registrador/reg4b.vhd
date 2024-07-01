--reg4b.vhd
--Registrador de 4 bits em VHDL
--Autor: Pedro Thiago V. de Souza

--Bibliotecas
library ieee;
use ieee.std_logic_1164.all;

--Entidade
entity reg4b is
    port(
        rst, en, clk : in std_logic;
        d : in std_logic_vector (3 downto 0);       --d3 d2 d1 d0 = 4 bits;
        q : out std_logic_vector (3 downto 0)       --Ultima linha do port nao tem ;
    );
end reg4b;

--Arquitetura
architecture comportamento of reg4b is
begin
    --Process: A lista de sensibilidade é o sinal de clk e o de rst, pois toda vida que
    --essas entradas mudarem, a minha saida deverá ser calculada novamente
    process (clk, rst)
    begin
        if (rst = '1') then             --Verifica se houve um rst assincrono
            q <= (others => '0');       --Equivalente à q <= "0000"
        elsif (rising_edge(clk)) then   --Verifica se houve uma borda de subida do clock
            if (en = '1') then          --Verifica se o sinal en = 1.
                q <= d;
            end if;
        end if;
    end process;
end comportamento;