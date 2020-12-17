library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clockdivider is

Port ( clk : in STD_LOGIC;
    
    clkprime : out STD_LOGIC);
end clockdivider;

architecture Behavioral of clockdivider is
begin
    process(clk,reset)
    variable tmp: std_logic_vector(15 downto 0);
    begin
        if reset = '1' then tmp := "0000000000000000";
            elsif rising_edge(clk) then
            tmp := tmp + '1';
        end if;
        clkprime <= tmp(15);
    end process;
end Behavioral;