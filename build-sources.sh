#!/bin/sh

set -e

echo "Building Qt5..."

SUPPORT_DIR=~/swork/browser-support

BUILDDIR=$SUPPORT_DIR/build
QT5_BUILDDIR=$BUILDDIR/qt5

mkdir -p $QT5_BUILDDIR
cd $QT5_BUILDDIR

$SUPPORT_DIR/qtbase/configure -nomake demos -nomake examples -nomake tests -nokia-developer -fast && make -j9
QTDIR=$QT5_BUILDDIR
PATH=$QT5_BUILDDIR/bin:$PATH

mkdir -p $QT5_BUILDDIR/qtdeclarative && cd $QT5_BUILDDIR/qtdeclarative && qmake $SUPPORT_DIR/qtdeclarative && make -j9 && make install

if [ $? -ne 0 ] ; then
echo Aborting build.
exit 1
fi


mkdir -p $QT5_BUILDDIR/qtscript && cd $QT5_BUILDDIR/qtscript && qmake $SUPPORT_DIR/qtscript && make -j9 && make install

if [ $? -ne 0 ] ; then
echo Aborting build.
exit 1
fi


mkdir -p $QT5_BUILDDIR/qtsvg && cd $QT5_BUILDDIR/qtsvg && qmake $QT5_SUPPORT_DIR/qtsvg && make -j9 && make install

if [ $? -ne 0 ] ; then
echo Aborting build.
exit 1
fi

echo
echo Build Completed, run the following to use your new Qt build:
echo export PATH=$QT5_BUILDDIR/bin:\$PATH

echo "Done"


