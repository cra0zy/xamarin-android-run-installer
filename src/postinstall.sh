#!/bin/bash

if [ "$(id -u)" != "0" ]
then
	echo "Please make sure you are running this installer with sudo or as root." 1>&2
	exit 1
fi

if type "xamarin-android-uninstall" > /dev/null 2>&1
then
	echo "Previous version detected, uninstalling..."
	xamarin-android-uninstall
fi

echo "Copying Xamarin.Android binaries..."
cp -rf mono-android/ /opt/mono-android/
ln -s /opt/mono-android/lib/xamarin.android/xbuild/Xamarin/ /usr/lib/mono/xbuild/Xamarin
ln -s /opt/mono-android/lib/xamarin.android/xbuild/Novell/ /usr/lib/mono/xbuild/Novell
ln -s /opt/mono-android/lib/xamarin.android/xbuild-frameworks/MonoAndroid/ /usr/lib/mono/xbuild-frameworks/MonoAndroid

echo "Adding terminal commands..."
cp xamarin-android-uninstall /usr/bin/xamarin-android-uninstall
chmod +x /usr/bin/xamarin-android-uninstall
