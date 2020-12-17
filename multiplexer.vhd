library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexer is

Port ( d0 : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : in STD_LOGIC_VECTOR (3 downto 0);
           d2 : in STD_LOGIC_VECTOR (3 downto 0);
            d3 : in STD_LOGIC_VECTOR (3 downto 0);
            s: in STD_LOGIC_VECTOR(1 downto 0);
            dOut : out STD_LOGIC_VECTOR(3 downto 0));
end multiplexer;

architecture multiplexer_arch of multiplexer is
begin
    with s select dOut <=
    d0 when "00",
    d1 when "01",
    d2 when "10",
    d3 when others;
end multiplexer_arch;