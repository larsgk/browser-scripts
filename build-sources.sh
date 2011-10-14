#!/bin/sh

d=`dirname $0`
. $d/common.sh

set -e

echo "Building Qt5..."

SUPPORT_DIR=~/swork/browser-support

QT5_DIR=$SUPPORT_DIR/qt5

if [ "$device_target" == "armel" ]; then
    extra_configure_flags="-platform unsupported/linux-host-g++ -xplatform linux-g++-maemo -force-pkg-config"
fi


cd $QT5_DIR && ./configure -fast -nomake demos -nomake examples -nomake tests -nokia-developer $extra_configure_flags && make $makeargs

QTDIR=$QT5_DIR/qtbase
PATH=$QTDIR/bin:$PATH

echo "Building WebKit2..."

cd $SUPPORT_DIR/webkit

./Tools/Scripts/build-webkit -2 --qt --release --no-3d-canvas --makearg="CONFIG+=use_qt_mobile_theme ${makeargs}"

echo
echo Build Completed, run the following to use your new Qt build:
echo export PATH=$QTDIR/bin:\$PATH

echo "Done"


