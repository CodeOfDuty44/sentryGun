library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is

    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           countput : out STD_LOGIC_VECTOR (1 downto 0));
end counter;

architecture counter_arch of counter is

    signal tmp: std_logic_vector(1 downto 0);
    begin
        process(clk, reset)
        begin
            if reset = '1' then
            tmp <= "00";
                elsif rising_edge(clk) then
                tmp <= tmp + 1;
            end if;
        end process;
        countput <= tmp;
end counter_arch;