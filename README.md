# C Project Template

Minimal C project template with CMake, Unity testing, and simple build scripts.

## Features
- CMake (3.20+) with C17
- Unity testing framework via FetchContent
- Cross-platform: `build.sh` / `build.bat`
- Auto test discovery: any `*.c` in `tests/` becomes a CTest executable
- Compiler warnings + warnings-as-errors in Debug
- Dev/Release modes

## Quick start
```bash
./build.sh dev   # Linux/macOS
build.bat dev    # Windows
```

## Structure
```text
.
├── CMakeLists.txt
├── build.sh
├── build.bat
├── include/
├── src/           # put main.c or library sources here
├── tests/         # Unity tests
└── LICENSE
```

## Rename
Update `project(MyProject ...)` in `CMakeLists.txt`. Add sources to `src/` and tests to `tests/`.
