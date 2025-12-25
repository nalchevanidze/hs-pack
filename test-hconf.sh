#!/bin/bash

NAME="hconf"
EXECUTABLE="$NAME"

case "$(uname)" in
    "Darwin")
        OS=mac-os;;
    MINGW64_NT-*|MSYS_NT-*)
        OS=windows;;
    *)
        OS=linux;;
esac

if [ "$OS" == "windows" ]; then
  EXECUTABLE="$NAME.exe"
fi

rm -rf out
mkdir -p out

# Check if 7z is available
command -v 7z >/dev/null 2>&1 || { echo "7z is required but not installed"; exit 1; }

7z e "$NAME.zip" -o./out || { echo "Failed to extract $NAME.zip"; exit 1; }

# Check if the executable was extracted successfully
if [ ! -f "./out/$EXECUTABLE" ]; then
  echo "Executable not found: ./out/$EXECUTABLE"
  exit 1
fi

./out/$EXECUTABLE about

rm -rf out
