androidBuildToolsVersion="28.0.3"
androidPlatformVerion="android-28"

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