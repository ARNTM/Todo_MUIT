set ROPTS=-np all --parallel-authenticate localonly --machines-file nodes
set COPTS=
set FEKO_SCRIPT_FILE=C:/Users/Andres/Desktop/VARIACION/param_sweep\BiQuad_pol_circular_original_01.bof

cadfeko_batch "BiQuad_pol_circular_original_01" %COPTS%
runfeko "BiQuad_pol_circular_original_01" %ROPTS%

cadfeko_batch "BiQuad_pol_circular_original_02" %COPTS%
runfeko "BiQuad_pol_circular_original_02" %ROPTS%

cadfeko_batch "BiQuad_pol_circular_original_03" %COPTS%
runfeko "BiQuad_pol_circular_original_03" %ROPTS%

cadfeko_batch "BiQuad_pol_circular_original_04" %COPTS%
runfeko "BiQuad_pol_circular_original_04" %ROPTS%

cadfeko_batch "BiQuad_pol_circular_original_05" %COPTS%
runfeko "BiQuad_pol_circular_original_05" %ROPTS%
@ECHO OFF

echo           DONE: Parameter Sweep Solve
echo ************************************************
echo * Launch POSTFEKO and merge the results.       *
echo ************************************************
choice /N /M "Do you want to run POSTFEKO now (y/n):"

if not errorlevel 2 (
    if exist "%FEKO_SCRIPT_FILE%" (
        start postfeko "%FEKO_SCRIPT_FILE%" --run-script "%FEKO_HOME%\shared\lua\ParameterSweep\combine_parameter_sweep_results.lua"
    ) else (
        start postfeko --run-script "%FEKO_HOME%\shared\lua\ParameterSweep\combine_parameter_sweep_results.lua"
    )
)
exit
