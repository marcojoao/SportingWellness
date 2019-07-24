echo "::::::::::::::::::[SETUP ANDROID]::::::::::::::::::"

androidBuildToolsVersion="28.0.3"
androidPlatformVerion="android-28"

echo "@ ===> Brew Doctor"
brew doctor

echo "@ ===> Brew update"
brew update

echo "@ ===> Installing Java 8"
brew cask install caskroom/versions/java8
export JAVA_HOME=$(/usr/libexec/java_home)

echo "@ ===> Installing Android SDK"
brew cask install android-sdk
#export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
export ANDROID_HOME="/usr/local/opt/android-sdk"


echo "@ ===> Installing Android NDK"
brew cask install android-ndk
#export ANDROID_NDK_HOME="/usr/local/share/android-ndk"
export ANDROID_NDK_HOME="/usr/local/opt/android-ndk"

echo "===> Executing SDK Manager"
yes y | ${ANDROID_HOME}/tools/bin/sdkmanager --update
${ANDROID_HOME}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"