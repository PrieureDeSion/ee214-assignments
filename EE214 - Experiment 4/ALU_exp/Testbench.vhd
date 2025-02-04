library std;
use std.textio.all;

library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;
architecture Behave of Testbench is

  constant number_of_inputs  : integer := 18;  -- # input bits to your design. 
  constant number_of_outputs : integer := 8;  -- # output bits from your design.

  component DUT is
   port(input_vector: in std_logic_vector(number_of_inputs-1  downto 0);    
       	output_vector: out std_logic_vector(number_of_outputs-1 downto 0));
  end component;

  signal input_vector  : bit_vector(number_of_inputs-1 downto 0);
  signal output_vector : bit_vector(number_of_outputs-1 downto 0);
  signal std_output_vector : std_logic_vector(number_of_outputs-1 downto 0);


  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

begin
  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "~/tracefiles/alu_TRACEFILE.txt";
    FILE OUTFILE: text  open write_mode is "~/tracefiles/alu_OUTPUTS.txt";

    variable input_vector_var: bit_vector (number_of_inputs-1 downto 0);
    variable output_vector_var: bit_vector (number_of_outputs-1 downto 0);
    variable output_mask_var: bit_vector (number_of_outputs-1 downto 0);
    variable output_comp_var: bit_vector (number_of_outputs-1 downto 0);
    constant ZZZZ : bit_vector(number_of_outputs-1 downto 0) := (others => '0');

    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;

    
  begin
    while not endfile(INFILE) loop

          LINE_COUNT := LINE_COUNT + 1;

	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, input_vector_var);
          read (INPUT_LINE, output_vector_var);
          read (INPUT_LINE, output_mask_var);
	
          input_vector <= input_vector_var;

	  wait for 1 ns;

          output_comp_var := (output_mask_var and (output_vector xor output_vector_var));
	  if (output_comp_var  /= ZZZZ) then
             write(OUTPUT_LINE,to_string("ERROR: line "));
             write(OUTPUT_LINE, LINE_COUNT);
             writeline(OUTFILE, OUTPUT_LINE);
             err_flag := true;
          end if;

          write(OUTPUT_LINE, input_vector);
          write(OUTPUT_LINE, to_string(" "));
          write(OUTPUT_LINE, output_vector);
          writeline(OUTFILE, OUTPUT_LINE);

	  wait for 4 ns;
    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

	output_vector <= to_bitvector(std_output_vector);
  dut_instance: DUT 
     	port map(input_vector => to_stdlogicvector(input_vector), output_vector =>std_output_vector );

end Behave;
