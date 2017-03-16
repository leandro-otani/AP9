transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/control_unit_v.v}
vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/alu_v.v}
vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/cpu_v.v}
vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/clock_divider.v}
vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/clock_gen.v}
vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/kit_v.v}
vcom -93 -work work {/home/kite/workspace/AP9/ambientTest/RAM.vhd}

vlog -vlog01compat -work work +incdir+/home/kite/workspace/AP9/ambientTest {/home/kite/workspace/AP9/ambientTest/ramWithClock_tb.v}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  ramWithClock_tb

add wave *
view structure
view signals
run -all
