# Create design library
vlib work
# Create and open project
project new . compile_project
project open compile_project
# Add source files to project
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/der_v.sv"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/fixed_pkg.vhd"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/Fixed2Float.v"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/FixedShiftCalc.v"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/FixedShifter.v"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/Float2Fixed.v"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/NormalCases.v"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/Overflow.v"
project addfile "C:/Users/garimar/Documents/QDesign/tanh_der_vhdl/ROM_der.vhd"
# Calculate compilation order
project calculateorder
set compcmd [project compileall -n]
# Close project
project close
# Compile all files and report error
if [catch {eval $compcmd}] {
    exit -code 1
}
