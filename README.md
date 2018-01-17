# Instant GNU Radio



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
