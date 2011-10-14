# common script functionality
# variables exported
#  d = script directory

#  build_suffix= suffix of builddir: [webkit1|]-[armel|i386|host]-[m6]


die() {
    echo "$0: error: $1"
    exit 1
}

is_sbox() {
    if [ -z "$SBOX_UNAME_MACHINE" ]; then
        return 1
    fi
    return 0
}

#default to host m6 build
device_target=${device_target:-"host"}
meego_target="m6"


d=`dirname $0`

if is_sbox; then
    sudo="fakeroot"
    device_target="$SBOX_DPKG_INST_ARCH"
else
    sudo="sudo"
fi

# export DEB_BUILD_OPTIONS=parallel=30 if you want 30 jobs
parallel_jobs=$(echo $DEB_BUILD_OPTIONS | sed -e 's/.*parallel=\([0-9]\+\).*/\1/')
if [ "$parallel_jobs" == "$DEB_BUILD_OPTIONS" ]; then
    parallel_jobs=""
fi

if [ -z "$parallel_jobs" ]; then
    if [ -f /proc/cpuinfo ]; then
        parallel_jobs=$(expr $(grep 'processor' /proc/cpuinfo | wc -l) \* 2 + 1)
    fi
fi
if [ -z "$parallel_jobs" ]; then
    # most people have dual-cores..
    parallel_jobs=3
fi


makeargs=${makeargs:-"-j${parallel_jobs}"}
browser_buildmode=debug
webkit_buildmode=--debug
webkit_buildmodedir=Debug
webkit="qtwebkit-webkit2-dev"
release=
valgrind=
while [ $# -gt 0 ]; do
    case $1 in
        --release)
            release=1
            browser_buildmode=release
            shift
            ;;
        --webkit_release)
            webkit_buildmode=--release
            webkit_buildmodedir=Release
            shift
            ;;
        --m6)
            meego_target="m6"
            shift
            ;;

        --webkit_debug)
            webkit_buildmode=--debug
            shift
            ;;
        *)
            die "unknown flag $1"
            break
            ;;
    esac
done

is_release() {
    if [ -z "$release" ]; then
        return 1
    fi
    return
}

qmake_buildmode="CONFIG+=debug CONFIG-=release"
if is_release; then
    qmake_buildmode="CONFIG+=release CONFIG-=debug"
fi

build_suffix=$device_target-$meego_target



