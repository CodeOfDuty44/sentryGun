
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity targetfollow_servo is
    Generic( duty_min : integer := 100000; -- # of clk cycles need for min(1ms) duty (obtainede from 1ms/ 10^-8)
             duty_max : integer := 200000; -- # of clk cycles needed for max(2ms) duty
             count_max : integer := 2000000; -- # of clk cycles for a PWM (obtained by the division 20ms/ 10^-8)
             duty_delta : integer := 2000 -- decides the speed, the bigger it is, the faster the servo is, needs to be divider of 100000
             );
    Port ( clk : in STD_LOGIC;
           lock_switch : in STD_LOGIC;
           left_cm1 : in unsigned (3 downto 0);
           left_cm0 : in unsigned (3 downto 0);
           right_cm1 : in unsigned (3 downto 0);
           right_cm0 : in unsigned (3 downto 0);
           goUp: in std_logic;
           goDown:in std_logic;
           pwm : out STD_LOGIC);
end targetfollow_servo;

architecture targetfollow_servo_arch of targetfollow_servo is

signal duty, new_duty: integer range duty_min to duty_max;
signal count: integer range 0 to count_max;
signal locked: std_logic;
signal target_cm1, target_cm0 : unsigned(3 downto 0);
signal duty_updated: std_logic; 

begin 
    process(clk)
    begin
        if rising_edge(clk) then
        
            if duty_updated = '1' then
                if count < duty then
                    pwm <= '1';
                else
                    pwm <= '0';
                end if;
                if count < count_max then
                    count <= count + 1;
                else
                    count <= 0;
                    duty_updated <= '0';
                    duty <= new_duty;
                end if;         
            end if;  
            if lock_switch = '0' or (locked = '0' and lock_switch = '1') then
                if goUp = '1' and goDown = '0' then    
                   new_duty <= duty + duty_delta;
                    duty_updated <= '1';
                elsif goUp = '0' and goDown = '1' then               
                   new_duty <= duty - duty_delta;
                    duty_updated <= '1';
                end if;
            elsif lock_switch = '1' then
                if left_cm1 = right_cm1 and abs(to_integer(right_cm0) - to_integer(left_cm0))  < 8 then
                    locked <= '1';
                    target_cm1 <= left_cm1;
                    target_cm0 <= left_cm0;
                end if;
                if locked = '1' and duty_updated = '0' then
                    if left_cm1 /= target_cm1 then                  
                       new_duty <= duty +  duty_delta;
                        duty_updated <= '1';
                    elsif right_cm1 /= target_cm1 then
                        new_duty <= duty - duty_delta;
                        duty_updated <= '1';
                    end if;
                end if;                              
            end if;       
        end if;
    end process;


end targetfollow_servo_arch;
