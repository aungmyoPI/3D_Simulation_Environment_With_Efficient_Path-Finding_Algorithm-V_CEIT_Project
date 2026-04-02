@echo off
setlocal
echo ======================================================
echo   3D Simulation Environment - Automated Build Tool
echo ======================================================

:: 1. Install dependencies via winget
echo [1/4] Checking for Build Tools...
winget install Kitware.CMake --silent --accept-source-agreements >nul
winget install Ninja-build.Ninja --silent --accept-source-agreements >nul
winget install MSYS2.MSYS2 --silent --accept-source-agreements >nul

:: 2. Set up the Compiler Path (Session-based)
:: This ensures CMake can find gcc/g++ even if it's not in the system PATH
echo [2/4] Configuring Compiler Environment...
set "PATH=%PATH%;C:\msys64\ucrt64\bin;C:\msys64\usr\bin"

:: 3. Configure and Build using the path to the MSYS2 compilers
echo [3/4] Running CMake and Ninja...
cmake -B build -G Ninja ^
  -DCMAKE_C_COMPILER=C:/msys64/ucrt64/bin/gcc.exe ^
  -DCMAKE_CXX_COMPILER=C:/msys64/ucrt64/bin/g++.exe

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [!] CMake Configuration failed. Please ensure MSYS2 is installed.
    pause
    exit /b %ERRORLEVEL%
)

ninja -C build

:: 4. Run the Project
if %ERRORLEVEL% EQU 0 (
    echo.
    echo [4/4] Success! Launching MyGame...
    .\build\MyGame.exe
) else (
    echo.
    echo [!] Build failed.
)

pause
endlocal
