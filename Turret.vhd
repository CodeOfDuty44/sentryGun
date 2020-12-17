----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.12.2017 17:17:28
-- Design Name: 
-- Module Name: Turret - Turret_arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Turret is
    Port ( clk : in STD_LOGIC;
           goDown : in STD_LOGIC;
           goUp : in STD_LOGIC;
           left_echo : in STD_LOGIC;
           right_echo : in STD_LOGIC;
           left_trig : out STD_LOGIC;
           right_trig : out STD_LOGIC;
           pwm : out STD_LOGIC;
           fire : out STD_LOGIC);
end Turret;

architecture Turret_arch of Turret is

begin


end Turret_arch;
