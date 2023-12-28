----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2022 08:34:59 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port (
        button, clk : in std_logic;
        state       : out std_logic
     );
end debounce;

architecture Behavioral of debounce is
signal timer_rst, time_out : std_logic;
signal timer               : std_logic_vector (32 downto 0):="000000000000000000000000000000100"; -- 4ms time for debounce      
begin
    process (clk)
    variable times :integer:=0;
    begin
        if (rising_edge (clk)) then
            if(time_out='1') then
                    times:=1;
                    timer_rst<='1';
                else
                    timer_rst<='0';    
                end if; 
                
            if (button='1') then
                times:=0;
                timer_rst <='1';
                state <='1';
            elsif (button='0' and times=1)  then
                 state<='0';
            end if;
        end if;
    end process;
    
    
universal_timer_connections: entity work.univ_timer 
port map(
    clk=>clk,
    rst=>timer_rst,
    timer_ms=> timer,
    timer_out=> time_out
);
end Behavioral;
