
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fireController is
    Port ( cm1 : in unsigned (3 downto 0);
           mode : in STD_LOGIC;
           fire_button: in std_logic;
           fire : out STD_LOGIC);
end fireController;

architecture fireController_arch of fireController is
begin
    process(mode, cm1, fire_button)
    begin
        if mode = '1' then
            fire <= fire_button;
        else
            if cm1 = "0101" or cm1 = "0110" then--range
                fire <= '1';
            else
                fire <= '0';
            end if;           
        end if;
    end process;


end fireController_arch;
