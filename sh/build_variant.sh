#!/bin/bash

RED='\033[1;31m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
NC='\033[0m' # No Color

if [ -f "$1" ]; then
    flutter pub get
    flutter pub run build_variant $1
    flutter pub get
    flutter pub run flutter_launcher_icons:main
else
    printf $RED"No build_variant.yaml file is found. Abborting.\n"$NC
fi