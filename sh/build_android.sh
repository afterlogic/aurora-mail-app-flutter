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
ApkOutput="build/${PackageName}.${Version}+${Build}.apk"

printf "${BG_G} Building ${PackageName} ${NC}\n"

printf "\n${W}Do you want to install the app on a device? [y/N]: ${NC}"
read -r InstallChoice

SelectedDevice=""
if [[ "$InstallChoice" =~ ^[yY]$ ]]; then
    mapfile -t Devices < <(adb devices | grep -w "device$" | awk '{print $1}')

    if [ ${#Devices[@]} -eq 0 ]; then
        printf "${R} No devices found. Connect a device and try again.${NC}\n"
        exit 1
    fi

    printf "\n${W}Available devices:${NC}\n"
    for i in "${!Devices[@]}"; do
        Model=$(adb -s "${Devices[$i]}" shell getprop ro.product.model 2>/dev/null | tr -d '\r')
        printf "  ${G}[%d]${NC} %s (%s)\n" "$((i + 1))" "${Devices[$i]}" "${Model}"
    done

    if [ ${#Devices[@]} -gt 1 ]; then
        printf "\n${W}Select device [1-${#Devices[@]}]: ${NC}"
        read -r DeviceIndex
    else
        DeviceIndex=1
    fi

    if ! [[ "$DeviceIndex" =~ ^[0-9]+$ ]] || [ "$DeviceIndex" -lt 1 ] || [ "$DeviceIndex" -gt "${#Devices[@]}" ]; then
        printf "${R} Invalid selection.${NC}\n"
        exit 1
    fi

    SelectedDevice="${Devices[$((DeviceIndex - 1))]}"
    printf "${Y} Will install on ${SelectedDevice} after build.${NC}\n"
fi

if [ "$1" = "apk" ] || [ "$1" = "" ]; then
    printf "\n${Y} Building apk ${NC}\n";

    flutter build apk

    if test -f "$ApkFile"; then
        printf "${Y} Moving .apk to the output dir ${NC}\n"
        mv $ApkFile $ApkOutput
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

if [ -n "$SelectedDevice" ]; then
    printf "\n${Y} Installing on ${SelectedDevice}... ${NC}\n"

    if test -f "$ApkOutput"; then
        adb -s "$SelectedDevice" install -r "$ApkOutput"
        if [ $? -eq 0 ]; then
            printf "${G} Successfully installed! ${NC}\n"
        else
            printf "${R} Installation failed! ${NC}\n"
        fi
    else
        printf "${R} APK file not found: ${ApkOutput}${NC}\n"
    fi
fi
