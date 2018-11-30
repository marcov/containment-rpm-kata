#!/usr/bin/env bash

set -euo pipefail

readonly rootfsDir="$1"
readonly img="$2"
readonly script_dir="$(dirname $(readlink -f $0))"

echo "Will create some new image from $img in $rootfsDir"
${script_dir}/osbuilder/image-builder/image_builder.sh -o "$img" "$rootfsDir"

