#!/bin/sh

d=`dirname $0`
. $d/common.sh

set -e

echo "Get the sources..."

cd $shared_dir

if [ -e ${qt5_dir} ]; then
    echo "$qt5_dir already exists, you should probably run update-sources.sh"
else
    git clone git://gitorious.org/qt/qt5.git qt5
    cd qt5
    git checkout 90f7cf110710bb59c2993d6d1848223baeb9642b
    ./init-repository --module-subset=qtbase,qtxmlpatterns,qtscript,qtdeclarative
    cd qtdeclarative && git fetch http://codereview.qt-project.org/p/qt/qtdeclarative refs/changes/17/7617/1 && git cherry-pick FETCH_HEAD
fi

cd $shared_dir

if [ -e ${webkit_dir} ]; then
    echo "$webkit_dir already exists, you should probably run update-sources.sh"
else
    git clone git@gitorious.org:webkit/webkit.git
fi

echo "Done"


