@echo off
setlocal
echo ======================================================
echo   3D Simulation Environment - Automated Build Tool
echo ======================================================

:: 1. Install MSYS2, CMake, and Ninja via winget
echo [1/4] Ensuring Build Tools are installed...
winget install Kitware.CMake --silent --accept-source-agreements
winget install Ninja-build.Ninja --silent --accept-source-agreements
winget install MSYS2.MSYS2 --silent --accept-source-agreements

:: 2. Install the GCC Compiler INSIDE MSYS2 from Windows CMD
:: We call MSYS2's bash to run the update and install the compiler
echo [2/4] Installing C++ Compiler (MinGW-w64)...
if exist "C:\msys64\usr\bin\bash.exe" (
    "C:\msys64\usr\bin\bash.exe" -lc "pacman -S --noconfirm mingw-w64-ucrt-x86_64-gcc"
) else (
    echo [!] MSYS2 not found at C:\msys64. Please check installation.
    pause
    exit /b
)

:: 3. Configure and Build
echo [3/4] Running CMake and Ninja...
:: Add the new compiler path to this session's PATH
set "PATH=%PATH%;C:\msys64\ucrt64\bin;C:\msys64\usr\bin"

cmake -B build -G Ninja ^
  -DCMAKE_C_COMPILER=C:/msys64/ucrt64/bin/gcc.exe ^
  -DCMAKE_CXX_COMPILER=C:/msys64/ucrt64/bin/g++.exe

if %ERRORLEVEL% NEQ 0 (
    echo [!] CMake Configuration failed.
    pause
    exit /b %ERRORLEVEL%
)

ninja -C build

:: 4. Run the Project
if %ERRORLEVEL% EQU 0 (
    echo [4/4] Success! Launching MyGame...
    .\build\MyGame.exe
) else (
    echo [!] Build failed.
)

pause
endlocal


