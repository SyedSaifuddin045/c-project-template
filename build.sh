#!/usr/bin/env bash
set -e

# Default mode is release/production
MODE="${1:-release}"
if [ "$MODE" = "dev" ]; then
    MODE="dev"
fi

echo "========================================="
echo " Mode: ${MODE} "
echo "========================================="

echo "=== 1. Configuring Project ==="
if [ "$MODE" == "dev" ]; then
    # Dev mode: Enable Debug symbols and turn testing ON
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON
else
    # Release mode: Maximize optimizations and turn testing ON to validate release
    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON
fi

echo ""
echo "=== 2. Compiling Library and Tests ==="
cmake --build build

echo ""
echo "=== 3. Executing Unit Tests ==="
if [ "$MODE" == "dev" ]; then
    # Dev mode: If tests fail, don't crash the script so you can keep working
    set +e
    ctest --test-dir build --output-on-failure
    set -e
else
    # Release mode: Strict. If a test fails, crash immediately and abort deployment
    ctest --test-dir build --output-on-failure
    echo ""
    echo "=== Pipeline Completed Successfully! ==="
fi
