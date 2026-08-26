library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity separador_8_bits is
    Port (
        valor    : in  INTEGER range 0 to 255;
        centenas : out INTEGER range 0 to 9;
        decenas  : out INTEGER range 0 to 9;
        unidades : out INTEGER range 0 to 9
    );
end entity separador_8_bits;

architecture Combinational of separador_8_bits is
begin
    process(valor)
    begin
        centenas <= valor / 100;
        decenas  <= (valor mod 100) / 10;
        unidades <= valor mod 10;
    end process;
end architecture Combinational;
