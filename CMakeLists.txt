cmake_minimum_required(VERSION 3.20)

project(HelloWorld
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

add_library(hello_lib ${source_files} ${header_files})
target_include_directories(hello_lib PUBLIC ${include_dir})

# Hello world executable
add_executable(hello_world ${CMAKE_CURRENT_SOURCE_DIR}/src/main.c)
target_link_libraries(hello_world PRIVATE hello_lib)

if(MSVC)
    target_compile_options(hello_lib PRIVATE /W4 /permissive-)
    target_compile_options(hello_world PRIVATE /W4 /permissive-)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_compile_options(hello_lib PRIVATE /WX)
        target_compile_options(hello_world PRIVATE /WX)
    endif()
elseif(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang|AppleClang")
    target_compile_options(hello_lib PRIVATE -Wall -Wextra -Wpedantic)
    target_compile_options(hello_world PRIVATE -Wall -Wextra -Wpedantic)
    if(CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_compile_options(hello_lib PRIVATE -Werror)
        target_compile_options(hello_world PRIVATE -Werror)
    endif()
endif()

#TESTING
include(CTest)

if(BUILD_TESTING)
    add_subdirectory(tests)
endif()