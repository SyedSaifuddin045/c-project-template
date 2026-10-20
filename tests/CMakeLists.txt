cmake_minimum_required(VERSION 3.20)
project(TinyJSON_Tests LANGUAGES C)

# 1. Fetch the Unity C Testing Framework from GitHub automatically
include(FetchContent)
FetchContent_Declare(
    unity
    GIT_REPOSITORY https://github.com/ThrowTheSwitch/Unity
    GIT_TAG        v2.7.0
    GIT_SHALLOW    TRUE
)
FetchContent_MakeAvailable(unity)

# ====================================================================
# DYNAMIC TEST SETUP (AUTOMATED RECURSION)
# ====================================================================

# 2. Collect all test C source files dynamically from the tests directory
file(GLOB test_files "${CMAKE_CURRENT_SOURCE_DIR}/*.c")

# 3. Iterate over every found test file to set them up automatically
foreach(test_source_path IN LISTS test_files)
    
    # Extract the plain file name without the full path or extension (e.g., "test_parser")
    get_filename_component(test_name "${test_source_path}" NAME_WE)
    
    # Define an independent test executable for this specific file
    add_executable(${test_name} "${test_source_path}")
    
    # Link the executable against your library and Unity
    target_link_libraries(${test_name} PRIVATE TinyJSON unity)
    
    # Register this program as a separate test command inside CTest
    add_test(NAME ${test_name} COMMAND ${test_name})
    
endforeach()