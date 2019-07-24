echo "::::::::::::::::::[SETUP ANDROID]::::::::::::::::::"

androidBuildToolsVersion="28.0.3"
androidPlatformVerion="android-28"

brew update

echo "@ ===> Setup Java 8"
brew cask uninstall java
brew tap caskroom/versions
brew cask install java8
touch ~/.android/repositories.cfg
export JAVA_HOME=$(/usr/libexec/java_home)

echo "===> Executing: brew cask install android-sdk"
brew cask install android-sdk
echo "===> Executing:: export ANDROID_SDK_ROOT=\"/usr/local/share/android-sdk\""
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

echo "===> Executing: brew cask install android-ndk"
brew cask install android-ndk
echo "===> Executing: export ANDROID_NDK_HOME=\"/usr/local/share/android-ndk\""
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"

echo "===> Executing: sdkmanager --update"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --update
echo "===> Executing: sdkmanager \"build-tools;${androidBuildToolsVersion}\" \"platform-tools\" \"platforms;${androidPlatformVerion}\""
${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"