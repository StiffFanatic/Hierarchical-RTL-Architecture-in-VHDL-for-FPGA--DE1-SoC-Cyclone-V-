library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- FSM de 5 Estados tipo Moore para detectar la secuencia binaria '0110'
entity Detector_secuencia_FSM is
    Port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        din        : in  STD_LOGIC;
        detected   : out STD_LOGIC
    );
end entity Detector_secuencia_FSM;

architecture Moore of Detector_secuencia_FSM is
    type estado_type is (S0, S1, S2, S3, S4);
    signal estado_actual, estado_siguiente : estado_type;
begin

    -- Proceso 1: Registro de Estado Síncrono
    process(clk, reset)
    begin
        if reset = '1' then
            estado_actual <= S0;
        elsif rising_edge(clk) then
            estado_actual <= estado_siguiente;
        end if;
    end process;

    -- Proceso 2: Lógica Combinacional de Transición de Estados
    process(estado_actual, din)
    begin
        case estado_actual is
            when S0 =>
                if din = '0' then estado_siguiente <= S1;
                else estado_siguiente <= S0; end if;

            when S1 => -- Detectado '0'
                if din = '1' then estado_siguiente <= S2;
                else estado_siguiente <= S1; end if;

            when S2 => -- Detectado '01'
                if din = '1' then estado_siguiente <= S3;
                else estado_siguiente <= S1; end if;

            when S3 => -- Detectado '011'
                if din = '0' then estado_siguiente <= S4;
                else estado_siguiente <= S0; end if;

            when S4 => -- Detectado '0110' (Secuencia Completa)
                if din = '1' then estado_siguiente <= S2;
                else estado_siguiente <= S1; end if;

            when others =>
                estado_siguiente <= S0;
        end case;
    end process;

    -- Salida de Moore (Depende solo del estado actual)
    detected <= '1' when estado_actual = S4 else '0';

end architecture Moore;
