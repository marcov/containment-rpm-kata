#!/usr/bin/env bash
set -eo pipefail

readonly rootfsDir="$1"
readonly targetImg="$2"
readonly script_dir="$(dirname $(readlink -f $0))"

source ${script_dir}/kata-osbuilder/scripts/lib.sh

echo "Creating kata image $targetImg from $rootfsDir"
create_summary_file "$rootfsDir"

# Create /sbin/init if it does not exist
[ -e "${rootfsDir}/sbin/init" ] || ln -s /usr/lib/systemd/systemd ${rootfsDir}/sbin/init
# Create /lib/systemd/systemd if it does not exist
[ -e "${rootfsDir}/lib/systemd/systemd" ] || { mkdir -p ${rootfsDir}/lib/systemd/; ln -s /usr/lib/systemd/systemd ${rootfsDir}/lib/systemd/systemd; }

${script_dir}/kata-osbuilder/image-builder/image_builder.sh -o "$targetImg" "$rootfsDir"

