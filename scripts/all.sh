#!/bin/sh
#
set -e
#############################
#######CONFIGURE HERE########
#############################
export INSTALL_DIR=$HOME/apps/qgis-mobile/libs
export SRC_DIR=$HOME/dev/qgis-mobile/libs
export NDK=$HOME/necessitas/android-ndk-r5b
#############################
#######END CONFIGURE#########
#############################
#
echo "Downloading src to: " $SRC_DIR
echo "Installing to: " $INSTALL_DIR
echo "NDK location: " $NDK
#
CONTINUE=n
echo "OK? [y, n*]:"
read CONTINUE
CONTINUE=$(echo $CONTINUE | tr "[:lower:]" "[:upper:]")
if [ "$CONTINUE" = "Y" ]; then
continue
else
echo "Abort"
exit
fi

export NDK_PLATFORM=$NDK/platforms/android-4/arch-arm
cd $SRC_DIR
mkdir -p tmp
#Get Updated config.sub
wget "http://git.savannah.gnu.org/gitweb/?p=autoconf.git;a=blob_plain;f=build-aux/config.sub;hb=7420ce3483ec7d50de0667ec03b86be143f72c52" -O tmp/config.sub
#detect cpu cores
CORES=$(cat /proc/cpuinfo | grep processor | wc -l)

#FIXME
#diff $NDK_PLATFORM/usr/include/sys/types.h.orig $NDK_PLATFORM/usr/include/sys/types.h
#124c124
#< typedef uint64_t       u_int64_t;
#---
#
#> //typedef uint64_t       u_int64_t;

#PROJ4
./proj-4.7.0.sh
#END PROJ4
#GEOS3.2.2
./geos-3.2.2.sh
#END GEOS3.2.2
