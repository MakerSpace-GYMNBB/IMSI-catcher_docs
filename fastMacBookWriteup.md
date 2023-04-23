# Use IMSI-catcher on MacOS via UTM
This is a writeup, about how to use the IMSI-catcher by Oros42 with an HackRF One on MacOS, via a debian VM via UTM. Huge thanks to Oros42, for the amazing software. Another huge thanks to Osmocom, velichkov and ptrkrysik for the gr-gsm software. Another huge thanks to Wang Kang / scateu for his 
kalibrate-hackrf tool. Tanks to the UTM Team, for developing such an amazing tool for using VMs on MacOS, IOS..., which even works with the M1 Chip.

IMSI-catcher by Oros42: https://github.com/Oros42/IMSI-catcher

Gr-gsm by Osmocom, ptrkrysik and velichkov: https://osmocom.org/projects/gr-gsm/wiki/Installation, https://github.com/velichkov/gr-gsm

kalibrate-hackrf by Wang Kang / scateu: https://github.com/scateu/kalibrate-hackrf

UTM: https://mac.getutm.app


## Install UTM
UTM is a free software for MacOS which allows You to install and manage VM's, like if You were using VMware oder VirtualBox

### There are several ways to get UTM:
#### 1. Get it from the internet (preferrred):
Download the .dmg file from https://mac.getutm.app

Move it into your program folder

#### 2. Install it using homebrew:
To install hombrew, paste this command into your terminal and execute it. Follow the instructions of the installer

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

When the installation has finished, install UTM via the following command
```
brew install --cask utm
```

Utm should now appear in the launchpad

## Get the VM
We will use a Virtual Machine running linux Debian, in which we'll install the IMSI-catcher.

### There are two ways to install the VM
#### 1. Install automatically (preferrred):
Got to the following Site https://mac.getutm.app/gallery/debian-11-ldxe
Press the "Open in UTM" Button
- It'll may ask for permission, if so, grant it.

The VM should now be automatically installed in UTM.

#### 2. Install manually
Got to the following Site https://mac.getutm.app/gallery/debian-11-ldxe

Click the "Download" button

Locate your downloaded file

If you were using Safari skip this step
- Unpack the .zip file by double clicking it

To import the VM, double click the UTM file

If there are any extra instructions follow them!


## First steps
As a reference, i use this writeup, by the author of the software: https://github.com/Oros42/IMSI-catcher
### Start the VM
Open UTM and click the start button next to the VM.

You'll be promted a login form, the standard login for both the username and password is "debian" (I recommend changing the password)

### Change the keyboard layout (optional):
Change UTM into fullscreen mode

Right-click onto the task bar at the bottom of the sreen

Select the second item from the dropdown menu "Add / Remove panel items"

A window should appear

Select the third register entry "Panel Applets"

Click onto the "Add" button with the "+" symbol, on the right

From the menu, select "Keyboard Layout Handler" by double clicking on it or selecting it and clicking the "Add" button

Double Click onto the "Keyboard Layout Handler"

Uncheck the "Keep system layouts" box

To add a new layout, click the add button on the left and select the layout you want

Remove all other layouts, by selecting them one at a time and pressing "Remove"

If you are finished, press "Close"

Also close the "Panel Preferences" window by pressing "x" at the top, right of the window


### Open terminal
Open a terminal by pressing the start symbol at the bottom left.

Select "System Tools" > "LXTerminal"

### Update and upgrade the system
In the terminal type
```
sudo apt update && sudo apt full-upgrade -y
```

Wait for the system to upgrade all the packages.
If it should ask about restarting services, just press enter AND maybee follow instructions on the screen

## Install the IMSI-catcher

### Automatic way (recommendet)
Open a terminal and execute the following commands:
```
curl https://raw.githubusercontent.com/MakerSpace-GYMNBB/IMSI-catcher_docs/main/install.sh --output install.sh
sudo chmod u+rwx install.sh
./install.sh
```


### Second way
Open a terminal

Install git via the terminal
```
sudo apt update && sudo apt install git -y
```

Install IMSI-catcher
```
git clone https://github.com/Oros42/IMSI-catcher.git
```

```
sudo apt install python3-numpy python3-scipy python3-scapy -y
```


Install gr-gsm
```
sudo apt install gr-gsm -y
```

Install kalibrate-hackrf
```
sudo apt-get install automake autoconf libhackrf-dev build-essential -y
git clone https://github.com/scateu/kalibrate-hackrf
cd kalibrate-hackrf/
./bootstrap
./configure
make
sudo make install
```

## Usage
We will use kalibrate hackrf to find GSM900 frequencies,

grgsm_livemon to listen to those frequencies and get the raw packets and

use the IMSI-catcher to decode the gsm data

### Connect HackRF
Connect your HackRF One to the MacBook

UTM should now ask for permission, to accces the device

Grant UTM the permission

### Find GSM900 frequencies
To find GSM900 frequencies, we will use the "kalibrate-hackrf" tool

Open a terminal

In the Terminal type
```
kal -s GSM900
```
Wait for it to complete, this could take a while

The output should look something like this:
```
kal: Scanning for GSM-900 base stations.
GSM-900:
	chan:   14 (937.8MHz + 10.449kHz)	power: 3327428.82
	chan:   15 (938.0MHz + 4.662kHz)	power: 3190712.41
...
```

### Receive gsm data
Open a terminal and type
```
grgsm_livemon
```



A window should appear, in the findow change the frequency, until it displays something like this in the terminal
```
15 06 21 00 01 f0 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b
25 06 21 00 05 f4 f8 68 03 26 23 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b 2b
49 06 1b 95 cc 02 f8 02 01 9c c8 03 1e 57 a5 01 79 00 00 1c 13 2b 2b

```

### View GSM data
Open a second/third terminal

Go to the folder, where you cloned the IMSI-catcher git repository, in most cases this will likely be the home folder

So type the following into the terminal:
```
cd IMSI-catcher/
```

To start the viewer, type the following into the terminal:
```
sudo python3 simple_IMSI-catcher.py -s

```

You should now see the IMSI and other data like country, provider, cell id...
