#!/bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

if [ -f "$1" ]; then
    fvm flutter pub get
    fvm flutter pub run build_variant $1
    fvm flutter pub get
		fvm flutter pub run intl_utils:generate
    fvm flutter pub run flutter_launcher_icons
else
    printf $RED"No build_variant.yaml file is found. Aborting.\n"$NC
fi