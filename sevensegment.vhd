library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevensegment is

Port ( td15,td14,td13,td12,td11,td10,td9,td8,td7,td6,td5,td4,td3,td2,td1,td0: in std_logic;
       clk : in STD_LOGIC;
       asegment,bsegment,csegment,dsegment,esegment,fsegment,gsegment: out std_logic;
       anode3, anode2, anode1, anode0: out std_logic);
end sevensegment;

architecture sevensegment_arch of sevensegment is

component segmentdecoder 
Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
       segconfig : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component decoder 
Port ( x : in STD_LOGIC_VECTOR (1 downto 0);
     y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component multiplexer 
Port ( d0 : in STD_LOGIC_VECTOR (3 downto 0);
      d1 : in STD_LOGIC_VECTOR (3 downto 0);
      d2 : in STD_LOGIC_VECTOR (3 downto 0);
     d3 : in STD_LOGIC_VECTOR (3 downto 0);
      s: in STD_LOGIC_VECTOR(1 downto 0);
     dOut : out STD_LOGIC_VECTOR(3 downto 0));
end component;

component counter 
Port ( clk : in STD_LOGIC;
      reset : in STD_LOGIC;
      countput : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component clockdivider
Port ( clk : in STD_LOGIC;
        reset: in STD_LOGIC;
        clkprime : out STD_LOGIC);
end component;

signal alldigits: std_logic_vector(15 downto 0);
signal outputofdivider: std_logic;
signal chosendigit: std_logic_vector(3 downto 0);
signal tcountput: std_logic_vector(1 downto 0);
signal segmentconfig: std_logic_vector(6 downto 0);
signal anodes: std_logic_vector(3 downto 0);

begin
    alldigits <= td15 & td14 & td13 & td12 & td11 & td10 & td9 & td8 & td7 & td6 & td5 & td4 & td3 & td2 & td1 & td0;
    cd: clockdivider port map( clk => clk, reset => '0', clkprime => outputofdivider);
    c: counter port map(clk => outputofdivider, reset => '0', countput => tcountput); -- lower => higher
    mux: multiplexer port map(
    d0 => alldigits(3 downto 0),
    d1 => alldigits (7 downto 4),
    d2 => alldigits (11 downto 8),
    d3 => alldigits (15 downto 12),
    s => tcountput,
    dOut => chosendigit);
    sd: segmentdecoder port map(
    digit => chosendigit,
    segconfig => segmentconfig);
    digitdecider: decoder port map(
    x => tcountput,
    y => anodes);
    --sacaklandýr
    asegment <= segmentconfig(6);
    bsegment <= segmentconfig(5);
    csegment <= segmentconfig(4);
    dsegment <= segmentconfig(3);
    esegment <= segmentconfig(2);
    fsegment <= segmentconfig(1);
    gsegment <= segmentconfig(0);
    anode3 <= anodes(3);
    anode2 <= anodes(2);
    anode1 <= anodes(1);
    anode0 <= anodes(0);
end sevensegment_arch;