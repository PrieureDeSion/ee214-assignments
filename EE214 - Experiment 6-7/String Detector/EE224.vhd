library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package EE224_Components is
   component INVERTER is
	port (a: in std_logic; b : out std_logic);
   end component;
   component andi2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
  component andi5 is
  port (a1, a2, a3, a4, a5: in std_logic; c : out std_logic);
   end component;
  component andi3 is
  port (a1, a2, a3: in std_logic; c : out std_logic);
   end component;
   component Nandi2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component ori2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component Nori2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component positive_d_latch is
	port (d, clk: in std_logic; q : out std_logic);
   end component;
   component negative_d_latch is
	port (d, clk: in std_logic; q : out std_logic);
   end component;
   component dffi is
	port (d, clk, r: in std_logic; q : out std_logic);
   end component;
      component dffi1 is
  port (d, clk, r: in std_logic; q : out std_logic);
   end component;

end EE224_Components;

library ieee;
use ieee.std_logic_1164.all;
entity INVERTER is
  port (a: in std_ulogic;
         b: out std_ulogic);
end entity INVERTER;
architecture Behave of INVERTER is
begin
  b <= not a;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity andi2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity andi2;
architecture Behave of andi2 is
begin
  c <= a and b;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;
entity andi5 is
  port (a1, a2, a3, a4, a5: in std_ulogic;
         c: out std_ulogic);
end entity andi5;
architecture Behave of andi5 is
  signal p2, p3, p4: std_ulogic;
begin
  AA1: andi2 port map (a1, a2, p2);
  AA2: andi2 port map (a3, p2, p3);
  AA3: andi2 port map (a4, p3, p4);
  AA4: andi2 port map (a5, p4, c);
end Behave;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;
entity andi3 is
  port (a1, a2, a3: in std_ulogic;
         c: out std_ulogic);
end entity andi3;
architecture Behave of andi3 is
  signal p2: std_ulogic;
begin
  AA1: andi2 port map (a1, a2, p2);
  AA2: andi2 port map (a3, p2, c);
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity Nandi2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity Nandi2;
architecture Behave of Nandi2 is
begin
  c <= not(a and b);
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity ori2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity ori2;
architecture Behave of ori2 is
begin
  c <= a or b;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity Nori2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity Nori2;
architecture Behave of Nori2 is
begin
  c <= not (a or b);
end Behave;

library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 
entity positive_d_latch is
  port (d, clk: in std_ulogic; q: out std_ulogic);
end entity positive_d_latch;
architecture Equations of positive_d_latch is
   signal qsig: std_logic;
begin
   -- q cannot be read.
   qsig    <= (d and clk) or (qsig and (not clk));
   q <= qsig;
end Equations;

library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 
entity negative_d_latch is
  port (d, clk: in std_ulogic; q: out std_ulogic);
end entity negative_d_latch;
architecture Equations of negative_d_latch is
   signal qsig: std_logic;
begin
   qsig    <= (d and (not clk)) or (qsig and clk);
   q <= qsig;
end Equations;

library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 

entity dffi is
  port (d, clk, r: in std_ulogic; q: out std_ulogic);
end entity dffi;
architecture Struct of dffi is
   signal U, o: std_logic;
begin
  master: negative_d_latch
            port map (d => d, clk => clk, q => U);
  slave: positive_d_latch
            port map (d => U, clk => clk, q => o);
  q <= o and (not r);
end Struct;


library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 

entity dffi1 is
  port (d, clk, r: in std_ulogic; q: out std_ulogic);
end entity dffi1;
architecture Struct of dffi1 is
   signal U, o: std_logic;
begin
  master: negative_d_latch
            port map (d => d, clk => clk, q => U);
  slave: positive_d_latch
            port map (d => U, clk => clk, q => o);
  q <= o or r;
end Struct;