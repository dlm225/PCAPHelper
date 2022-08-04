@echo off
REM PCAP Helper v0.5

mode 88,40
color E2
path=c:\Program Files\wireshark\

echo.
echo ***********************************************************************
echo ***************************** PCAP HELPER *****************************
echo *****************************    v.0.5    *****************************
echo *************************** by David Morgan (aka: "r0m")***************
echo ***********************************************************************
echo.

:PROGRAMSTART
cls
echo.
echo.
echo ***********************************************************************
echo ***************************** MAIN MENU *******************************
echo ***********************************************************************
echo.
echo.
echo Enter a choice:
echo 0. Search for X in all files in dir
echo 1. Merge two or more pcap files together
echo 2. Split single pcap apart
echo 3. Filter by IP address (Quick - dst or src)
echo 4. Filter by MAC address (Quick - dst or src)
echo 5. Filter by CIDR address
echo 6. Filter by port number
echo 7. Filter by protocol
echo 8. Filter pcap file with Tshark (by IP, CIDR, port, protocol, etc)
echo 9. EXIT 
echo.
set /p id=choice:
echo %id%

if "%id%" == "0" (GOTO SEARCH)
if "%id%" == "1" (GOTO MERGECAP)
if "%id%" == "2" (GOTO EDITCAP)
if "%id%" == "3" (GOTO TSHARKIP)
if "%id%" == "4" (GOTO TSHARKMAC)
if "%id%" == "5" (GOTO TSHARKCIDR)
if "%id%" == "6" (GOTO TSHARKPORT)
if "%id%" == "7" (GOTO TSHARKPROTO)
if "%id%" == "8" (GOTO TSHARKMENU)
if "%id%" == "9" (GOTO QUIT) else (GOTO PROGRAMSTART)


:SEARCH
cls
echo.
echo.
echo ***********************************************************************
echo *************************** SEARCH MENU *****************************
echo ***********************************************************************
echo.
echo.
echo Enter a choice:
echo 1. Search all files for specific IP address
echo 2. Search all files for specific MAC address
echo 3. Search all files for specific port
echo 4. Search all files for specific protocol
echo.
echo 8. Return to Main Menu
echo 9. EXIT 
echo.
set /p searchid=choice:
echo %searchid%
if "%searchid%" == "1" (GOTO SEARCHIP)
if "%searchid%" == "2" (GOTO SEARCHMAC)
if "%searchid%" == "3" (GOTO SEARCHPORT)
if "%searchid%" == "4" (GOTO SEARCHPROTO)
if "%searchid%" == "8" (GOTO PROGRAMSTART)
if "%searchid%" == "9" (GOTO QUIT) else (GOTO PROGRAMSTART)

:SEARCHIP
cls
echo.
echo.
echo ************ Filter by IP Address for ALL files in current dir ****************
echo ******************** Will also work with CIDR addresses ***********************
echo.
set /p tsharkfilterip=Enter the IP address:
echo.
md IP-%tsharkfilterip%
for /f %%f in ('dir /b *.pcap') do (
tshark -r %%f -R ip.addr==%tsharkfilterip% -2 -w .\IP-%tsharkfilterip%\%%f-%tsharkfilterip%.pcap
)
echo.
GOTO QUIT

:SEARCHMAC
cls
echo.
echo.
echo ************ Filter by MAC for ALL files in current dir ****************
echo.
set /p tsharkfiltereth=Enter the MAC address (hex only - no delimiters):
echo.
set tsharkfilterethfilename=%tsharkfiltereth:~0,2%-%tsharkfiltereth:~2,2%-%tsharkfiltereth:~4,2%-%tsharkfiltereth:~6,2%-%tsharkfiltereth:~8,2%-%tsharkfiltereth:~10,2%
set tsharkfiltereth=%tsharkfiltereth:~0,2%:%tsharkfiltereth:~2,2%:%tsharkfiltereth:~4,2%:%tsharkfiltereth:~6,2%:%tsharkfiltereth:~8,2%:%tsharkfiltereth:~10,2%
md MAC-%tsharkfilterethfilename%
for /f %%f in ('dir /b *.pcap') do (
tshark -r %%f -R eth.addr==%tsharkfiltereth% -2 -w .\MAC-%tsharkfilterethfilename%\%%f-%tsharkfilterethfilename%.pcap
)
echo.
GOTO QUIT

