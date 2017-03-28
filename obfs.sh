#!/bin/bash

# set -x
ROOT=`pwd`
STAGE="$ROOT/obfs_stage"

# Preparing
echo "==> Preparing"
mkdir -p "$STAGE" && cd "$STAGE"
which ffdec 1>/dev/null || exit 2
[[ ! -f ./Core-decode ]] && wget https://raw.githubusercontent.com/yukixz/kctools/master/Core-decode

# Download
echo "==> Downloading"
[[ -f Core.swf ]] && rm Core.swf
wget http://203.104.209.102/kcs/Core.swf

# Decode
echo "==> Decoding"
python3 Core-decode Core.swf Core.dec.swf

# Extract
echo "==> Extracting"
ffdec -cli -export script . Core.dec.swf

# Replace RND
# RND=$(grep "const RND:Array" Core/scripts/common/resources/MapResourceLoader.as | sed -E 's/^.+= //' | sed 's/;//')
# sed -i '' -E "s/(^const RND = ).*/\1${RND}/" map-swf
