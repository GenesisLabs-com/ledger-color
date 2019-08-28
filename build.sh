#!/bin/bash
# Upload Color App to Ledger Nano
echo "***Downloading Submodules***"
git submodule update --init --recursive
echo "***Downloading Color App***"
git submodule add https://github.com/RNSSolution/ledger-color-app
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
mv "$parent_path"/ledger-color-app/* "$parent_path"/src/ledger-user/
echo "***Downloading Essential Modules"
sudo apt-get update && sudo apt-get -y install build-essential git sudo wget cmake libssl-dev libgmp-dev$
echo "***Downloading Modules of Python"
make deps
echo "***Installing Cmake"
sudo apt-get -y install cmake
echo "***Installing C++ Files***"
cmake -DDISABLE_DOCKER_BUILDS=ON . && make
export GTEST_COLOR=1 && ctest -VV
echo "***Parent Path"
echo "$parent_path"
echo "***Build***"
make        # Builds both Cosmos and Tendermint apps
cp "$parent_path"/load_color/* "$parent_path"/
echo ***Loads Color App - ledger Nano App should be attached -***
make load_color         # Loads Color app       (for users)
