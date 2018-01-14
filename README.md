# WIP, don't use!

## Dependencies

```bash
sudo apt install packer
```

## Create Image

You have to be online.

``` bash
packer build --only=qemu gnuradio.json

```


## QEMU


### Start VM

``` bash
./start_qemu.sh

```

### SSH Login

Password is `gnuradio`.

``` bash
ssh -p2222 gnuradio@localhost
```


