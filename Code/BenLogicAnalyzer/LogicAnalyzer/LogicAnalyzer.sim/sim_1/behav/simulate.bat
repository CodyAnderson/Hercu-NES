@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim logicsim_behav -key {Behavioral:sim_1:Functional:logicsim} -tclbatch logicsim.tcl -view C:/Hercu-NES/Code/BenLogicAnalyzer/LogicAnalyzer/first.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
