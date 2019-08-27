#!/bin/bash
# Upload Color App to Ledger Nano
echo "***Downloading Submodules***"
git submodule update --init --recursive
echo "***Downloading Essential Modules"
sudo apt-get update && sudo apt-get -y install build-essential git sudo wget cmake libssl-dev libgmp-dev autoconf libtool python-pip
echo "***Downloading Modules of Python"
make deps
echo "***Installing Cmake"
sudo apt-get -y install cmake
echo "***Installing C++ Files***"
cmake -DDISABLE_DOCKER_BUILDS=ON . && make
export GTEST_COLOR=1 && ctest -VV
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
echo "***Parent Path"
echo "$parent_path"
cp "$parent_path"/load_color/* "$parent_path"/

make        # Builds both Cosmos and Tendermint apps

echo ***Loads Color App - ledger Nano App should be attached -***
make load_cosmos         # Loads Color app       (for users)
