library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is

Port ( x : in STD_LOGIC_VECTOR (1 downto 0);
        y : out STD_LOGIC_VECTOR (3 downto 0));        
end decoder;

architecture decoder_arch of decoder is

begin

    process(x)
    begin
        if x = "00" then y <= "1110";--"0001";
        elsif x = "01" then y <= "1101";--"0010";
        elsif x = "10" then y <= "1011";--"0100";
        else y <= "0111";--"1000";
        end if;
    end process;
end decoder_arch;