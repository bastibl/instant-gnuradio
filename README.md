# Instant GNU Radio

GitHub doesn't allow uploading files bigger then 100Mb.
This prevents me from adding the OpenCL runtime to the repo.
Please first download the runtime and put it into the `assets` folder.

http://registrationcenter-download.intel.com/akdlm/irc_nas/12513/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz

## Dependencies

```bash
sudo apt install packer
```

## Create Image

You have to be online.

``` bash
packer build instant-gnuradio-base.json
packer build instant-gnuradio.json
```

## Main Features

- OVA VM appliance can be imported in all main virtualization solutions or `dd`ed on a USB drive
- Based on Ubuntu 17.04 w/ GNOME 3.
- Two step build process. First create a base image, then an extended image with GNU Radio.
- Easy to brand for your own courses/workshops
- Software: GNU Radio, GQRX, gr-ieee-***, ...
- Hardware: HackRF, RTL-SDR, UHD; properly setup with udev rules and downloaded images
- Productivit: VIM and Spacemacs (plugins alread downloaded and ready for offline use)
- Fosphor support!
- No screen blanking
- No `sudo` password required

## Credentials

``` bash
user: gnuradio
password: gnuradio
```

## VirtualBox

Add yourself to the `vboxusers` group.

### Start VM

Open `virtualbox` and import OVA applicane from `vms/instant-gnuradio`.

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

Then, you can login with `ssh vm` and your password.
