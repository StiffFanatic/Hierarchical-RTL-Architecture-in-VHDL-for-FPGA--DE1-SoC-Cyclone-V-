library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_7seg is
    Port (
        bcd : in  INTEGER range 0 to 9;
        hex : out STD_LOGIC_VECTOR(6 downto 0) -- Catodo común / Activo en '0'
    );
end entity bcd_7seg;

architecture Table of bcd_7seg is
begin
    process(bcd)
    begin
        case bcd is
            when 0 => hex <= "1000000"; -- '0'
            when 1 => hex <= "1111001"; -- '1'
            when 2 => hex <= "0100100"; -- '2'
            when 3 => hex <= "0110000"; -- '3'
            when 4 => hex <= "0011001"; -- '4'
            when 5 => hex <= "0100101"; -- '5'
            when 6 => hex <= "0000010"; -- '6'
            when 7 => hex <= "1111000"; -- '7'
            when 8 => hex <= "0000000"; -- '8'
            when 9 => hex <= "0010000"; -- '9'
            when others => hex <= "1111111"; -- Apagado
        end case;
    end process;
end architecture Table;
