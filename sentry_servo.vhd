
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sentry_servo is
    Generic( duty_min : integer := 100000; -- # of clk cycles need for min(1ms) duty (obtainede from 1ms/ 10^-8)
             duty_max : integer := 200000; -- # of clk cycles needed for max(2ms) duty
             count_max : integer := 2000000; -- # of clk cycles for a PWM (obtained by the division 20ms/ 10^-8)
             duty_delta : integer := 1000 -- decides the speed, the bigger it is, the faster the servo is, needs to be divider of 100000
             );
    Port ( clk : in STD_LOGIC;
           pwm : out STD_LOGIC);
end sentry_servo;

architecture sentry_servo_arch of sentry_servo is
signal count : integer range 0 to count_max := 0;
signal duty: integer range duty_min to duty_max := duty_min;
begin
process(clk)
    variable direction_up : boolean := true; --whether we increment the duty
    begin
        if rising_edge(clk) then
            if count < duty then--first send the pwm
                pwm <= '1';
            else
                pwm <= '0';
            end if;
            
            if count = count_max then --now a PWM is completely sent, edit the duty for the next PWM 
                count <= 0;
                if duty = duty_min then
                    direction_up := true;
                elsif duty = duty_max then
                    direction_up := false;
                end if;
                if direction_up then
                    duty <= duty + duty_delta;
                else
                    duty <= duty - duty_delta;
                end if;
            end if;
            count <= count + 1;               
        end if;
    end process;


end sentry_servo_arch;
