#!/bin/sh

set -e

echo "Get the sources..."

SUPPORT_DIR=~/swork/browser-support

mkdir -p $SUPPORT_DIR
cd $SUPPORT_DIR

echo "Fetching qtbase..."
git clone git://gitorious.org/qt/qtbase.git
cd qtbase
git submodule update --init
cd ..

echo "Fetching qtdeclarative..."
git clone git://gitorious.org/qt/qtdeclarative.git

echo "Fetching qtscript..."
git clone git://gitorious.org/qt/qtscript.git

echo "Fetching webkit..."
git clone git://gitorious.org/webkit/webkit.git

echo "Done"


