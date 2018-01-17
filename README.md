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

### Start VM

Open `virtualbox` and import OVA applicane from `vms/instant-gnuradio`.

### SSH Login

``` bash
ssh -p2222 gnuradio@localhost
```

Password is `gnuradio`.



