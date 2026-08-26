library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port (
        a     : in  STD_LOGIC;
        b     : in  STD_LOGIC;
        sum   : out STD_LOGIC;
        cout  : out STD_LOGIC
    );
end entity half_adder;

architecture RTL of half_adder is
begin
    sum  <= a xor b;
    cout <= a and b;
end architecture RTL;
