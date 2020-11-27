#!/usr/bin/env bash

set -Eeuo pipefail
set -x

declare -r \
	tests_dir="/tests" \
	openshift_install="$1"

for testcase in ${tests_dir}/* ; do
	if [ -d $testcase ]; then
		declare -r assets_dir="$(mktemp -d)"
		ln -s "$(realpath "${testcase}/install-config.yaml")" "${assets_dir}/install-config.yaml"
		"$openshift_install" create manifests --dir "$assets_dir"
		for t in ${testcase}/*.sh; do
			$t "$assets_dir" #TODO: grab the exit code
		done
	fi
done
