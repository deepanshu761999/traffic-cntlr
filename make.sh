iverilog -o tc  ./src/hw_mod.v ./src/fw_mod.v ./src/timer.v ./src/main.v
vvp tc
gtkwave test.vcd
