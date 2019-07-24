echo "::::::::::::::::::[SETUP ANDROID]::::::::::::::::::"
androidBuildToolsVersion="28.0.3"
androidPlatformVerion="android-28"

echo "==> [BREW DOCTOR]"
brew doctor

echo "==> [BREW UPDATE]"
brew update

echo "==> [INSTALLING JAVA 8]"
brew cask install homebrew/cask-versions/java8
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

echo "==> [INSTALLING ANDROID SDK]"
brew cask install android-sdk
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
mkdir -p "$ANDROID_SDK_ROOT/licenses"

echo "==> [INSTALLING ANDROID NDK]"
brew cask install android-ndk
export ANDROID_NDK_HOME="/usr/local/share/android-ndk"

echo "==> [SDK-MANAGER UPDATE]"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --update
${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"