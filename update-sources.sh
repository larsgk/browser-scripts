#!/bin/sh

set -e

SUPPORT_DIR=~/swork/browser-support

cd $SUPPORT_DIR

echo "Updating qt..."
cd qt5 && git pull --rebase && git submodule update --init && cd ..

echo "Updating webkit..."
cd webkit && git pull --rebase && cd ..

echo "Done"


