
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TopModule is
    Port ( clk : in STD_LOGIC;
           left_echo : in STD_LOGIC;
           right_echo : in STD_LOGIC;
           goDown : in STD_LOGIC;
           goUp : in STD_LOGIC;
           fire_button : in STD_LOGIC;
           lock_switch : in STD_LOGIC;
           left_trig : out STD_LOGIC;
           right_trig : out STD_LOGIC;
           pwm : out STD_LOGIC;
           fire : out STD_LOGIC;
           mode : in STD_LOGIC;
           seg: out std_logic_vector(6 downto 0);
           an: out std_logic_vector( 3 downto 0));
end TopModule;

architecture TopModule_arch of TopModule is
component sonar Port ( clk         : in  STD_LOGIC;
           trig     : out STD_LOGIC;
           echo        : in  STD_LOGIC;
           out1: out  unsigned(3 downto 0);
           out0: out  unsigned(3 downto 0)
          );
end component;

component servoController Port ( mode : in STD_LOGIC;
           clk: in std_logic;
           left_cm1 : in unsigned (3 downto 0);
           left_cm0 : in unsigned (3 downto 0);
           right_cm1 : in unsigned (3 downto 0);
           right_cm0 : in unsigned (3 downto 0);
           lock_switch : in STD_LOGIC;
           goUp: in std_logic;
           goDown: in std_logic;
           pwm : out STD_LOGIC);
end component;

component fireController Port ( cm1 : in unsigned (3 downto 0);
           mode : in STD_LOGIC;
           fire_button: in std_logic;
           fire : out STD_LOGIC);
end component;

component sevensegment Port ( td15,td14,td13,td12,td11,td10,td9,td8,td7,td6,td5,td4,td3,td2,td1,td0: in std_logic;
       clk : in STD_LOGIC;
       asegment,bsegment,csegment,dsegment,esegment,fsegment,gsegment: out std_logic;
       anode3, anode2, anode1, anode0: out std_logic);
end component;


signal left_cm1, left_cm0, right_cm1, right_cm0 : unsigned (3 downto 0);
begin
    left_sonar: sonar port map( clk => clk, trig => left_trig, echo => left_echo, out1 => left_cm1, out0 => left_cm0);
    right_sonar: sonar port map(clk => clk, trig => right_trig, echo => right_echo, out1 => right_cm1, out0 => right_cm0);
    fireCont: fireController port map( mode => mode, fire_Button => fire_button, fire => fire, cm1 => left_cm1);
    servoCont: servoController port map( clk => clk, left_cm1 => left_cm1, left_cm0 => left_cm0, right_cm1 => right_cm1,
                                         right_cm0 => right_cm0, lock_switch => lock_switch, goUp => goUp, goDown => goDown, pwm => pwm, mode => mode);
    se7en: sevensegment port map(td15 => right_cm1(3),td14 => right_cm1(2), td13 => right_cm1(1), td12 => right_cm1(0), td11 => right_cm0(3), td10 => right_cm0(2), td9 => right_cm0(1),
                                 td8 => right_cm0(0), td7 => left_cm1(3), td6 => left_cm1(2), td5 => left_cm1(1), td4 => left_cm1(0),
                                 td3 => left_cm0(3), td2 => left_cm0(2), td1 => left_cm0(1), td0 => left_cm0(0), clk => clk,
                                 asegment => seg(0), bsegment => seg(1), csegment => seg(2), dsegment => seg(3),esegment => seg(4), fsegment => seg(5),
                                 gsegment => seg(6), anode0 =>an(0) ,anode1 => an(1), anode2 =>an(2) , anode3 => an(3) );

end TopModule_arch;
