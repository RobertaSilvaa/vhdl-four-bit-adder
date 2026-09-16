# VHDL Four-Bit Adder

A 4-bit ripple-carry adder implemented in VHDL for an Intel/Altera Cyclone II FPGA.

The design is composed of four 1-bit full adders and a decoder that displays the 4-bit sum as a decimal value from `00` to `15` on two active-low 7-segment displays.

## Repository Structure

```text
vhdl-four-bit-adder/
├── .gitignore
├── README.md
├── binary_to_dual_7seg.vhd
├── four_bit_adder.qpf
├── four_bit_adder.qsf
├── four_bit_adder.vhd
├── four_bit_adder_tb.vhd
├── full_adder.vhd
└── Waveform.vwf
```

## Design

### `full_adder.vhd`

Implements a 1-bit full adder with:

- inputs `a`, `b`, and `carry_in`;
- outputs `sum` and `carry_out`.

The implemented equations are:

```text
sum       = a XOR b XOR carry_in
carry_out = (a AND b) OR (a AND carry_in) OR (b AND carry_in)
```

### `four_bit_adder.vhd`

Connects four full adders in a ripple-carry chain.

Top-level ports were intentionally kept as `a`, `b`, `c0`, `s`, `c4`, and `display` because they are already referenced by the provided Quartus pin assignments and waveform file.

### `binary_to_dual_7seg.vhd`

Converts the 4-bit sum into two active-low 7-segment digits representing decimal values from `00` through `15`.

For undefined simulation values, both displays are blanked.

## Important Display Limitation

The arithmetic result can mathematically range from `0` to `31` because two 4-bit operands and the carry-in are added.

The current project displays only the low 4-bit result `s`, so the 7-segment displays show `00` through `15`. The fifth result bit is available separately through `c4`.

This behavior was preserved because the provided project does not establish that the two displays must show the complete `0..31` arithmetic value. If the assignment requires the full decimal result on the displays, the display logic must be changed.

## Target Device

The provided Quartus project targets:

```text
Family: Cyclone II
Device: EP2C35F672C6
```

The original pin assignments were preserved in `four_bit_adder.qsf`.

## Quartus Compilation

Run the following command from the repository root if the Quartus command-line tools are installed:

```text
quartus_sh --flow compile four_bit_adder
```

A successful compilation should create the generated files under:

```text
output_files/
```

Do not consider the corrected repository verified until the actual Quartus output from the target machine has been checked.

## Quartus GUI

Open:

```text
four_bit_adder.qpf
```

Then use:

```text
Processing -> Start Compilation
```

The provided `Waveform.vwf` can be opened in Quartus for waveform-based simulation. Its top-level signal names were preserved.

## Optional GHDL Testbench

An exhaustive testbench is included in `four_bit_adder_tb.vhd`. It checks all 512 combinations of:

```text
16 values of A × 16 values of B × 2 values of carry-in
```

If GHDL is installed, run:

```text
ghdl -a --std=08 full_adder.vhd
ghdl -a --std=08 binary_to_dual_7seg.vhd
ghdl -a --std=08 four_bit_adder.vhd
ghdl -a --std=08 four_bit_adder_tb.vhd
ghdl -e --std=08 four_bit_adder_tb
ghdl -r --std=08 four_bit_adder_tb --assert-level=error
```

The expected final testbench note is:

```text
All 512 adder combinations passed.
```

## Programming the FPGA

After a successful Quartus compilation, inspect the connected JTAG hardware:

```text
quartus_pgm --list
```

If the correct board is detected and the generated SOF file exists, program it with:

```text
quartus_pgm -m JTAG -o "p;output_files/four_bit_adder.sof"
```

Board/JTAG configuration can vary, so confirm the detected hardware and target device before programming.
