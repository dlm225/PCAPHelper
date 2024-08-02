@echo off
setlocal enabledelayedexpansion

REM Check if a file was provided as an argument
if "%~1"=="" (
    echo Please drag and drop a .pcapng or .pcap file onto this batch file.
    pause
    exit /b 1
)

REM Get the full path of the input file
set "input_file=%~f1"

REM Check if the input file exists
if not exist "%input_file%" (
    echo File not found: %input_file%
    pause
    exit /b 1
)

REM Check if the input file has a .pcapng or .pcap extension
if /i not "%~x1"==".pcapng" if /i not "%~x1"==".pcap" (
    echo Input file must have a .pcapng or .pcap extension.
    pause
    exit /b 1
)

REM Create the output filename
set "output_file=%~dpn1_converted.pcap"

REM Convert the file using tshark
echo Converting %input_file% to %output_file%...
tshark -r "%input_file%" -w "%output_file%" -F pcap

REM Check if the conversion was successful
if %errorlevel% equ 0 (
    echo Conversion completed successfully.
) else (
    echo Conversion failed. Please check if tshark is installed and in your PATH.
)

pause