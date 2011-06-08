#GEOS3.2.2
wget http://download.osgeo.org/geos/geos-3.2.2.tar.bz2
tar xjf geos-3.2.2.tar.bz2 
rm geos-3.2.2.tar.bz2
cd geos-3.2.2/
cp -f ../tmp/config.sub ./config.sub

#Patch for http://trac.osgeo.org/geos/ticket/222
wget http://trac.osgeo.org/geos/raw-attachment/ticket/222/geos-3.2.0-ARM.patch -O geos-3.2.0-ARM.bug222.patch
patch -i ../geos-3.2.0-ARM.bug222.patch -p0  

CXX=$NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-g++ \
CXXFLAGS="-nostdlib -I$NDK_PLATFORM/usr/include -I$NDK/sources/cxx-stl/gnu-libstdc++/include -I$NDK/sources/cxx-stl/gnu-libstdc++/libs/armeabi/include -DHAVE_ISNAN" \
CC=$NDK/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc \
CFLAGS="  -nostdlib -I$NDK_PLATFORM/usr/include -I$NDK/sources/cxx-stl/gnu-libstdc++/include -I$NDK/sources/cxx-stl/gnu-libstdc++/libs/armeabi/include" \
LDFLAGS="-L$NDK/sources/cxx-stl/gnu-libstdc++/libs/armeabi -L$NDK_PLATFORM/usr/lib --sysroot=$NDK_PLATFORM -Wl,-rpath-link=$NDK_PLATFORM/usr/lib -lc" \
./configure --prefix=$INSTALL_DIR --host=arm-linux-androideabi

make -j$CORES 2>&1 | tee make.out
#GEOS3.2.2
