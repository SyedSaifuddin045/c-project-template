cmake_minimum_required(VERSION 3.20)

project(TinyJSON
    VERSION 0.1.0
    LANGUAGES C
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

set(include_dir "${PROJECT_SOURCE_DIR}/include/")
set(source_dir "${PROJECT_SOURCE_DIR}/src/")

file(GLOB_RECURSE source_files "${source_dir}/*.c")
file(GLOB_RECURSE header_files "${include_dir}/*.h")

add_library(TinyJSON ${source_files} ${header_files})

target_include_directories(TinyJSON PUBLIC ${include_dir})

if(MSVC)
    target_compile_options(TinyJSON PRIVATE /W4 /permissive-)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_compile_options(TinyJSON PRIVATE /WX)
    endif()
elseif(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang|AppleClang")
    target_compile_options(TinyJSON PRIVATE -Wall -Wextra -Wpedantic)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_compile_options(TinyJSON PRIVATE -Werror)
    endif()
endif()

#TESTING
include(CTest)

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()