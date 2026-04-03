@echo off
setlocal
echo ======================================================
echo   3D Simulation Environment - Automated Build Tool
echo   Project: Multi-Users 3D Simulation (CEIT)
echo ======================================================

:: 1. Install Build Tools via winget
echo [1/4] Ensuring CMake and Ninja are installed...
winget install Kitware.CMake --silent --accept-source-agreements
winget install Ninja-build.Ninja --silent --accept-source-agreements
winget install MSYS2.MSYS2 --silent --accept-source-agreements

:: 2. Install GCC Compiler (MinGW-w64) inside MSYS2
echo [2/4] Verifying C++17 Compiler (MinGW-w64)...
if exist "C:\msys64\usr\bin\bash.exe" (
    "C:\msys64\usr\bin\bash.exe" -lc "pacman -S --noconfirm mingw-w64-ucrt-x86_64-gcc"
) else (
    echo [!] MSYS2 not found at C:\msys64. Please install manually or check path.
    pause
    exit /b
)

:: 3. Configure and Build with CMake
echo [3/4] Running CMake Configuration (OpenGL 3.3 Core)...
:: Update PATH for this session to include the compiler and build tools
set "PATH=C:\msys64\ucrt64\bin;C:\msys64\usr\bin;%PATH%"

:: Using Ninja for faster builds as per README requirements
cmake -B build -G Ninja ^
  -DCMAKE_C_COMPILER=C:/msys64/ucrt64/bin/gcc.exe ^
  -DCMAKE_CXX_COMPILER=C:/msys64/ucrt64/bin/g++.exe ^
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

if %ERRORLEVEL% NEQ 0 (
    echo [!] CMake Configuration failed. Check your OpenGL/Dependency paths.
    pause
    exit /b %ERRORLEVEL%
)

echo [3.5/4] Compiling Source...
ninja -C build

:: 4. Launch the Simulation
if %ERRORLEVEL% EQU 0 (
    echo [4/4] Success! Launching 3D Simulation...
    :: Using a generic name; change 'MyGame.exe' if your CMake target differs
    if exist ".\build\MyGame.exe" (
        .\build\MyGame.exe
    ) else (
        echo [!] Executable not found. Check your CMakeLists.txt target name.
    )
) else (
    echo [!] Build failed. Please check the error logs above.
)

pause
endlocal
