#!/bin/sh

set -e

SUPPORT_DIR=~/swork/browser-support

cd $SUPPORT_DIR

echo "Updating qt..."
cd qt5
git fetch --recurse-submodules
git checkout 90f7cf110710bb59c2993d6d1848223baeb9642b
git submodule update --recursive
cd qtdeclarative && git fetch http://codereview.qt-project.org/p/qt/qtdeclarative refs/changes/17/7617/1 && git cherry-pick FETCH_HEAD
cd ../..

echo "Updating webkit..."
cd webkit && git pull --rebase && cd ..

echo "Done"


