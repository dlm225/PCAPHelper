@echo off
REM Merge PCAP Here v0.1

mode 88,40
color E2
path=c:\Program Files\wireshark\

echo.
echo ***********************************************************************
echo *************************** MERGE PCAP HERE ***************************
echo *****************************    v.0.1    *****************************
echo *************************** by David Morgan (aka: "r0m")***************
echo ***********************************************************************
echo.

REM USAGE: Drag and drop up to 9 pcap files directly onto the icon for this file.
REM The new merged file will be written to whichever dir the original pcaps came from.

set /p mergedfilename=Input desired merged pcap filename:
echo mergecap %1 %2 %3 %4 %5 %6 %7 %8 %9 -w %mergedfilename%
mergecap %1 %2 %3 %4 %5 %6 %7 %8 %9 -w %mergedfilename%
echo working....