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
component led_driver_fsm is
    Port (
        clk              : in std_logic;
        led1, led2, led3 :out std_logic;
        dir              : in std_logic;
        spd1,spd2        : in std_logic;
        rst              : in std_logic;
        alarm            : in std_logic     
--        speed : in std_logic_vector (2 downto 0)
    );
end component;
signal clk_t, led1_t, led2_t, led3_t,dir_t, spd1, spd2, rst, alarm : std_logic;
--signal pwm_in_t : std_logic_vector (7 downto 0);
--signal timer_ms_t : std_logic_vector (32 downto 0);

begin
DUT: led_driver_fsm port map (alarm=>alarm, rst=> rst, clk=>clk_t, led1=>led1_t, led2=>led2_t, led3=>led3_t, dir=> dir_t, spd1=>spd1, spd2=>spd2 );

process
variable cc : integer:=0;
begin
spd1<='0';
spd2<='0';
rst<='0';
alarm<='0';
dir_t<='0';
clk_t <= '1';
wait for 4ns;
clk_t <= '0';
wait for 4ns;
    
end process;


end Behavioral;


----timer_ms_t <=std_logic_vector(to_unsigned(3, timer_ms_t'length));
----pwm_in_t <= std_logic_vector(to_unsigned(10, pwm_in_t'length));
----rst_t<='0';
--if cc<100000  then 
--    alarm<='0';
--    rst<='0';
--elsif cc>200000 then
--    alarm<='0';
--    rst<='0';
--else 
--    alarm<='1';
--    rst<='0';
    
--end if;
--cc:=cc+1;
--dir_t<='1';
--spd1<='0';
--spd2<='0';
--clk_t <= '1';
----report "cc" & integer'image(cc);
--wait for 50ns;
--clk_t <= '0';
--wait for 50ns;