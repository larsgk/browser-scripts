#!/bin/sh

set -e

echo "Get the sources..."

SUPPORT_DIR=~/swork/browser-support

mkdir -p $SUPPORT_DIR
cd $SUPPORT_DIR

echo "Fetching qtbase..."
git clone git://gitorious.org/qt/qt5.git qt5
cd qt5
git checkout 37ea8e961b8fdaaa1f36758b8ad059b23c013f15
./init-repository --module-subset=qtbase,qtxmlpatterns,qtscript,qtdeclarative
wget -O patch.txt http://paste.kde.org/133687/raw/
wget -O patch2.txt http://paste.kde.org/134605/
cd qtbase
git am -3 ../patch.txt
git am -3 ../patch2.txt


cd $SUPPORT_DIR

echo "Fetching webkit..."
git clone git://gitorious.org/webkit/webkit.git

echo "Done"


