script_path=$(dirname "$(realpath -s "$0")")
echo "Script directory is $script_path"

### dependencies #####
#Installed like this because the for loop wasnt working :)
sudo apt-get install -y alsa-utils
sudo apt-get install -y cmake
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libusb-1.0-0-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y libprotobuf-dev
sudo apt-get install -y protobuf-c-compiler
sudo apt-get install -y protobuf-compiler
sudo apt-get install -y libqt5multimedia5
sudo apt-get install -y libqt5multimedia5-plugins
sudo apt-get install -y libqt5multimediawidgets5
sudo apt-get install -y qtmultimedia5-dev
sudo apt-get install -y libqt5bluetooth5
sudo apt-get install -y libqt5bluetooth5-bin
sudo apt-get install -y qtconnectivity5-dev
sudo apt-get install -y pulseaudio
sudo apt-get install -y pulseaudio-module-bluetooth
sudo apt-get install -y librtaudio-dev
sudo apt-get install -y librtaudio6
sudo apt-get install -y qml-module-qtquick2
sudo apt-get install -y libglib2.0-dev
sudo apt-get install -y libgstreamer1.0-dev
sudo apt-get install -y gstreamer1.0-plugins-base-apps
sudo apt-get install -y gstreamer1.0-plugins-bad
sudo apt-get install -y gstreamer1.0-libav
sudo apt-get install -y gstreamer1.0-alsa
sudo apt-get install -y libgstreamer-plugins-base1.0-dev
sudo apt-get install -y qtdeclarative5-dev
sudo apt-get install -y libgstreamer-plugins-bad1.0-dev
sudo apt-get install -y libunwind-dev
sudo apt-get install -y qml-module-qtmultimedia
sudo apt-get install -y libqt5serialbus5-dev
sudo apt-get install -y libqt5serialbus5-plugins
sudo apt-get install -y libqt5serialport5-dev
sudo apt-get install -y libqt5websockets5-dev
sudo apt-get install -y libqt5svg5-dev
sudo apt-get install -y build-essential
sudo apt-get install -y libtool
sudo apt-get install -y autoconf
sudo apt-get install -y ffmpeg

################### AASKD ########################

sudo apt-get update
sudo apt-get -y install cmake build-essential git


git clone https://github.com/OpenDsh/aasdk

cd aasdk

git apply $script_path/patches/aasdk_openssl-fips-fix.patch

mkdir build
cd build

cmake -DCMAKE_BUILD_TYPE=Release ../
make -j2
sudo make install

echo AASDK installed

#################### Openauto ###################################
cd $script_path

echo starting Openauto install

sudo apt-get -y install cmake build-essential git

git clone https://github.com/OpenDsh/openauto

mkdir openauto_build
cd openauto_build

cmake -DCMAKE_BUILD_TYPE=Release -DRPI3_BUILD=TRUE -DAASDK_INCLUDE_DIRS="../aasdk/include" -DAASDK_LIBRARIES="../aasdk/lib/libaasdk.so" -DAASDK_PROTO_INCLUDE_DIRS="../aasdk" -DAASDK_PROTO_LIBRARIES="../aasdk/lib/libaasdk_proto.so" ../openauto

make -j2

sudo make install

echo Install Finished
