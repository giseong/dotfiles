#!/bin/bash

# Default to light mode
appearance="light"

# Check if running on macOS
if [[ "$(uname)" == "Darwin" ]]; then
    # Get the current appearance setting
    osx_appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
    if [[ "$osx_appearance" == "Dark" ]]; then
        appearance="dark"
    fi
fi

echo $appearance
