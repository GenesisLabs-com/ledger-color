#!/bin/bash
# Upload Color App to Ledger Nano
echo "***Downloading Submodules***"
git submodule update --init --recursive
echo "***Downloading Essential Modules"
sudo apt-get update && sudo apt-get -y install build-essential git sudo wget cmake libssl-dev libgmp-dev autoconf libtool python-pip
echo "***Downloading Modules of Python"
make deps
echo "***Installing Cmake""
sudo apt-get -y install cmake
echo "***Installing C++ Files***"
cmake -DDISABLE_DOCKER_BUILDS=ON . && make
export GTEST_COLOR=1 && ctest -VV
cp load_color/Makefile .
echo "***Build Color App***"
make        # Builds both Cosmos and Tendermint apps

echo "***Loads Color App***"
make load_cosmos         # Loads Color app       (for users)
