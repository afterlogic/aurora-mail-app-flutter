#!/bin/bash

R='\e[1;31m'
Y='\e[1;33m'
G='\e[1;32m'
W='\e[1;37m'
NC='\e[0m' # No Color

BG_R='\e[1;41m'
BG_Y='\e[1;43m'
BG_G='\e[1;42m'

BuildVariables=$(cat android/build_variable.properties)
ApkFile="build/app/outputs/apk/release/app-release.apk"
BundleFile="build/app/outputs/bundle/release/app-release.aab"

PackageName=$(echo "$BuildVariables" | sed -n 's/^packageName=\([^\s]*\)/\1/p')
Version=$(echo "$BuildVariables" | sed -n 's/^flutter\.versionName=\([^\s]*\)/\1/p')
Build=$(echo "$BuildVariables" | sed -n 's/^flutter\.versionCode=\([^\s]*\)/\1/p')

printf "${BG_G} Building ${PackageName} ${NC}\n"

if [ "$1" = "apk" ] || [ "$1" = "" ]; then
    printf "\n${Y} Building apk ${NC}\n";

    flutter build apk

    if test -f "$ApkFile"; then
        printf "${Y} Moving .apk to the output dir ${NC}\n"
        mv $ApkFile build/${PackageName}.${Version}+${Build}.apk
    else
        printf "${R} .apk file not found! ${NC}\n"
    fi
fi

if [ "$1" = "bundle" ] || [ "$1" = "" ]; then
    printf "\n${Y} Building bundle ${NC}\n";

    flutter build appbundle

    if test -f "$BundleFile"; then
        printf "${Y} Moving .aab to the output dir ${NC}\n"
        mv $BundleFile build/${PackageName}.${Version}+${Build}.aab
    else
        printf "${R} .aab file not found! ${NC}\n"
    fi
fi
