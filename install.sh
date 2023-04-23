echo "IMSI-catcher install script"
echo "Updating package list"
sudo apt update 

echo "Installing git"
sudo apt install git -y

echo "Installing libraries for IMSI-catcher"
sudo apt install python3-numpy python3-scipy python3-scapy -y

echo "Cloning IMSI-catcher"
git clone https://github.com/Oros42/IMSI-catcher.git

echo "Installing gr-gsm"
sudo apt install gr-gsm -y

echo "Installing kalibrate-hackrf"

echo "Installing libraries for kalibrate-hackrf"
sudo apt install automake autoconf libhackrf-dev build-essential -y

echo "Cloning kalibrate-hackrf repository"
git clone https://github.com/scateu/kalibrate-hackrf

echo "bootstraping"
cd kalibrate-hackrf/
./bootstrap

echo "configuring"
./configure

echo "making"
make

echo "making install"
sudo make install
