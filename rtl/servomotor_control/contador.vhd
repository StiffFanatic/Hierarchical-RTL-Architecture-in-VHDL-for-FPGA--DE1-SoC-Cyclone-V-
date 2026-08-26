library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        PA       : in  STD_LOGIC; -- Pulsador Aumento (Activo en '0')
        PD       : in  STD_LOGIC; -- Pulsador Disminución (Activo en '0')
        angulo   : out INTEGER range 0 to 180
    );
end entity contador;

architecture Behavioral of contador is
    signal angulo_reg : INTEGER range 0 to 180 := 0;
    signal pa_prev    : STD_LOGIC := '1';
    signal pd_prev    : STD_LOGIC := '1';
begin

    process(clk, reset)
    begin
        if reset = '1' then
            angulo_reg <= 0;
            pa_prev    <= '1';
            pd_prev    <= '1';
        elsif rising_edge(clk) then
            -- Detección de flanco de bajada para Pulsador Aumento (PA)
            if PA = '0' and pa_prev = '1' then
                if angulo_reg <= 170 then
                    angulo_reg <= angulo_reg + 10;
                end if;
            end if;

            -- Detección de flanco de bajada para Pulsador Disminución (PD)
            if PD = '0' and pd_prev = '1' then
                if angulo_reg >= 10 then
                    angulo_reg <= angulo_reg - 10;
                end if;
            end if;

            pa_prev <= PA;
            pd_prev <= PD;
        end if;
    end process;

    angulo <= angulo_reg;

end architecture Behavioral;
