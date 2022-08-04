echo off
REM Filter By Port v0.1

mode 88,40
color E2
path=c:\Program Files\wireshark\

echo.
echo ***********************************************************************
echo *************************** Filter By Port ****************************
echo *****************************    v.0.1    *****************************
echo *************************** by David Morgan (aka: "r0m")***************
echo ***********************************************************************
echo.
echo.
echo ************************ Filter by Port Number ***********************
echo.
set /p portproto=Enter the protocol (udp or tcp):
echo.
echo.
set /p portfilter=Enter the port number to filter:
echo.
echo.
set /p portfilterfilename=Enter new (filtered) pcap filename:
tshark -r %1 -Y %portproto%.port==%portfilter% -w %portfilterfilename%
echo.
echo.
echo.