:SEARCHPORT
cls
echo.
echo.
echo ************ Filter by port for ALL files in current dir ****************
echo.
set /p tsharkfilterport=Enter the port:
set /p tsharkfilterproto=Enter tcp or udp:
echo.
md PORT-%tsharkfilterproto%%tsharkfilterport%
for /f %%f in ('dir /b *.pcap') do (
tshark -r %%f -R %tsharkfilterproto%.port==%tsharkfilterport% -2 -w .\PORT-%tsharkfilterproto%%tsharkfilterport%\%%f-PORT-%tsharkfilterproto%%tsharkfilterport%.pcap
)
echo.
GOTO QUIT

:SEARCHPROTO
cls
echo.
echo.
echo ************ Filter by protocol for ALL files in current dir ****************
echo.
set /p tsharkfilterproto=Enter the protocol:
echo.
md PROTO-%tsharkfilterproto%
for /f %%f in ('dir /b *.pcap') do (
tshark -r %%f -R %tsharkfilterproto% -2 -w .\PROTO-%tsharkfilterproto%\%%f-PROTO-%tsharkfilterproto%.pcap
)
echo.
GOTO QUIT

:MERGECAP
cls	
echo.
echo.
echo ***********************************************************************
echo *************************** MERGECAP MENU *****************************
echo ***********************************************************************
echo.
echo.
echo path=c:\Program Files\wireshark\
echo.
echo.
set /p mergedfilename=Input desired merged pcap filename:
echo mergecap %1 %2 %3 %4 %5 %6 %7 %8 %9 -w %mergedfilename%
mergecap %1 %2 %3 %4 %5 %6 %7 %8 %9 -w %mergedfilename%
echo working....
echo.
echo Mergecap COMPLETE
echo.
echo.
echo Enter a choice:
echo 1. Return to Main Menu
echo 9. EXIT 
echo.
set /p mergecapid=choice:
cls

if "%mergecapid%" == "1" (GOTO PROGRAMSTART)
if "%mergecapid%" == "9" (GOTO QUIT) else (GOTO PROGRAMSTART)


:EDITCAP
cls
echo.
echo.
echo ***********************************************************************
echo *************************** EDITCAP MENU *****************************
echo ***********************************************************************
echo.
echo.
echo Enter a choice:
echo 1. Split pcap file by date range
echo 2. Split pcap file by new pcap file size (in packets)
echo 3. Split pcap file by number of seconds
echo 4. Return to Main Menu
echo 9. EXIT 
echo.
set /p editcapid=choice:
echo %editcapid%

if "%editcapid%" == "1" (GOTO EDITCAPDATERANGE)
if "%editcapid%" == "2" (GOTO EDITCAPPACKETSIZE)
if "%editcapid%" == "3" (GOTO EDITCAPSECONDS)
if "%editcapid%" == "4" (GOTO PROGRAMSTART)
if "%editcapid%" == "9" (GOTO QUIT) else (GOTO PROGRAMSTART)

:EDITCAPDATERANGE
cls
echo.
echo.
echo ****************************************************
echo *********** Filter pcap by date/time range *********
echo ****************************************************
echo.
echo.
echo Enter a choice:
echo 1. Remove all packets before given date/time
echo 2. Remove all packets after given date/time
echo 3. Keep only packets between two given dates/times
echo 4. Return to Editcap Menu
echo 5. Return to Main Menu
echo 9. EXIT 
echo.
set /p editcapdtgid=choice:
echo %editcapdtgid%
if "%editcapdtgid%" == "1" (GOTO EDITCAPDTGBEFORE)
if "%editcapdtgid%" == "2" (GOTO EDITCAPDTGAFTER)
if "%editcapdtgid%" == "3" (GOTO EDITCAPDTGBETWEEN)
if "%editcapdtgid%" == "4" (GOTO EDITCAP)
if "%editcapdtgid%" == "5" (GOTO PROGRAMSTART)
if "%editcapdtgid%" == "9" (GOTO QUIT) else (GOTO PROGRAMSTART)


:EDITCAPDTGBEFORE
echo Enter START time to include in final pcap file
set /p editcapdaterangestart=Format: YYYY-MM-DDHH:MM:SS -- 
echo.
echo.
set /p editcapdaterangefilename=Enter new (filtered) pcap filename:
editcap -A %editcapdaterangestart% %1 %editcapdaterangefilename%
echo.
echo.
echo Editcap COMPLETE
echo.
echo.
pause.
GOTO PROGRAMSTART


