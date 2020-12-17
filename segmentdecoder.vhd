library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity segmentdecoder is

Port ( digit : in STD_LOGIC_VECTOR (3 downto 0);
       segconfig : out STD_LOGIC_VECTOR (6 downto 0));
end segmentdecoder;

architecture segmentdecoder_arch of segmentdecoder is
begin
    process(digit)
--variable tmp: std_logic_vector(6 downto 0);
    begin
    case digit is
        when "0000" => segconfig <= "0000001";
        when "0001" => segconfig <= "1001111";
        when "0010" => segconfig <= "0010010";
        when "0011" => segconfig <= "0000110";
        when "0100" => segconfig <= "1001100";
        when "0101" => segconfig <= "0100100";
        when "0110" => segconfig <= "0100000";
        when "0111" => segconfig <= "0001111";
        when "1000" => segconfig <= "0000000";
        when others => segconfig <= "0000100";
--        when "1010" => segconfig <= "0001000";
--        when "1011" => segconfig <= "1100000";
--        when "1100" => segconfig <= "0110001";
--        when "1101" => segconfig <= "1000010";
--        when "1110" => segconfig <= "0110000";
--        when others => segconfig <= "0111000";
    end case;
    end process;
end segmentdecoder_arch;