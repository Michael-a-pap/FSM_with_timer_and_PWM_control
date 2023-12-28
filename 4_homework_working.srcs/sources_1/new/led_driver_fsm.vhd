----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2022 06:00:53 PM
-- Design Name: 
-- Module Name: led_driver_fsm - Behavioral
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

entity led_driver_fsm is
    Port (
        clk              : in std_logic;
        led1, led2, led3 :out std_logic;
        dir              : in std_logic; 
        spd1,spd2        : in std_logic;
        rst              : in std_logic;
        alarm            : in std_logic   
    );
end led_driver_fsm;


architecture Behavioral of led_driver_fsm is
    -- Enumarated type declaration and state signal declaration for the FSM 
    type t_state is (state1, state2, state3, state4, state5, state6, state7);
    signal state : t_state;
    signal last_state :t_state;
    -- General usage signals 
    signal timer, timer_alarm : std_logic_vector (32 downto 0):="000000000000000000000000000000100";
    signal time_out, alarm_out : std_logic;
    signal timer_rst,timer_alarm_rst, pwm_rst : std_logic:='0';
    signal led_b :std_logic:='0';
    signal pwm_value,times1 : std_logic_vector (7 downto 0);
    signal pwm_gout : std_logic;
begin
    process(clk)
        variable times       : integer :=0;
        variable flag        : boolean :=FALSE;
        variable st4_flag    : boolean :=FALSE;
        variable alarm_flag  : boolean :=FALSE;
        variable pstate      : character;
    begin
        if (rising_edge (clk)) then
            if(time_out='1') then
                times:=1;
                times1 <= std_logic_vector(to_unsigned(times, times1'length));
                timer_rst<='1';
            else
                timer_rst<='0';    
            end if;
            
            
            
            
            led1  <='0';
            led2  <='0';
            led3  <='0'; 
            
            if (rst='1' and  flag=FALSE) then
                timer <= std_logic_vector(to_unsigned(4000, timer'length));
                state <= state4;
                times:=0;
                timer_rst<='1';
                
            elsif (rst='0' and flag=TRUE) then
                timer_rst<='1';
                flag:=FALSE;
            elsif(rst='0')  then 
                if (spd1='0' and spd2='0') then 
                    timer <= std_logic_vector(to_unsigned(1000, timer'length)); -- Here it will be 1second
                elsif (spd1='0' and spd2='1') then 
                    timer <= std_logic_vector(to_unsigned(3000, timer'length)); --Here it will be 3seconds
                elsif (spd1='1' and spd2='0') then 
                    timer <= std_logic_vector(to_unsigned(5000, timer'length)); -- Here it will be 5seconds
--                else -- Here is the default speed of 1 second
--                    timer <= std_logic_vector(to_unsigned(1000, timer'length)); -- Here it will be 1second            
                end if;
            end if;
            
            case state is 
                when state1 =>
                    led1  <='1';
                    if(time_out='1' and rst='0') then 
                        if (dir='1') then --Normal loop                        
                            state <= state6;
                        else              --Backwards loop
                            state <= state7;
                        end if;
                    end if;                    
                when state2 =>
                    led2  <='1';
                    if(time_out='1') then                        
                        if (dir='1') then --Normal loop                        
                            state <= state3;
                        else              --Backwards loop
                            state <= state6;
                        end if;
                    end if;              
                when state3 =>
                    led3  <='1';
                    if(time_out='1') then                        
                        if (dir='1') then --Normal loop                        
                            state <= state7;
                        else              --Backwards loop
                            state <= state2;
                        end if;
                    end if;    
                when state4 =>
                    led1  <='1';
                    led2  <='1';
                    led3  <='1';
                    flag:=TRUE;
                    if (times=1 and rst='1') then 
                        state<=state1;
                        
                    end if;
                when state5 =>
                when state6 =>
                    led1  <='1';
                    led2  <='1';
                    if(time_out='1') then
                        if (dir='1') then --Normal loop                        
                            state <= state2;
                        else              --Backwards loop
                            state <= state1;
                        end if;
                    end if;    
                when state7 =>
                    pwm_value <= std_logic_vector(to_unsigned(30, pwm_value'length));
                    led1  <=pwm_gout;
                    led3  <=pwm_gout;
                    if(time_out='1') then                        
                        if (dir='1') then --Normal loop                        
                            state <= state1;
                        else              --Backwards loop
                            state <= state3;
                        end if;
                    end if;    
            end case;   
                
        end if;
    end process;



--MODULES CONNECTIONS
universal_timer_connections: entity work.univ_timer 
port map(
    clk=>clk,
    rst=>timer_rst,
    timer_ms=> timer,
    timer_out=> time_out
);
universal_alarm_timer_connections: entity work.univ_timer 
port map(
    clk=>clk,
    rst=>timer_alarm_rst,
    timer_ms=> timer_alarm,
    timer_out=> alarm_out
);

PWM_generation_connections: entity work.pwm_gen 
port map(
    clk=>clk,
    rst=>pwm_rst,
    pwm_in=>pwm_value,
    pwm=>pwm_gout    
);

end Behavioral;
--architecture Behavioral of led_driver_fsm is
--signal time_out : std_logic;
--signal timer_rst : std_logic;
--signal flag : std_logic ;
--signal timer : std_logic_vector (32 downto 0):="000000000000000000000001111101000";
--begin
--    process(clk)

--    begin
--        if (rising_edge (clk)) then
--            if(time_out='1') then
--                timer_rst<='1';
--                flag<=not flag;
--                led1<=flag ;  
--            else
--                timer_rst<='0';  
--            end if;
--            timer <= std_logic_vector(to_unsigned(1000, timer'length));
--            led2<=dir;
--            if (dir='1') then 
--                flag<='1';
--             timer_rst<='1';
             
--            end if;
--        end if;
--    end process;



----MODULES CONNECTIONS
--universal_timer_connections: entity work.univ_timer 
--port map(
--    clk=>clk,
--    rst=>timer_rst,
--    timer_ms=> timer,
--    timer_out=> time_out
--);

--end Behavioral;