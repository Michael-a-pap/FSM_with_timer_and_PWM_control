----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2022 01:34:09 PM
-- Design Name: 
-- Module Name: PWMgen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_gen is
 port (
        clk, rst : in std_logic; -- main clock and reset
        pwm_in : in std_logic_vector (7 downto 0); -- the pwm value 
        --ovf : out std_logic; --overflow bit indicator
        pwm : out std_logic -- pwm led output
      );
end pwm_gen;

architecture Behavioral_counter of pwm_gen is
signal div_clk :  std_logic :='0';

begin
process(clk) --  Here we divide the main clock i.e it is the pwm frequency
variable count   : natural :=0;
begin
    if rising_edge(clk) then
        if (count<1) then -- clock division 800000 for the board 1000 for the simulation
            count := count + 1;
        else
            div_clk  <= (not div_clk) ; 
            count := 0;   
        end if;
    end if;
   
end process;


process (div_clk ) --Here we generate the pwm and also we create the "sawtooth" counter 
variable count   : natural :=0;
variable pwm_value     : integer :=0;
    
begin
if rising_edge(div_clk) then --sawtooth counter
    if  (rst='0')  then
        if  (count<255) then
            count := count + 1; 
        elsif (count>=255) then
            count := 0;
        end if; 
        
        pwm_value := to_integer(unsigned(pwm_in));
        
        if (pwm_value>=count) then -- Pwm generation basically we compare the pwm counter with the counter
            pwm<='1';
        else
            pwm<='0';
        end if;  
    else
        pwm <='0';           
    end if;   
end if;     
end process;

end Behavioral_counter;
