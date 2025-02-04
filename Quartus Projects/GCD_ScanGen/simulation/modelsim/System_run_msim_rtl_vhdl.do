transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/bitAdder.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/thepackage.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/System.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/sixteenBitSubtract.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/GCD_datapath.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/GCD_controlpath.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/dataregister.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/datapath.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/controlpath.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/comparer.vhd}
vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/EE214 - Experiment 8/Reference/GCD/unsigned_divider.vhd}

vcom -93 -work work {/home/dhruv-shah/Desktop/IIT Bombay 2015-19/Sem 4/EE214/Quartus Projects/GCD_ScanGen/../../EE214 - Experiment 8/Reference/GCD/testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L maxv -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
