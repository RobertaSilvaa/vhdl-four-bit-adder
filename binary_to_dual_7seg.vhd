library ieee;
use ieee.std_logic_1164.all;

entity binary_to_dual_7seg is
    port (
        binary_input : in  std_logic_vector(3 downto 0);
        segments     : out std_logic_vector(13 downto 0)
    );
end entity binary_to_dual_7seg;

architecture behavioral of binary_to_dual_7seg is
begin
    process (binary_input)
    begin
        case binary_input is
            when "0000" => segments <= "1000000" & "1000000"; -- 00
            when "0001" => segments <= "1000000" & "1111001"; -- 01
            when "0010" => segments <= "1000000" & "0100100"; -- 02
            when "0011" => segments <= "1000000" & "0110000"; -- 03
            when "0100" => segments <= "1000000" & "0011001"; -- 04
            when "0101" => segments <= "1000000" & "0010010"; -- 05
            when "0110" => segments <= "1000000" & "0000010"; -- 06
            when "0111" => segments <= "1000000" & "1111000"; -- 07
            when "1000" => segments <= "1000000" & "0000000"; -- 08
            when "1001" => segments <= "1000000" & "0010000"; -- 09
            when "1010" => segments <= "1111001" & "1000000"; -- 10
            when "1011" => segments <= "1111001" & "1111001"; -- 11
            when "1100" => segments <= "1111001" & "0100100"; -- 12
            when "1101" => segments <= "1111001" & "0110000"; -- 13
            when "1110" => segments <= "1111001" & "0011001"; -- 14
            when "1111" => segments <= "1111001" & "0010010"; -- 15
            when others => segments <= (others => '1');
        end case;
    end process;
end architecture behavioral;
