----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2022 07:23:18 PM
-- Design Name: 
-- Module Name: TOP - Behavioral
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

entity TOP is
    Port (
        SW7 : in std_logic;
        SW6 : in std_logic;
        SW5 : in std_logic;
        SW4 : in std_logic;
        SW3 : in std_logic;
    --    SW5 : in std_logic;
    --    SW6 : in std_logic;
    --    SW7 : in std_logic;
        GCLK : in std_logic; 
        LD7 : out std_logic;
        LD6 : out std_logic;
        LD5 : out std_logic
    --    LD3 : out std_logic;
    --    LD4 : out std_logic
       -- LD1 : out std_logic
         );
end TOP;

architecture Behavioral of TOP is
 signal clk1 : std_logic := '0';
begin
process(GCLK)
begin
    if rising_edge(GCLK) then
        clk1  <= (not clk1) ;         
    end if;
end process;

led_driver_and_fsm: entity work.led_driver_fsm 
    Port map(
        clk   => GCLK,
        led1  => LD7,
        led2  => LD6,
        led3  => LD5,
        dir   => SW7,
        spd1  => SW6,
        spd2  => SW5,
        rst   => SW4,
        alarm => SW3 
    );    

--button_debouncer_rst: entity work.debounce
--Port (
--        clk=>clk,
--        button
--        state      
--     );

end Behavioral;
