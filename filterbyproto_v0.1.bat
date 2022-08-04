echo off
REM Filter By Protocol v0.1

mode 88,40
color E2
path=c:\Program Files\wireshark\

echo.
echo ***********************************************************************
echo ************************* Filter By Protocol **************************
echo *****************************    v.0.1    *****************************
echo *************************** by David Morgan (aka: "r0m")***************
echo ***********************************************************************
echo.
set /p protofilter=Enter the protocol to filter:
echo.
echo.
set /p protofilterfilename=Enter new (filtered) pcap filename:
tshark -r %1 -R %protofilter% -2 -w %protofilterfilename%
echo.
echo.
echo Tshark Port Filter COMPLETE
echo.
echo.
pause