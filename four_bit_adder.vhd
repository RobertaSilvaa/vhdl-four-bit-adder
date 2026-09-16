library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
    port (
        c0      : in  std_logic;
        a       : in  std_logic_vector(3 downto 0);
        b       : in  std_logic_vector(3 downto 0);
        s       : out std_logic_vector(3 downto 0);
        c4      : out std_logic;
        display : out std_logic_vector(13 downto 0)
    );
end entity four_bit_adder;

architecture structural of four_bit_adder is
    signal carry        : std_logic_vector(3 downto 1);
    signal internal_sum : std_logic_vector(3 downto 0);
begin
    fa0 : entity work.full_adder
        port map (
            carry_in  => c0,
            a         => a(0),
            b         => b(0),
            sum       => internal_sum(0),
            carry_out => carry(1)
        );

    fa1 : entity work.full_adder
        port map (
            carry_in  => carry(1),
            a         => a(1),
            b         => b(1),
            sum       => internal_sum(1),
            carry_out => carry(2)
        );

    fa2 : entity work.full_adder
        port map (
            carry_in  => carry(2),
            a         => a(2),
            b         => b(2),
            sum       => internal_sum(2),
            carry_out => carry(3)
        );

    fa3 : entity work.full_adder
        port map (
            carry_in  => carry(3),
            a         => a(3),
            b         => b(3),
            sum       => internal_sum(3),
            carry_out => c4
        );

    s <= internal_sum;

    display_decoder : entity work.binary_to_dual_7seg
        port map (
            binary_input => internal_sum,
            segments     => display
        );
end architecture structural;
