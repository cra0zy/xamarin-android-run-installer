#!/bin/bash

rm -rf tmp
mkdir tmp
cd tmp

if [ ! -f ../XAL.zip ]
then
	echo "Downloading Xamarin.Android from:"
	echo "https://jenkins.mono-project.com/view/Xamarin.Android/job/xamarin-android-linux/lastSuccessfulBuild/Azure/"
	echo "and place the file in the current directory with the name 'XAL.zip'"
	exit
fi

echo "Extracting Xamarin.Android..."
unzip ../XAL.zip -d XAL

exit

echo "Copying installer data..."
cp -rf XAL/*/bin/Release/ mono-android/
cp -rf ../src/. .

rm XAL.zip
rm -rf XAL
cd ..

echo "Building the installer..."
rm -rf bin
mkdir bin
./makeself/makeself.sh --keep-umask  tmp/ bin/xamarin-android.run "Xamarin.Android .run installer" ./postinstall.sh

echo "Cleaning up..."
rm -rf tmp

echo "Done :)"
