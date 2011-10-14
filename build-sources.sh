#!/bin/sh

d=`dirname $0`
. $d/common.sh

set -e

echo "Building Qt5..."

SUPPORT_DIR=~/swork/browser-support

BUILDDIR=$SUPPORT_DIR/build-$build_suffix
QT5_BUILDDIR=$BUILDDIR/qt5

mkdir -p $QT5_BUILDDIR
cd $QT5_BUILDDIR

$SUPPORT_DIR/qtbase/configure -nomake demos -nomake examples -nomake tests -nokia-developer -fast && make $makeargs
QTDIR=$QT5_BUILDDIR
PATH=$QT5_BUILDDIR/bin:$PATH

mkdir -p $QT5_BUILDDIR/qtdeclarative && cd $QT5_BUILDDIR/qtdeclarative && qmake $SUPPORT_DIR/qtdeclarative && make $makeargs && make install

if [ $? -ne 0 ] ; then
echo Aborting build.
exit 1
fi


mkdir -p $QT5_BUILDDIR/qtscript && cd $QT5_BUILDDIR/qtscript && qmake $SUPPORT_DIR/qtscript && make $makeargs && make install

if [ $? -ne 0 ] ; then
echo Aborting build.
exit 1
fi


mkdir -p $QT5_BUILDDIR/qtsvg && cd $QT5_BUILDDIR/qtsvg && qmake $QT5_SUPPORT_DIR/qtsvg && make $makeargs && make install

if [ $? -ne 0 ] ; then
echo Aborting build.
exit 1
fi

echo
echo Build Completed, run the following to use your new Qt build:
echo export PATH=$QT5_BUILDDIR/bin:\$PATH

echo "Done"


