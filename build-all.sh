#!/usr/bin/env bash

# List of ABIs to build
ABIS=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")

# For each ABI, configure and build the JNI shared library
for ABI in "${ABIS[@]}"; do
    echo "============================================="
    echo "Building for ABI: $ABI"
    echo "============================================="

    cmake -S . -B "build/android-$ABI" \
           -DCMAKE_BUILD_TYPE="Release" \
           -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake" \
           -DANDROID_ABI="$ABI" \
           -DANDROID_PLATFORM="android-21" \
           -DANDROID_STL=c++_static \
           -DJNI=ON \
           -DWITH_BENCHMARK_TOOLS=OFF \
           -DWITH_CORE_TOOLS=OFF \
           -DWITH_GFLAGS=OFF \
           -DWITH_TESTS=OFF \
           -DFAIL_ON_WARNINGS=OFF \
           -DCMAKE_POLICY_VERSION_MINIMUM=3.5

    cmake --build "build/android-$ABI" --target rocksdbjni-shared --parallel "$(nproc)"
done