#!/bin/sh

set -e

echo "Get the sources..."

SUPPORT_DIR=~/swork/browser-support

mkdir -p $SUPPORT_DIR
cd $SUPPORT_DIR

echo "Fetching qtbase..."
git clone git://gitorious.org/qt/qt5.git qt5
cd qt5
git checkout 90f7cf110710bb59c2993d6d1848223baeb9642b
./init-repository --module-subset=qtbase,qtxmlpatterns,qtscript,qtdeclarative
cd qtdeclarative && git fetch http://codereview.qt-project.org/p/qt/qtdeclarative refs/changes/17/7617/1 && git cherry-pick FETCH_HEAD

cd $SUPPORT_DIR

echo "Fetching webkit..."
git clone git://gitorious.org/webkit/webkit.git

echo "Done"


