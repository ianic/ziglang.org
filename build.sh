#!/bin/bash
set -e
cd $(git rev-parse --show-toplevel)
root=$(pwd)

zig0151=~/.build/zig/zig-x86_64-linux-0.15.1/zig

if [ ! -f $zig0151 ]; then
    echo missing path to zig 0.15.1, needed to build www.ziglang.org
    exit 1
fi

cd ..
# Get and build Zig site.
# Static site is in www.ziglang.org/zig-out after build.
if [ ! -d "www.ziglang.org" ]; then
    git clone git@github.com:ziglang/www.ziglang.org.git
    cd www.ziglang.org
    $zig0151 build
    cd ..
fi

cd $root
cp -r ../www.ziglang.org/zig-out/* .
