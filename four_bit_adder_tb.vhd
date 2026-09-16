library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_adder_tb is
end entity four_bit_adder_tb;

architecture test of four_bit_adder_tb is
    signal c0      : std_logic := '0';
    signal a       : std_logic_vector(3 downto 0) := (others => '0');
    signal b       : std_logic_vector(3 downto 0) := (others => '0');
    signal s       : std_logic_vector(3 downto 0);
    signal c4      : std_logic;
    signal display : std_logic_vector(13 downto 0);
begin
    dut : entity work.four_bit_adder
        port map (
            c0      => c0,
            a       => a,
            b       => b,
            s       => s,
            c4      => c4,
            display => display
        );

    stimulus : process
        variable expected : integer;
    begin
        for carry_value in 0 to 1 loop
            if carry_value = 0 then
                c0 <= '0';
            else
                c0 <= '1';
            end if;

            for a_value in 0 to 15 loop
                for b_value in 0 to 15 loop
                    a <= std_logic_vector(to_unsigned(a_value, a'length));
                    b <= std_logic_vector(to_unsigned(b_value, b'length));

                    wait for 1 ns;

                    expected := a_value + b_value + carry_value;

                    assert to_integer(unsigned(s)) = (expected mod 16)
                        report "Incorrect sum for A=" & integer'image(a_value) &
                               ", B=" & integer'image(b_value) &
                               ", Cin=" & integer'image(carry_value)
                        severity error;

                    if expected >= 16 then
                        assert c4 = '1'
                            report "Missing carry-out for A=" & integer'image(a_value) &
                                   ", B=" & integer'image(b_value) &
                                   ", Cin=" & integer'image(carry_value)
                            severity error;
                    else
                        assert c4 = '0'
                            report "Unexpected carry-out for A=" & integer'image(a_value) &
                                   ", B=" & integer'image(b_value) &
                                   ", Cin=" & integer'image(carry_value)
                            severity error;
                    end if;
                end loop;
            end loop;
        end loop;

        report "All 512 adder combinations passed." severity note;
        wait;
    end process;
end architecture test;
