#!/usr/bin/env bash

set -eu

cd $(dirname $0)
BASE_DIR=$(pwd)

source common.sh

if [ ! -e $FFMPEG_TARBALL ]
then
    curl -s -L -O $FFMPEG_TARBALL_URL
fi

BUILD_DIR=$(mktemp -d -p $(pwd) build.XXXXXXXX)
trap 'rm -rf $BUILD_DIR' EXIT

cd $BUILD_DIR
tar --strip-components=1 -xf $BASE_DIR/$FFMPEG_TARBALL

FFMPEG_CONFIGURE_FLAGS+=(
    --target-os=win64
    --toolchain=msvc
    --arch=x86_64
)

# Configure and build static libraries

OUTPUT_DIR=artifacts-static/ffmpeg-$FFMPEG_VERSION-win64-static

./configure --enable-static --disable-shared --prefix=$BASE_DIR/$OUTPUT_DIR "${FFMPEG_CONFIGURE_FLAGS[@]}"
make
make install

chown $(stat -c '%u:%g' $BASE_DIR) -R $BASE_DIR/$OUTPUT_DIR
find $BASE_DIR/$OUTPUT_DIR/lib -name '*.a' -exec rename .a .lib {} +

# Configure and build shared libraries

OUTPUT_DIR=artifacts-shared/ffmpeg-$FFMPEG_VERSION-win64-shared

./configure --enable-shared --disable-static --prefix=$BASE_DIR/$OUTPUT_DIR "${FFMPEG_CONFIGURE_FLAGS[@]}"
make
make install

chown $(stat -c '%u:%g' $BASE_DIR) -R $BASE_DIR/$OUTPUT_DIR
find $BASE_DIR/$OUTPUT_DIR/lib -name '*.a' -exec rename .a .lib {} +
