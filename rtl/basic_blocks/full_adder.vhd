library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port (
        a     : in  STD_LOGIC;
        b     : in  STD_LOGIC;
        cin   : in  STD_LOGIC;
        sum   : out STD_LOGIC;
        cout  : out STD_LOGIC
    );
end entity full_adder;

architecture Structural of full_adder is
    component half_adder is
        Port (
            a     : in  STD_LOGIC;
            b     : in  STD_LOGIC;
            sum   : out STD_LOGIC;
            cout  : out STD_LOGIC
        );
    end component;

    signal s1, c1, c2 : STD_LOGIC;
begin
    HA1: half_adder port map ( a => a,  b => b,   sum => s1,  cout => c1 );
    HA2: half_adder port map ( a => s1, b => cin, sum => sum, cout => c2 );

    cout <= c1 or c2;
end architecture Structural;
