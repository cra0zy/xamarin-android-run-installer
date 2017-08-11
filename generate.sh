#!/bin/bash

rm -rf tmp
mkdir tmp
cd tmp

echo "Downloading Xamarin.Android..."
DATA=$(curl https://jenkins.mono-project.com/view/Xamarin.Android/job/xamarin-android-linux/lastSuccessfulBuild/Azure/)
START="processDownloadRequest/xamarin-android/oss"
IFS='"' read -ra ARR <<< "${DATA#*$START}"
URL="https://jenkins.mono-project.com/view/Xamarin.Android/job/xamarin-android-linux/lastSuccessfulBuild/Azure/processDownloadRequest/xamarin-android/oss${ARR[0]}"
wget -O XAL.zip $URL

echo "Extracting Xamarin.Android..."
unzip XAL.zip -d XAL
rm XAL.zip

echo "Copying installer data..."
mv XAL/*/bin/Release/ mono-android/
rm -rf XAL
cp -rf ../src/. .
cd ..

echo "Building the installer..."
rm -rf bin
mkdir bin
./makeself/makeself.sh --keep-umask  tmp/ bin/xamarin-android.run "Xamarin.Android .run installer" ./postinstall.sh

echo "Cleaning up..."
rm -rf tmp

echo "Done :)"
