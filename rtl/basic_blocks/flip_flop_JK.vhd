library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flop_JK is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        J     : in  STD_LOGIC;
        K     : in  STD_LOGIC;
        Q     : out STD_LOGIC;
        Qn    : out STD_LOGIC
    );
end entity flip_flop_JK;

architecture Behavioral of flip_flop_JK is
    signal q_reg : STD_LOGIC := '0';
begin

    process(clk, reset)
    begin
        if reset = '1' then
            q_reg <= '0';
        elsif rising_edge(clk) then
            if J = '0' and K = '0' then
                q_reg <= q_reg;        -- Hold
            elsif J = '0' and K = '1' then
                q_reg <= '0';          -- Reset
            elsif J = '1' and K = '0' then
                q_reg <= '1';          -- Set
            elsif J = '1' and K = '1' then
                q_reg <= not q_reg;    -- Toggle
            end if;
        end if;
    end process;

    Q  <= q_reg;
    Qn <= not q_reg;

end architecture Behavioral;
