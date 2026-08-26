library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Componentes is

    -- 1. Contador 0 a 180 grados con detección de flancos
    component contador is
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            PA       : in  STD_LOGIC; -- Botón Aumento
            PD       : in  STD_LOGIC; -- Botón Disminución
            angulo   : out INTEGER range 0 to 180
        );
    end component;

    -- 2. Generador PWM para Servomotor (50 Hz)
    component PWM_motor is
        Port (
            clk      : in  STD_LOGIC;
            entrada  : in  STD_LOGIC_VECTOR(7 downto 0);
            pwm_out  : out STD_LOGIC
        );
    end component;

    -- 3. Separador Binario (8 bits) a BCD
    component separador_8_bits is
        Port (
            valor    : in  INTEGER range 0 to 255;
            centenas : out INTEGER range 0 to 9;
            decenas  : out INTEGER range 0 to 9;
            unidades : out INTEGER range 0 to 9
        );
    end component;

    -- 4. Decodificador BCD a 7 Segmentos (Activo Bajo)
    component bcd_7seg is
        Port (
            bcd : in  INTEGER range 0 to 9;
            hex : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

end package Componentes;
