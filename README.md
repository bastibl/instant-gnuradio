# Instant GNU Radio

## Dependencies

```bash
sudo apt install packer
sudo apt install virtualbox virtualbox-ext-packer
```

On Ubuntu, your user should be in the `vboxusers` group.

``` bash
sudo usermod -a -G vboxusers <your username>
```

You have to logout and login again for the changes to take effect.

GitHub doesn't allow uploading files over 100Mb and, therefore, prevents adding the OpenCL runtime to the repo.
Please download the runtime and put it into the `assets` folder.

http://registrationcenter-download.intel.com/akdlm/irc_nas/12513/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz


## Create Image

You have to be online.

``` bash
packer build instant-gnuradio-base.json
packer build instant-gnuradio.json
```

## Main Features

- OVA VM appliance can be imported in all main virtualization solutions or `dd`ed on a USB drive
- Based on Ubuntu 17.10 w/ GNOME 3.
- Two step build process: first create a base image, then extend it with SDR stuff.
- Easy to brand for your own courses/workshops. For example, just replace the wallpaper in the `assets` folder.
- Software: GNU Radio, GQRX, gr-ieee-***, ...
- Fosphor support!
- Hardware: HackRF, RTL-SDR, UHD; properly setup with udev rules and downloaded images.
- Productivit: VIM and Spacemacs (plugins alread downloaded and ready for offline use).
- Favorite applications (in the sidebar) are set to GNU Radio Companion, GQRX, GNU Radio Wiki, etc.
- CPU Governors are set to Performance
- No annoying crashreports.
- No screen blanking.
- No `sudo` password.

## Credentials

``` bash
user: gnuradio
password: gnuradio
```

## VirtualBox

### Start VM

Start `virtualbox` and import OVA applicane from `vms/instant-gnuradio`.

### SSH Login

``` bash
ssh -p2222 gnuradio@localhost
```

Password is `gnuradio`.

You might want to add something like this to your SSH config (`~/.ssh/config`):

``` bash
Host vm
	Hostname localhost
	User gnuradio
	Port 2222
	UserKnownHostsFile /dev/null
	StrictHostKeyChecking no
```

With this config, you can login with `ssh vm` and your password.

## Screenshots
![Screenshot](screen1.png?raw=true)
![Screenshot](screen2.png?raw=true)
![Screenshot](screen3.png?raw=true)
![Screenshot](screen4.png)
