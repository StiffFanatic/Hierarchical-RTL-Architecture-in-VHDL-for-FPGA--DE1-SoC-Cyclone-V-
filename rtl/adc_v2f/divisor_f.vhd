library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisor_f is
    Generic (
        INPUT_FREQ  : INTEGER := 50_000_000 -- Reloj maestro (50 MHz)
    );
    Port (
        clk         : in  STD_LOGIC;
        target_freq : in  INTEGER range 1000 to 100000;
        clk_out     : out STD_LOGIC
    );
end entity divisor_f;

architecture Behavioral of divisor_f is
    signal count   : INTEGER := 0;
    signal clk_reg : STD_LOGIC := '0';
begin

    process(clk)
        variable limit : INTEGER;
    begin
        if rising_edge(clk) then
            limit := INPUT_FREQ / (2 * target_freq);
            
            if count >= limit - 1 then
                count   <= 0;
                clk_reg <= not clk_reg;
            else
                count   <= count + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_reg;

end architecture Behavioral;
