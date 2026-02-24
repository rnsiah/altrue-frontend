#!/bin/bash

# Altrue Frontend Test Runner
# Usage: ./run_tests.sh [options]
# Options:
#   --unit        Run only widget tests
#   --integration Run only integration tests
#   --coverage    Run with coverage report

set -e

echo "🧪 Altrue Flutter Test Suite"
echo "============================="

# Default options
FLUTTER_ARGS=""

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --unit)
            FLUTTER_ARGS="test/widget"
            shift
            ;;
        --integration)
            FLUTTER_ARGS="test/integration"
            shift
            ;;
        --coverage)
            FLUTTER_ARGS="--coverage"
            shift
            ;;
        *)
            FLUTTER_ARGS="$FLUTTER_ARGS $1"
            shift
            ;;
    esac
done

# Run tests
echo "Running Flutter tests..."
flutter test $FLUTTER_ARGS

echo ""
echo "✅ Tests completed!"
