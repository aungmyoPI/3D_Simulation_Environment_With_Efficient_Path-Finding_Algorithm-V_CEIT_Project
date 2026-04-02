cmake_minimum_required(VERSION 3.24) # Minimum for better FetchContent support
project(MyOpenGLGame 
    VERSION 1.0.0 
    LANGUAGES C CXX
)

# --- 1. Global Project Settings ---
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Optimization: Enable Interprocedural Optimization (LTO) if supported by the compiler
include(CheckIPOSupported)
check_ipo_supported(RESULT ipo_supported OUTPUT ipo_error)
if(ipo_supported)
    set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
endif()

# --- 2. Dependency Management (The FetchContent Pattern) ---
include(FetchContent)

# GLFW (Windowing & Context)
FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.4
    SYSTEM # Treats GLFW headers as 'system' headers (ignores their warnings)
)
FetchContent_MakeAvailable(glfw)

# --- 3. Internal Library: GLAD (The OpenGL Loader) ---
# Assuming GLAD files are in external/glad/
add_library(glad_loader STATIC 
    external/glad/src/glad.c
)
target_include_directories(glad_loader PUBLIC 
    external/glad/include
)

# --- 4. Find System OpenGL Driver ---
# We cannot "fetch" the GPU driver. We must find the system's interface.
find_package(OpenGL REQUIRED)

# --- 5. The Main Executable ---
# List files explicitly for better build reliability (standard practice over GLOB)
set(GAME_SOURCES
    src/main.cpp
    src/core/Application.cpp
    src/renderer/Renderer.cpp
    src/renderer/Shader.cpp
    # Add other files here...
)

add_executable(MyGame ${GAME_SOURCES})

# --- 6. Linking & Include Directories ---
target_include_directories(MyGame PRIVATE 
    include
    src
)

target_link_libraries(MyGame PRIVATE
    glfw            # Target created by FetchContent
    glad_loader     # Our internal static library
    OpenGL::GL      # The Universal OpenGL target (handles libGL or opengl32)
)

# --- 7. OS-Specific Fixes (Optimization) ---
if(UNIX AND NOT APPLE)
    # On Linux/WSL, we often need the math library and dynamic loading
    target_link_libraries(MyGame PRIVATE m dl)
endif()

if(WIN32)
    # This captures the necessary GCC/Standard library DLLs 
    # so your friends don't have to set their PATH manually.
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libgcc -static-libstdc++ -static")
endif()
