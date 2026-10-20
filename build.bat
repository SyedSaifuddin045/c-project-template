@echo off
cls

:: Default mode is release
set MODE=release
if "%1"=="dev" set MODE=dev

echo =========================================
echo  Mode: %MODE%
echo =========================================

echo === 1. Configuring Project ===
if "%MODE%"=="dev" (
    call cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON
) else (
    call cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON
)
if %errorlevel% neq 0 exit /b %errorlevel%

echo.
echo === 2. Compiling Library and Tests ===
call cmake --build build
if %errorlevel% neq 0 exit /b %errorlevel%

echo.
echo === 3. Executing Unit Tests ===
if "%MODE%"=="dev" (
    :: Dev mode: Run tests but ignore the failure exit code
    call ctest --test-dir build --output-on-failure
    echo.
    echo [DEV] Build process finished. Review test output above.
) else (
    :: Release mode: Strict error checking
    call ctest --test-dir build --output-on-failure
    if %errorlevel% neq 0 (
        echo.
        echo [ERROR] Unit tests failed! Aborting release pipeline.
        exit /b %errorlevel%
    )
    echo.
    echo === Pipeline Completed Successfully! ===
)
