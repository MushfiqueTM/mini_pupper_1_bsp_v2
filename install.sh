#!/usr/bin/env bash
set -e

UBUNTU_CODENAME=$(lsb_release -cs)

echo "Detected Ubuntu: $UBUNTU_CODENAME"

if [ "$UBUNTU_CODENAME" = "jammy" ]; then
    ROS_DISTRO=humble
elif [ "$UBUNTU_CODENAME" = "noble" ]; then
    ROS_DISTRO=jazzy
else
    echo "Unsupported Ubuntu version"
    exit 1
fi

echo "Installing ROS $ROS_DISTRO dependencies"

sudo apt update

sudo apt install -y \
    i2c-tools \
    curl \
    python-is-python3 \
    mpg123 \
    python3-tk \
    openssh-server \
    screen \
    alsa-utils \
    libportaudio2 \
    libsndfile1

echo "Installing Python modules"

pip3 install --break-system-packages \
    spidev \
    numpy \
    pillow

echo "Installing EEPROM overlay"
cd EEPROM
sudo bash install.sh
cd ..

echo "Installing IO configuration"
cd IO_Configuration
sudo bash install.sh
cd ..

echo "BSP installation completed"