:EDITCAPDTGAFTER
echo Enter END time to include in final pcap file
set /p editcapdaterangeend=Format: YYYY-MM-DDHH:MM:SS -- 
echo.
echo.
set /p editcapdaterangefilename=Enter new (filtered) pcap filename:
editcap -B %editcapdaterangeend% %1 %editcapdaterangefilename%
echo.
echo.
echo Editcap COMPLETE
echo.
echo.
pause.
GOTO PROGRAMSTART

:EDITCAPDTGBETWEEN
echo Enter START time to include in final pcap file
echo Format: YYYY-MM-DDHH:MM:SS
set /p editcapdaterangestart=(Leave blank to start at beginning of current pcap file):
echo.
echo.
echo Enter END time to include in final pcap file
echo Format: YYYY-MM-DDHH:MM:SS
set /p editcapdaterangeend=(Leave blank to include the end of the current pcap file):
echo.
echo.
set /p editcapdaterangefilename=Enter new (filtered) pcap filename:
editcap -A %editcapdaterangestart% -B %editcapdaterangeend% %1 %editcapdaterangefilename%
echo.
echo.
echo Editcap COMPLETE
echo.
echo.
pause
GOTO PROGRAMSTART


:EDITCAPPACKETSIZE
echo.
echo.
set /p editcappacketsizeid=Enter the number of packets per output pcap file: 
echo.
echo.
set /p editcapdaterangefilename=Enter new (filtered) pcap filename:
editcap -c %editcappacketsizeid% %1 %editcapdaterangefilename%
echo.
echo.
echo Editcap COMPLETE
echo.
echo.
pause
GOTO PROGRAMSTART


:EDITCAPSECONDS
echo.
echo.
set /p editcapsecondsid=Enter the number of seconds per output pcap file: 
echo.
echo.
set /p editcapdaterangefilename=Enter new (filtered) pcap filename:
editcap -i %editcapsecondsid% %1 %editcapdaterangefilename%
echo.
echo.
echo Editcap COMPLETE
echo.
echo.
pause
GOTO PROGRAMSTART


:TSHARKMENU
cls
echo.
echo.
echo ***********************************************************************
echo ***************************** TSHARK MENU *****************************
echo ***********************************************************************
echo.
echo.
echo Enter a choice:
echo 1. Filter by IP address
echo 2. Filter by MAC address
echo 3. Filter by CIDR address (network range)
echo 4. Filter by protocol
echo 5. Filter by port number
echo 9. EXIT 
echo.
set /p tsharkid=choice:

if "%tsharkid%" == "1" (GOTO TSHARKIPMENU)
if "%tsharkid%" == "2" (GOTO TSHARKMACMENU)
if "%tsharkid%" == "3" (GOTO TSHARKCIDR)
if "%tsharkid%" == "4" (GOTO TSHARKPROTOCOL)
if "%tsharkid%" == "5" (GOTO TSHARKPORT)
if "%tsharkid%" == "9" (GOTO QUIT) else (GOTO PROGRAMSTART)


:TSHARKIP
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

:TSHARKMAC
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
GOTO QUIT

:TSHARKMACMENU
echo.
echo.
echo *********************** Filter by MAC MENU ****************************
echo.
echo Enter a filter type:
echo.
echo 1. Filter by either source or destination MAC
echo 2. Filter by destination MAC
echo 3. Filter by source MAC
echo 4. Go back to TSHARK MENU
echo 5. Go back to MAIN MENU
echo 9. EXIT
echo.
set /p tsharkfilteripid=Enter the filter type:
echo.
if "%tsharkfilteripid%" == "1" (GOTO TSHARKMAC)
if "%tsharkfilteripid%" == "2" (GOTO TSHARKFILTERMACDEST)
if "%tsharkfilteripid%" == "3" (GOTO TSHARKFILTERMACSRC)
if "%tsharkfilteripid%" == "4" (GOTO TSHARKMENU)
if "%tsharkfilteripid%" == "5" (GOTO PROGRAMSTART)
if "%tsharkfilteripid%" == "9" (GOTO QUIT)
echo.
pause

