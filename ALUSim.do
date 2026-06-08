# Project: 8-Bit ALU
# Author: John O'Connor
# Sources: None

# Do file for running all independent testbenches


# Run module testbenches
vsim -quiet A_pass_tb -do "run -all"
vsim -quiet B_pass_tb -do "run -all"
vsim -quiet And_tb -do "run -all"
vsim -quiet Or_tb -do "run -all"
vsim -quiet Xor_tb -do "run -all"
vsim -quiet AdditionTestbench -do "run -all"
vsim -quiet SubtractionTestbench -do "run -all"
# vsim -quiet Mult_8bitTestbench -do "run -all"

# ALU testbench
vsim ALU_tb
add wave *
run -all