#!/bin/bash

link_opt=$1 # dynamic or static
mt_opt=$2 #	md or mt

opt=""

if [ "$link_opt" == "static" ]; then
	opt="static"
	link_opt="static"
else
	opt=""
	link_opt="dynamic"
fi
if [ "$mt_opt" == "md" ]; then
	sed -i "s;/MT;/MD;g" src/msvcbuild.bat
	mt_opt="md"
else
	mt_opt="mt"
fi

out=build_${link_opt}_${mt_opt}
echo '$opt : '${opt}
echo '$out : '${out}

cd "$(dirname "$0")"
pwd
rm -rf build_*
mkdir -p ${out}
cd src
cmd.exe /c msvcbuild.bat ${opt}
cp -rf lua51.lib luajit.lib luajit.exe lua51.dll include include ../${out}
cd ..
z a ${out}.7z ${out}/*
