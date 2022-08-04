echo off
REM Filter By MAC v0.1

mode 88,40
color E2
path=c:\Program Files\wireshark\

echo.
echo ***********************************************************************
echo **************************** Filter By MAC ****************************
echo *****************************    v.0.1    *****************************
echo *************************** by David Morgan (aka: "r0m")***************
echo ***********************************************************************
echo.

echo.
echo *********************** Filter by MAC Address ****************************
echo.
set /p tsharkfiltereth=Enter the MAC address (no delimiters): 
echo.
set tsharkfilterethfilename=%tsharkfiltereth:~0,2%-%tsharkfiltereth:~2,2%-%tsharkfiltereth:~4,2%-%tsharkfiltereth:~6,2%-%tsharkfiltereth:~8,2%-%tsharkfiltereth:~10,2%
set tsharkfiltereth=%tsharkfiltereth:~0,2%:%tsharkfiltereth:~2,2%:%tsharkfiltereth:~4,2%:%tsharkfiltereth:~6,2%:%tsharkfiltereth:~8,2%:%tsharkfiltereth:~10,2%
tshark -r %1 -R eth.addr==%tsharkfiltereth% -2 -w .\%tsharkfilterethfilename%.pcap
echo.