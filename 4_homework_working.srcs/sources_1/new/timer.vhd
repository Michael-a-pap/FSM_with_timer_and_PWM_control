----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Michael Pap.
-- 
-- Create Date: 11/01/2022 02:19:19 PM
-- Design Name: Universal Timer
-- Module Name: timer - Behavioral
-- Project Name: General use timer
-- Target Devices: Any
-- Tool Versions: 
-- Description: Is is a simple millisecond timer
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Optimization of the code is not checked!
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use ieee.float_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity univ_timer is
  Port (
    clk : in std_logic;
    --clk_frequency : in std_logic_vector
    rst : in std_logic; --reset input, the timer after it has counted the time it will go high then it was to be resetted in order to count again  
    timer_out : out std_logic :='0';    -- the timer output
    timer_ms : in std_logic_vector (32 downto 0) -- time in ms 32bit so from 0ms to 49.71 days
   );
end univ_timer;


architecture Behavioral of univ_timer is -- this is a universal timer 

begin
process (clk) --timer_ms) is
variable clk_counter   : natural :=0;
variable clk_frequency : natural :=100; --50MHz from the simulation
variable timer         : natural :=0;
begin
timer:= to_integer(unsigned(timer_ms));
    if (rising_edge (clk)) then  
            --report "clk" & integer'image(clk_counter);
        if((clk_counter)>=(clk_frequency*1000*timer-1)) then
            timer_out <= '1';
        else
            clk_counter:= clk_counter+1;
            timer_out<='0';
        end if; 
    end if;           
 if (rst='1') then
    clk_counter := 0;
    timer_out<='0';
end if;
end process;


end Behavioral;