:TSHARKIPMENU
echo.
echo.
echo *********************** Filter by IP MENU ****************************
echo.
echo Enter a filter type:
echo.
echo 1. Filter by either source or destination IP
echo 2. Filter by destination IP
echo 3. Filter by source IP
echo 4. Go back to TSHARK MENU
echo 5. Go back to MAIN MENU
echo 9. EXIT
echo.
set /p tsharkfilteripid=Enter the filter type:
echo.
if "%tsharkfilteripid%" == "1" (GOTO TSHARKIP)
if "%tsharkfilteripid%" == "2" (GOTO TSHARKFILTERIPDEST)
if "%tsharkfilteripid%" == "3" (GOTO TSHARKFILTERIPSRC)
if "%tsharkfilteripid%" == "4" (GOTO TSHARKMENU)
if "%tsharkfilteripid%" == "5" (GOTO PROGRAMSTART)
if "%tsharkfilteripid%" == "9" (GOTO QUIT)
echo.
pause

:TSHARKPORT
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
echo Tshark Port Filter COMPLETE
echo.
echo.
pause
GOTO PROGRAMSTART 

:TSHARKFILTERIPDEST
echo.
echo.
echo *********************** Filter by Destination IP Address ****************************
echo.
set /p tsharkfilterip=Enter the IP address:
echo.
tshark -r %1 -R ip.dst==%tsharkfilterip% -2 -w .\dest-%tsharkfilterip%.pcap
echo.
GOTO QUIT

:TSHARKFILTERMACDEST
echo.
echo.
echo *********************** Filter by Destination MAC Address ****************************
echo.
set /p tsharkfiltereth=Enter the MAC address (no delimiters): 
echo.
set tsharkfilterethfilename=%tsharkfiltereth:~0,2%-%tsharkfiltereth:~2,2%-%tsharkfiltereth:~4,2%-%tsharkfiltereth:~6,2%-%tsharkfiltereth:~8,2%-%tsharkfiltereth:~10,2%
set tsharkfiltereth=%tsharkfiltereth:~0,2%:%tsharkfiltereth:~2,2%:%tsharkfiltereth:~4,2%:%tsharkfiltereth:~6,2%:%tsharkfiltereth:~8,2%:%tsharkfiltereth:~10,2%
tshark -r %1 -R eth.dst==%tsharkfiltereth% -2 -w .\dst-%tsharkfilterethfilename%.pcap
echo.
GOTO QUIT

:TSHARKFILTERIPSRC
echo.
echo.
echo *********************** Filter by Source IP Address ****************************
echo.
set /p tsharkfilterip=Enter the IP address:
echo.
tshark -r %1 -R ip.src==%tsharkfilterip% -2 -w .\src-%tsharkfilterip%.pcap
echo.
GOTO QUIT

:TSHARKFILTERMACSRC
echo.
echo.
echo *********************** Filter by Source MAC Address ****************************
echo.
set /p tsharkfiltereth=Enter the MAC address (no delimiters): 
echo.
set tsharkfilterethfilename=%tsharkfiltereth:~0,2%-%tsharkfiltereth:~2,2%-%tsharkfiltereth:~4,2%-%tsharkfiltereth:~6,2%-%tsharkfiltereth:~8,2%-%tsharkfiltereth:~10,2%
set tsharkfiltereth=%tsharkfiltereth:~0,2%:%tsharkfiltereth:~2,2%:%tsharkfiltereth:~4,2%:%tsharkfiltereth:~6,2%:%tsharkfiltereth:~8,2%:%tsharkfiltereth:~10,2%
tshark -r %1 -R eth.src==%tsharkfiltereth% -2 -w .\src-%tsharkfilterethfilename%.pcap
echo.
GOTO QUIT

REM Version Notes
REM ********** v0.2 **********
REM 1. Cleaned up some code to standardize numbering
REM 2. Moved all EXIT variables to "9" for standarization
REM 3. Added all Tshark filters
REM 
REM ********** v0.3 **********
REM 1. Cleaned up some code; reordered items
REM 2. Replaced the post-action loop to immediately dump to QUIT
REM 
REM ********** v0.4 **********
REM 1. Amended main menu to include "quick" actions
REM 2. Fixed deprecated tshark bug to include '-2' for two-pass filtering
REM 3. Added new tshark filters (MAC address)
REM
REM ********** v0.5 **********
REM 1. Added SEARCH section for all files in a dir (iterates over each file)
REM 2. Created git repository for this project