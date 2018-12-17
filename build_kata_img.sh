#!/usr/bin/env bash
set -eo pipefail

readonly rootfsDir="$1"
readonly targetImg="$2"
readonly script_dir="$(dirname $(readlink -f $0))"

echo "Creating kata image $targetImg from $rootfsDir"

# TODO: consider retrieve variables calling rootfs.sh
gen_summary() {
	local OSBUILDER_VERSION=$(rpm -q kata-osbuilder)
	local AGENT_INIT="no"
	local AGENT_BIN="kata-agent"
	local AGENT_DEST="${rootfsDir}/usr/bin/${AGENT_BIN}"
	local ARCH="$(arch)"
	local GO_AGENT_PKG="github.com/kata-containers/agent"
	local OS_VERSION="(built with kiwi)"
	local OS_NAME="openSUSE"
	source ${script_dir}/kata-osbuilder/scripts/lib.sh
	create_summary_file "$rootfsDir"
}
gen_summary

# Create /sbin/init if it does not exist
[ -e "${rootfsDir}/sbin/init" ] || ln -s /usr/lib/systemd/systemd ${rootfsDir}/sbin/init
# Create /lib/systemd/systemd if it does not exist
[ -e "${rootfsDir}/lib/systemd/systemd" ] || { mkdir -p ${rootfsDir}/lib/systemd/; ln -s /usr/lib/systemd/systemd ${rootfsDir}/lib/systemd/systemd; }

${script_dir}/kata-osbuilder/image-builder/image_builder.sh -o "$targetImg" "$rootfsDir"

