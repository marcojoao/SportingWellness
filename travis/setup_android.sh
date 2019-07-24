echo "::::::::::::::::::[SETUP ANDROID]::::::::::::::::::"
androidBuildToolsVersion="28.0.3"
androidPlatformVerion="android-28"

echo "==> [BREW DOCTOR]"
brew doctor

echo "==> [BREW UPDATE]"
brew update

#echo "==> [INSTALLING JAVA 8]"
#curl -O "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u222-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u222b10.tar.gz"
#tar -xf "OpenJDK8U-jdk_x64_mac_hotspot_8u222b10.tar.gz"
#ls -la
#export PATH=$PWD/jdk8u222-b10/Contents/Home/bin:$PATH
java -version
#export JAVA_HOME=$(/Library/Java/JavaVirtualMachines/jdk8u222-b10/Contents/Home)
#export JAVA_HOME=$(/usr/bin/java)

echo "==> [INSTALLING ANDROID SDK]"
brew cask install android-sdk
export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
mkdir -p "$ANDROID_SDK_ROOT/licenses"

#echo "==> [INSTALLING ANDROID NDK]"
#brew cask install android-ndk
#export ANDROID_NDK_HOME="/usr/local/share/android-ndk"

echo "==> [SDK-MANAGER LIST]"
export SDKMANAGER_OPTS="--add-modules java.se.ee"
${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --list

echo "==> [SDK-MANAGER UPDATE]"
yes y | ${ANDROID_SDK_ROOT}/tools/bin/sdkmanager --update
${ANDROID_SDK_ROOT}/tools/bin/sdkmanager "build-tools;${androidBuildToolsVersion}" "platform-tools" "platforms;${androidPlatformVerion}"