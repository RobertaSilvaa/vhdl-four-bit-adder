library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        carry_in  : in  std_logic;
        a         : in  std_logic;
        b         : in  std_logic;
        sum       : out std_logic;
        carry_out : out std_logic
    );
end entity full_adder;

architecture dataflow of full_adder is
begin
    sum <= a xor b xor carry_in;
    carry_out <= (a and b) or (a and carry_in) or (b and carry_in);
end architecture dataflow;
