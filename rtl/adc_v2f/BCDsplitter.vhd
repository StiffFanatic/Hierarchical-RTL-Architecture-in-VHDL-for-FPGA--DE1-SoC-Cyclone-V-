library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCDsplitter is
    Port (
        clk      : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR(11 downto 0); -- 0 a 4095
        d_miles  : out INTEGER range 0 to 9;
        d_ciens  : out INTEGER range 0 to 9;
        d_decs   : out INTEGER range 0 to 9;
        d_unis   : out INTEGER range 0 to 9
    );
end entity BCDsplitter;

architecture Synchronous of BCDsplitter is
begin
    process(clk)
        variable val : INTEGER;
    begin
        if rising_edge(clk) then
            val := to_integer(unsigned(data_in));
            d_miles <= val / 1000;
            d_ciens <= (val mod 1000) / 100;
            d_decs  <= (val mod 100) / 10;
            d_unis  <= val mod 10;
        end if;
    end process;
end architecture Synchronous;
