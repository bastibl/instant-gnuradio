# Instant GNU Radio

A customizable, programmatically generated VM and live environment for GNU Radio. [Download](https://nextcloud.seemoo.tu-darmstadt.de/s/7e6XrJ2gStgqKgt) the VM and get started!

![Screenshot](screen2.png)

## Requirements

- Requires **VirtualBox 7.X** to build.

## Main Features

- OVA VM appliance can be imported in all main virtualization solutions or `dd`ed on a USB drive.
- Based on Ubuntu 22.04.1 w/ GNOME 3.
- Two step build process: first create a base image, then extend it with SDR stuff.
- Easy to brand for your own courses/workshops. Just replace the wallpaper in the `assets` folder, for example.
- Software: GNU Radio, GQRX, ...
- Fosphor support!
- Hardware: HackRF, RTL-SDR, BladeRF, Pluto, UHD; properly setup with udev rules and downloaded images.
- Productivity: Git, Meld, VIM, ...
- Favorite applications (in the sidebar) are set to GNU Radio Companion, GQRX, GNU Radio Wiki, ...
- Sane VM defaults (USB, 3D acceleration, audio, shared clipboard, etc.).
- Ready for offline use.
- CPU governors are set to *performance*.
- No annoying crash reports dialogs.
- No screen blanking.
- No `sudo` password.

## Credentials

``` bash
user: sdr
password: sdr
```

### SSH Login

``` bash
ssh -p2222 sdr@localhost
```

Password is `sdr`.

You might want to add something like this to your SSH config (`~/.ssh/config`):

``` bash
Host vm
	Hostname localhost
	User sdr
	Port 2222
	UserKnownHostsFile /dev/null
	StrictHostKeyChecking no
```

With this config, you can login with `ssh vm` and your password.

## VMWare

VirtualBox and VMWare use different network interfaces, which results in different names for the Ethernet controller. If the network is not automatically configured use `ip link show` to figure out the device name of the interface and adapt the `ethernets` section of `/etc/netplan/01-netcfg.yaml` accordingly. 




## Customization

If you want to rebuild and customize the environment, read on...

### Prerequisites

Instant GNU Radio requires packer and VirtualBox including the Extension Pack.

On Debian-like systems, the following packets will do the trick:

```bash
sudo apt install packer
sudo apt install virtualbox virtualbox-ext-pack
```

On Ubuntu, your user should be in the `vboxusers` group.

``` bash
sudo usermod -a -G vboxusers <your username>
```

You have to logout and login again for the changes to take effect.

### Create Image

Note: You have to be online to build the image.

Then, just run:

``` bash
configure
``` 

to check if all dependencies are satisfied. Once `configure` has successfully run, type

``` bash
make
```

to build the virtual machine. The output will be in the `vms/` directory.

Note that there is a `base` file and a `sdr` file. If you make changes to your `sdr.json` you can save time by only rebuilding the latter by running `make sdr`.

### Customizing the Virtual Machines

VM configurations are defined in the packer configuration files `base.json` and `sdr.json`.

More information on how to customize the virtual machines can be found on the [packer website](https://www.packer.io/).
## Live Image

TBD. See the `gen_iso.sh` and `chroot.sh` script.

## More Screenshots
![Screenshot](screen1.png)
![Screenshot](screen3.png)
![Screenshot](screen4.png)
