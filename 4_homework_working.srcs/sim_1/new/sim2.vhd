----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2022 04:38:08 PM
-- Design Name: 
-- Module Name: sim_test - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim_test is
--  Port ( );
end sim_test;

architecture Behavioral of sim_test is
component debounce is
   Port (
        button, clk : in std_logic;
        state       : out std_logic
     );
end component;
signal clk, button, state: std_logic;
--signal pwm_in_t : std_logic_vector (7 downto 0);
--signal timer_ms_t : std_logic_vector (32 downto 0);

begin
DUT: debounce port map (clk=>clk, button=>button, state=>state );

process
variable cc : integer:=0;
begin
--timer_ms_t <=std_logic_vector(to_unsigned(3, timer_ms_t'length));
--pwm_in_t <= std_logic_vector(to_unsigned(10, pwm_in_t'length));
--rst_t<='0';
if cc>50000 then 
    button<='0';
elsif cc>48000 then   
    button<='1';  
elsif cc>20  then 
    button<='0';
elsif cc>11 then
    button<='1';
else
    button<='0';
end if;
cc:=cc+1;

--report "cc" & integer'image(cc);
clk <= '1';
wait for 50ns;
clk <= '0';
wait for 50ns;
    
end process;


end Behavioral;
