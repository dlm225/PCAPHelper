echo off
REM Filter By IP v0.1

mode 88,40
color E2
path=c:\Program Files\wireshark\

echo.
echo ***********************************************************************
echo **************************** Filter By IP *****************************
echo *****************************    v.0.1    *****************************
echo *************************** by David Morgan (aka: "r0m")***************
echo ***********************************************************************
echo.

echo.
echo *********************** Filter by IP Address ****************************
echo ***************** Will also work with CIDR addresses ********************
echo.
set /p tsharkfilterip=Enter the IP address:
echo.
tshark -r %1 -R eth.addr==%tsharkfilterip% -2 -w .\%tsharkfilterip%.pcap
echo.
pause