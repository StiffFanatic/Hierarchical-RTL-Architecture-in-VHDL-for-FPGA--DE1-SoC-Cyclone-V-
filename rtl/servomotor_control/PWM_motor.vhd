library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_motor is
    Port (
        clk      : in  STD_LOGIC; -- Reloj de entrada 50 MHz
        entrada  : in  STD_LOGIC_VECTOR(7 downto 0); -- Mapeo de ángulo (0 - 255)
        pwm_out  : out STD_LOGIC
    );
end entity PWM_motor;

architecture Behavioral of PWM_motor is
    -- Reloj 50 MHz -> T = 20 ns
    -- Período 50 Hz -> 1_000_000 ciclos de reloj (20 ms)
    constant PERIOD_50HZ : INTEGER := 1_000_000;
    
    -- Pulso Mínimo (0.5 ms) -> 25_000 ciclos
    constant PULSE_MIN   : INTEGER := 25_000;
    
    -- Pulso Máximo (3.2 ms) -> 160_000 ciclos
    constant PULSE_MAX   : INTEGER := 160_000;

    signal counter : INTEGER range 0 to PERIOD_50HZ := 0;
    signal high_cycles : INTEGER range 0 to PERIOD_50HZ := PULSE_MIN;
begin

    -- Proceso para actualizar el tiempo en alto según entrada
    process(clk)
        variable val_in : INTEGER;
    begin
        if rising_edge(clk) then
            val_in := to_integer(unsigned(entrada));
            high_cycles <= PULSE_MIN + ((PULSE_MAX - PULSE_MIN) * val_in) / 255;
        end if;
    end process;

    -- Generación de PWM por contador
    process(clk)
    begin
        if rising_edge(clk) then
            if counter < PERIOD_50HZ - 1 then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;

            if counter < high_cycles then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;
        end if;
    end process;

end architecture Behavioral;
