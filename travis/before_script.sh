Changeset=fc1d3344e6ea
version=2017.3.1f1
androidBuildToolsVersion="25.0.2"
androidPlatformVerion="android-23"

echo "executing: brew update"
brew update

echo "executing: brew cask install caskroom/versions/java8"
brew cask install caskroom/versions/java8
echo "executing: export JAVA_HOME=$(/usr/libexec/java_home)"
export JAVA_HOME=$(/usr/libexec/java_home)

echo "executing: brew cask install android-sdk"
brew cask install android-sdk
echo "executing: export ANDROID_SDK_ROOT=\"/usr/local/share/android-sdk\""
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

echo "executing: brew cask install android-ndk"
brew cask install android-ndk
echo "executing: export ANDROID_NDK_HOME=\"/usr/local/share/android-ndk\""
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"

echo "executing: sdkmanager --update"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --update
echo "executing: sdkmanager \"build-tools;${androidBuildToolsVersion}\" \"platform-tools\" \"platforms;${androidPlatformVerion}\""
${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"

echo "Downloading from http://download.unity3d.com/download_unity/${Changeset}/MacEditorInstaller/Unity.pkg: "
curl -o Unity.pkg http://download.unity3d.com/download_unity/${Changeset}/MacEditorInstaller/Unity.pkg
sudo installer -dumplog -package Unity.pkg -target /

echo "Downloading from http://download.unity3d.com/download_unity/${Changeset}/MacStandardAssetsInstaller/StandardAssets.pkg: "
curl -o StandardAssets.pkg http://download.unity3d.com/download_unity/${Changeset}/MacStandardAssetsInstaller/StandardAssets.pkg
sudo installer -dumplog -package StandardAssets.pkg -target /

echo "Downloading from http://download.unity3d.com/download_unity/${Changeset}/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-${version}.pkg: "
curl -o UnitySetup-Android-Support-for-Editor-${version}.pkg http://download.unity3d.com/download_unity/${Changeset}/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-${version}.pkg
sudo installer -dumplog -package UnitySetup-Android-Support-for-Editor-${version}.pkg -target /

ls -la /Applications/Unity/PlaybackEngines/AndroidPlayer/