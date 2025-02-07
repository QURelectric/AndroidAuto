script_path=$(dirname "$(realpath -s "$0")")
echo "Script directory is $script_path"


##### INSTALL AASDK #####

sudo apt-get update
sudo apt-get -y install cmake build-essential git

sudo apt-get install -y protobuf-compiler libprotobuf-dev libusb-1.0.0-dev libssl-dev libboost-dev libboost-system-dev libboost-log-dev

git clone https://github.com/OpenDsh/aasdk
# OPENSSL FIPS PATCH #
cd aasdk

git apply $script_path/aasdk_openssl_fips.patch

cmake -DCMAKE_BUILD_TYPE=Release .
make -j2
sudo make install

#### INSTALL H264Bitstream #####

#change to project root
cd $script_path
#clone h264bitstream
git clone $h264bitstreamRepo
if [[ $? -eq 0 ]]; then
  echo -e h264bitstream Cloned ok '\n'
else
  cd h264bitstream
  if [[ $? -eq 0 ]]; then
    git pull $h264bitstreamRepo
    echo -e h264bitstream Cloned OK '\n'
    cd ..
  else
    echo h264bitstream clone/pull error
    exit 1
  fi
fi

#change into folder
echo -e moving to h264bitstream '\n'
cd h264bitstream

echo Auto-reconfigure project
autoreconf -i

if [[ $? -eq 0 ]]; then
  echo -e autoreconfed h264bitstream
else
  echo Unable to autoreconf h264bitstream
  exit 1
fi
 echo Configuring h264bitstream
 ./configure --prefix=/usr/local
  if [[ $? -eq 0 ]]; then
    echo -e h264bitstream configured successfully'\n'
  else
    echo h264bitstream configure failed with code $?
  exit 1
  fi

  #beginning make
  make

  if [[ $? -eq 0 ]]; then
    echo -e h264bitstream Make completed successfully '\n'
  else
    echo h264bitstream Make failed with code $?
    exit 1
  fi

  #begin make install
  sudo make install

  if [[ $? -eq 0 ]]
    then
    echo -e h264bitstream installed ok'\n'
    echo
  else
    echo h264bitstream install failed with code $?
    exit 1
  fi
fi

#### INSTALL OPENAUTO #####

cd ..

sudo apt-get -y install cmake build-essential git

sudo apt-get install -y libboost-all-dev libusb-1.0.0-dev libssl-dev cmake libprotobuf-dev protobuf-c-compiler protobuf-compiler libqt5multimedia5 
sudo apt-get install -y libqt5multimedia5-plugins libqt5multimediawidgets5 qtmultimedia5-dev libqt5bluetooth5 libqt5bluetooth5-bin qtconnectivity5-dev
sudo apt-get install -y qtdeclarative5-dev qtbase5-dev pulseaudio librtaudio-dev

git clone https://github.com/OpenDsh/openauto

mkdir openauto_build
cd openauto_build

cmake -DCMAKE_BUILD_TYPE=Release -DRPI3_BUILD=TRUE -DAASDK_INCLUDE_DIRS="../aasdk/include" -DAASDK_LIBRARIES="../aasdk/lib/libaasdk.so" -DAASDK_PROTO_INCLUDE_DIRS="../aasdk" -DAASDK_PROTO_LIBRARIES="../aasdk/lib/libaasdk_proto.so" ../openauto

make
sudo make install

###### check and add usb rules for openauto #####
echo Checking if permissions exist
  #udev rule to be created below, change as needed
  FILE=/etc/udev/rules.d/51-dashusb.rules
  if [[ ! -f "$FILE" ]]; then
    # OPEN USB RULE, CREATE MORE SECURE RULE IF REQUIRED
    echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"*\", ATTR{idProduct}==\"*\", MODE=\"0660\", GROUP=\"plugdev\"" | sudo tee $FILE
    if [[ $? -eq 0 ]]; then
      echo -e Permissions created'\n'
    else
      echo -e Unable to create permissions'\n'
    fi
    else
      echo -e Rules exists'\n'
  fi

  echo INSTALLATION FINISHED
