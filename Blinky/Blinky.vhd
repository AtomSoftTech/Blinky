----------------------------------------------------------------------------------
-- Company: 		 AtomSoftTech
-- Engineer: 		 Jason Lopez
-- 
-- Create Date:    21:13:39 08/23/2011 
-- Design Name:    Blinky
-- Tool versions:  ISE Webpack 13.2
-- Description: 	 Simply Blink a LED
--
-- Dependencies:   Blinky.ucf
--
-- Revision 0.01 - File Created
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Blinky is
    Port ( clk : in  STD_LOGIC; -- Our Input Clock
			  rst : in  STD_LOGIC; -- Our Input Reset
           DB : out  STD_LOGIC_VECTOR (15 downto 0) -- Our Output LEDs
			 );
end Blinky;

architecture Behavioral of Blinky is

signal count : STD_LOGIC_VECTOR (24 downto 0); -- Will be like our counting variable
signal state : STD_LOGIC_VECTOR (15 downto 0); -- Will hold the current state of the LED (0 or 1)

begin
process (clk,rst,state) is begin  -- Process these signals
   if rst = '0' then					 -- If Reset is LOW then RESET our variable, state and LEDs to 0
		count <= (others => '0');	 -- Place 0's in count
      DB <= (others => '0');		 -- Place 0's in the output DB0 to DB15 (16bits)
		state <= (others => '0');	 -- Place 0's in LED state 
   elsif (rising_edge(clk)) then	 -- Wait for the clock to be high (rising edge)
		count <= count + 1;			 -- Add 1 to our count variable
      if(count = 16000000) then	 -- If count is half our crystal rate which is (32Mhz) which should equal 1/2 second (500ms) blink
			state <= not state;		 -- Flip the state variable between all 0's to all 1's
			count <= (others => '0');-- Reset count
		end if;				
   end if;
	
	DB <= state;						 -- Output the current state without regard to edge of clock
end process;

end Behavioral;

