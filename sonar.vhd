library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity sonar is
    Port ( clk         : in  STD_LOGIC;
           trig     : out STD_LOGIC;
           echo        : in  STD_LOGIC;
           out1: out  unsigned(3 downto 0);
           out0: out  unsigned(3 downto 0)
          );
end sonar;
 
architecture Behavioral of sonar is
    signal count             : unsigned(16 downto 0) := (others => '0');
    signal cm        : unsigned(15 downto 0) := (others => '0');
    signal cm0 : unsigned(3 downto 0)  := (others => '0');
    signal cm1  : unsigned(3 downto 0)  := (others => '0');
    signal digit             : unsigned(3 downto 0)  := (others => '0');
    signal echo_last_Value    : std_logic := '0';
    signal echo_synch      : std_logic := '0';
    signal echo_not_synch  : std_logic := '0';
    signal waitforCalc           : std_logic := '0'; 
    signal segment_count     : unsigned(15 downto 0) := (others => '0');
begin
 
 
 
process(CLK)
    begin
        if rising_edge(CLK) then
            if waitforCalc = '0' then
                if count = 10000 then 
                   trig     <= '0';
                   waitForCalc     <= '1';
                   count       <= (others => '0');
                else
                   trig <= '1';
                   count <= count+1;
                end if;
                elsif echo_last_value = '0' and echo_synch = '1' then
                    count       <= (others => '0');
                    cm  <= (others => '0');
                    cm0 <= (others => '0');
                    cm1  <= (others => '0');
            elsif echo_last_value = '1' and echo_synch = '0' then
                out0 <= cm0; 
                out1 <= cm1; 
            elsif count = 5799 then 
                if cm0 = 9 then
                   cm0 <= (others => '0');
                    cm1 <= cm1 + 1;
                else
                    cm0 <= cm0 + 1;
                end if;
                cm <= cm + 1;
                count <= (others => '0');
                if cm = 3400 then
                    waitforCalc <= '0';
                end if;
            else
                count <= count + 1;                
            end if;
 
            echo_last_value   <= echo_synch;
            echo_synch    <= echo_not_synch;
            echo_not_synch <= ECHO;
        end if;
    
    end process;
end Behavioral;