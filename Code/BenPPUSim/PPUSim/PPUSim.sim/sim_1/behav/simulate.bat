@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim TestBench_PPU_behav -key {Behavioral:sim_1:Functional:TestBench_PPU} -tclbatch TestBench_PPU.tcl -view C:/Hercu-NES/Code/BenPPUSim/PPUSim/PPU.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
