#!/bin/bash

export JAVA_HOME=~/android/jdk1.6.0_33

export PATH=${JAVA_HOME}:$PATH

function check_rom_manager {
	if ! test -f vendor/cyanogen/proprietary/RomManager.apk; then
        	vendor/cyanogen/get-rommanager
	fi
	}
export -f check_rom_manager

vendor_path=vendor/mrom

if ! test -d $vendor_path/scripts; then
	echo "script must be executed from repo root"
	exit
fi

check_rom_manager

if ! diff vendor/mrom/build/buildspec.mk build/buildspec.mk; then
	cp vendor/mrom/build/buildspec.mk build/buildspec.mk
fi

if ! diff vendor/mrom/build/core/build_id.mk build/core/build_id.mk; then
	cp vendor/mrom/build/core/build_id.mk build/core/build_id.mk
fi

export CM_BUILDTYPE=EXPERIMENTAL

if [ "$1" == "" ]; then
	echo "echo $0 {device}"
	exit
fi

device=$1

. build/envsetup.sh

brunch $device

