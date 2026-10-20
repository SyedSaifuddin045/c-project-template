# C Project Template

A minimal, portable C project template with CMake, Unity testing, and simple build scripts.

## Features

- **CMake** (3.20+) with C17
- **Unity** testing framework via FetchContent (v2.7.0)
- **Cross-platform**: `build.sh` (macOS/Linux/Bash) and `build.bat` (Windows)
- **Auto test discovery**: any `*.c` in `tests/` becomes a CTest executable
- **Compiler warnings**: `-Wall -Wextra -Wpedantic` (GCC/Clang), `/W4 /permissive-` (MSVC)
- **Strict in Debug**: warnings-as-errors enabled in Debug builds
- **Dev/Release modes**: strict test failure in release, non-blocking in dev

## Getting Started

### Build and test

**Linux/macOS (Bash):**
```bash
# Release build (strict, fails on test errors)
./build.sh

# Development build (non-blocking on test errors)
./build.sh dev
```

**Windows (CMD):**
```cmd
:: Release build
build.bat

:: Development build
build.bat dev
```

CMake will generate artifacts in `build/`. Binaries go under `build/` and test executables inside `build/tests/`.

### Run tests manually

```bash
ctest --test-dir build --output-on-failure
```

### Using this as a template

1. Clone/copy this project to a new directory
2. Rename the project:
   - Update `project(TinyJSON ...)` in `CMakeLists.txt` (root)
   - Update include guard and function names in `include/tinyjson.h` and `src/tinyjson.c`
   - Update test includes in `tests/*.c`
3. Add your own source files (or replace the stubs)
4. Add tests under `tests/` (each `.c` file is picked up automatically)

## Project Structure

```text
.
├── CMakeLists.txt
├── build.sh
├── build.bat
├── include/           # Public headers
├── src/               # Implementation
├── tests/             # Unity tests (auto-discovered)
└── build/             # Build output (git-ignored)
```

## Notes

- If you add/remove source files, CMake uses `GLOB`. If it doesn't pick them up, reconfigure (`cmake -S . -B build`) or touch `CMakeLists.txt`.
- `compile_commands.json` is generated in `build/` for LSPs (clangd).
- Unity is fetched automatically by CMake's FetchContent (no submodules needed).
