#!/bin/bash

echo "Checking dependencies..."

# Check Chrome
if command -v google-chrome >/dev/null 2>&1; then
    chrome_version=$(google-chrome --version | awk '{print $3}' | cut -d'.' -f1)
    chrome_installed=true
else
    chrome_version=0
    chrome_installed=false
fi

# Check ChromeDriver
if command -v chromedriver >/dev/null 2>&1; then
    driver_version=$(chromedriver --version | awk '{print $2}' | cut -d'.' -f1)
    driver_installed=true
else
    driver_version=0
    driver_installed=false
fi

# Determine if installation is needed
mismatch=false
if [ "$chrome_version" != "$driver_version" ]; then
    mismatch=true
fi

if ! $chrome_installed || ! $driver_installed || $mismatch; then
    echo "Chrome or ChromeDriver missing/mismatched → Installing dependencies..."

    # Update and install Python/pip
    sudo apt update
    sudo apt install -y python3 python3-pip wget unzip

    # Install Robot Framework and Selenium
    pip3 install --upgrade robotframework robotframework-seleniumlibrary selenium

    # Install Google Chrome if missing
    if ! $chrome_installed; then
        wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo apt install -y ./google-chrome-stable_current_amd64.deb
    fi

    # Install matching ChromeDriver
    CHROME_VERSION=$(google-chrome --version | awk '{print $3}')
    wget -q https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VERSION/linux64/chromedriver-linux64.zip
    unzip -o chromedriver-linux64.zip
    sudo mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
    sudo chmod +x /usr/bin/chromedriver

else
    echo "Chrome and ChromeDriver are installed and matching → Skipping installation."
fi

# Add local user bin to PATH (to ensure user-level robot works)
export PATH=$HOME/.local/bin:$PATH

# Check if robot is installed, else install system-wide
if ! command -v robot >/dev/null 2>&1; then
    echo "Robot Framework not found → Installing..."
    sudo /usr/bin/python3 -m pip install --upgrade robotframework robotframework-seleniumlibrary selenium
fi

# Run Robot test
echo "Running Robot Framework test..."
robot keyword.robot
echo "Robot test execution finished."
