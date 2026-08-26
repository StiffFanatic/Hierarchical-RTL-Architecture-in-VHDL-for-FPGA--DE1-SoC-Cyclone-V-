library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity v2f is
    Port (
        clk         : in  STD_LOGIC;
        adc_val     : in  STD_LOGIC_VECTOR(11 downto 0); -- 0 a 4095
        freq_target : out INTEGER range 1000 to 100000    -- 1 kHz a 100 kHz
    );
end entity v2f;

architecture Behavioral of v2f is
begin
    process(clk)
        variable adc_int : INTEGER;
    begin
        if rising_edge(clk) then
            adc_int := to_integer(unsigned(adc_val));
            -- Mapeo lineal: F_out = 1000 + (99000 * ADC) / 4095
            freq_target <= 1000 + ((99000 * adc_int) / 4095);
        end if;
    end process;
end architecture Behavioral;
