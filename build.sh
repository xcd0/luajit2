#!/bin/bash

link_opt=$1 # dynamic or static
mt_opt=$2 #  md or mt

opt=""

if [ "$link_opt" == "static" ]; then
  opt="static"
  link_opt="static"
else
  link_opt="dynamic"
fi
if [ "$mt_opt" == "md" ]; then
  sed -i "s;/MT;/MD;g" src/msvcbuild.bat
else
  mt_opt="mt"
fi

cd "$(dirname "$0")"
pwd
rm -rf build_*
mkdir -p build_${link_opt}_${mt_opt}

cd src

cmd.exe /c msvcbuild.bat $opt
cp -rf lua51.lib luajit.lib luajit.exe lua51.dll include include ../build_${link_opt}_${mt_opt}
cd ..
z a build_${link_opt}_${mt_opt}.7z build_${link_opt}_${mt_opt}/*
