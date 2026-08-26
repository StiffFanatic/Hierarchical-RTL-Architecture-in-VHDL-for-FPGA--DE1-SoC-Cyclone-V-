library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.Componentes.all;

entity TopLevel_Servo is
    Port (
        CLOCK_50 : in  STD_LOGIC;               -- Reloj FPGA 50 MHz
        KEY      : in  STD_LOGIC_VECTOR(2 downto 0); -- KEY(0): Reset, KEY(1): PA, KEY(2): PD
        HEX0     : out STD_LOGIC_VECTOR(6 downto 0); -- Unidades
        HEX1     : out STD_LOGIC_VECTOR(6 downto 0); -- Decenas
        HEX2     : out STD_LOGIC_VECTOR(6 downto 0); -- Centenas
        GPIO_0   : out STD_LOGIC_VECTOR(0 downto 0)  -- Salida PWM a Servomotor
    );
end entity TopLevel_Servo;

architecture Structural of TopLevel_Servo is
    signal angulo_val   : INTEGER range 0 to 180;
    signal cent_d, dec_d, uni_d : INTEGER range 0 to 9;
    signal pwm_signal   : STD_LOGIC;
    signal input_8bits  : STD_LOGIC_VECTOR(7 downto 0);
begin

    -- Instancia 1: Contador de Grados
    U1: contador port map (
        clk    => CLOCK_50,
        reset  => not KEY(0),
        PA     => KEY(1),
        PD     => KEY(2),
        angulo => angulo_val
    );

    -- Instancia 2: Separador BCD
    U2: separador_8_bits port map (
        valor    => angulo_val,
        centenas => cent_d,
        decenas  => dec_d,
        unidades => uni_d
    );

    -- Instancia 3, 4, 5: Decodificadores a 7 Segmentos
    U_DEC_UNI: bcd_7seg port map ( bcd => uni_d,  hex => HEX0 );
    U_DEC_DEC: bcd_7seg port map ( bcd => dec_d,  hex => HEX1 );
    U_DEC_CEN: bcd_7seg port map ( bcd => cent_d, hex => HEX2 );

    -- Mapeo de ángulo (0-180) a vector de 8 bits (0-255)
    input_8bits <= std_logic_vector(to_unsigned((angulo_val * 255) / 180, 8));

    -- Instancia 6: Generador PWM
    U_PWM: PWM_motor port map (
        clk     => CLOCK_50,
        entrada => input_8bits,
        pwm_out => pwm_signal
    );

    GPIO_0(0) <= pwm_signal;

end architecture Structural;
