#!/bin/bash

cd "$(dirname "$0")"
rm -rf build*
mkdir -p build_dynamic_mt build_static_mt build_dynamic_md build_static_md

cd src
call msvcbuild.bat
cp -rf lua51.lib luajit.lib luajit.exe lua51.dll include include ../build_dynamic_mt
call msvcbuild.bat static
cp -rf lua51.lib luajit.lib luajit.exe lua51.dll include include ../build_static_mt
sed -i "s;/MT;/MD;g" msvcbuild.bat
call msvcbuild.bat
cp -rf lua51.lib luajit.lib luajit.exe lua51.dll include include ../build_dynamic_md
call msvcbuild.bat static
cp -rf lua51.lib luajit.lib luajit.exe lua51.dll include include ../build_static_md
cd ..

7z a build_dynamic_mt.7z build_dynamic_mt/*
7z a build_static_mt.7z  build_static_mt/*
7z a build_dynamic_md.7z build_dynamic_md/*
7z a build_static_md.7z  build_static_md/*
