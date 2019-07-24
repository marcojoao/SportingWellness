echo "::::::::::::::::::[SETUP ANDROID]::::::::::::::::::"

androidBuildToolsVersion="28.0.3"
androidPlatformVerion="android-28"

brew update

echo "@ ===> Setup Java 8"
brew cask install caskroom/versions/java8
touch ~/.android/repositories.cfg
set JAVA_OPTS=-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee
export JAVA_HOME=$(/usr/libexec/java_home)

echo "@ ===> Setup Android SDK"
brew cask install android-sdk
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"

echo "@ ===> Setup Android NDK"
brew cask install android-ndk
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"

echo "===> Execute SDK Manager"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --update
${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"