ghdl -i thepackage.vhd
ghdl -i logic_textio.vhd
ghdl -a *.vhd
ghdl -a *.vhdl
ghdl -m testbench_gcd
ghdl -a TopLevel.vhdl
