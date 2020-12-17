
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity servoController is
  
    Port ( mode : in STD_LOGIC;
           clk: in std_logic;
           left_cm1 : in unsigned (3 downto 0);
           left_cm0 : in unsigned (3 downto 0);
           right_cm1 : in unsigned (3 downto 0);
           right_cm0 : in unsigned (3 downto 0);
           lock_switch : in STD_LOGIC;
           goUp: in std_logic;
           goDown: in std_logic;
           pwm : out STD_LOGIC);
end servoController;

architecture servoController_arch of servoController is

component sentry_servo Port ( clk : in STD_LOGIC;
           pwm : out STD_LOGIC);
end component;

component targetfollow_servo Port ( clk : in STD_LOGIC;
           lock_switch : in STD_LOGIC;
           left_cm1 : in unsigned (3 downto 0);
           left_cm0 : in unsigned (3 downto 0);
           right_cm1 : in unsigned (3 downto 0);
           right_cm0 : in unsigned (3 downto 0);
           goUp: in std_logic;
           goDown : in std_logic;
           pwm : out STD_LOGIC);
end component;
signal sentry_pwm, targetfollow_pwm :  std_logic;

begin
    sentryservo: sentry_servo port map( clk => clk, pwm => sentry_pwm);
    targetfollowservo: targetfollow_servo port map( clk => clk, lock_switch => lock_switch, left_cm1 => left_cm1, left_cm0 => left_cm0, 
                                                     right_cm1 => right_cm1, right_cm0 => right_cm0, pwm => targetfollow_pwm,
                                                     goUp => goUp, goDown => goDown);
   
    with mode select
        pwm <= sentry_pwm when '0',
                targetfollow_pwm when others;                                           
    
                                                    
   

end servoController_arch;
