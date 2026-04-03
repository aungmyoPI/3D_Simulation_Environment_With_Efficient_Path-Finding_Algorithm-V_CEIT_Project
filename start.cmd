@echo off
setlocal EnableDelayedExpansion

:: 1. Force Administrative Privileges
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [!] ERROR: This setup requires Administrative Privileges.
    echo [!] Please right-click 'start.cmd' and select 'Run as Administrator'.
    pause
    exit /b
)

echo ======================================================
echo    3D Simulation - All-in-One Setup & Build
echo ======================================================

:: 2. Install Tools via Winget
echo [1/5] Installing Git, CMake, Ninja, and MSYS2...
for %%i in (Git.Git Kitware.CMake Ninja-build.Ninja MSYS2.MSYS2) do (
    echo Checking %%i...
    winget install %%i --silent --accept-source-agreements --upgrade-available
)

:: 3. Clone the Repository
echo [2/5] Cloning the Project Repository...
set "REPO_URL=https://github.com/aungmyoPI/Multi-Users_3D_Simulation_Environment_With_Efficient_Path-Finding_Algorithm-V_CEIT_Project.git"
set "FOLDER_NAME=Multi-Users_3D_Simulation_Environment_With_Efficient_Path-Finding_Algorithm-V_CEIT_Project"

if not exist "%FOLDER_NAME%" (
    git clone %REPO_URL%
) else (
    echo Project folder already exists. Skipping clone...
)

:: Move into the project directory
cd %FOLDER_NAME%

:: 4. Setup C++ Compiler (UCRT64)
echo [3/5] Configuring Compiler inside MSYS2...
set "MSYS_PATH=C:\msys64\usr\bin\bash.exe"
if exist "%MSYS_PATH%" (
    "%MSYS_PATH%" -lc "pacman -S --noconfirm --needed mingw-w64-ucrt-x86_64-gcc"
) else (
    echo [!] MSYS2 installation not found. Please try running the script again.
    pause
    exit /b 1
)

:: 5. Build the Project
echo [4/5] Preparing the build directory...
set "PATH=C:\msys64\ucrt64\bin;C:\msys64\usr\bin;%PATH%"

if not exist "build" mkdir build

cmake -S . -B build -G Ninja ^
  -DCMAKE_C_COMPILER=gcc.exe ^
  -DCMAKE_CXX_COMPILER=g++.exe

if %ERRORLEVEL% NEQ 0 (
    echo [!] Configuration failed.
    pause
    exit /b %ERRORLEVEL%
)

echo [5/5] Compiling System...
ninja -C build

echo.
echo ======================================================
echo SETUP COMPLETE!
echo ======================================================
echo All dependencies are installed and the system is built.
echo.
echo To run the simulation, type:
echo    cd %FOLDER_NAME%
echo    .\build\MyGame.exe
echo ======================================================
pause
endlocal
