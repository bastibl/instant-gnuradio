#!/bin/bash

set -eux

LANG=
apt-get update
apt-get -y install casper lupin-casper

cat << ABC > /etc/casper.conf
export USERNAME="gnuradio"
export USERFULLNAME="gnuradio (password is gnuradio)"
export HOST="ubuntu"
export BUILD_SYSTEM="Ubuntu"
export FLAVOUR="Ubuntu"
ABC

depmod -a $(uname -r)
update-initramfs -u -k $(uname -r)

for i in `cat /etc/passwd | awk -F":" '{print $1}'`
do
	uid=`cat /etc/passwd | grep "^${i}:" | awk -F":" '{print $3}'`
	[ "$uid" -gt "998" -a  "$uid" -ne "65534"  ] && userdel --force ${i} 2> /dev/null
done

apt-get clean

find /var/log -regex '.*?[0-9].*?' -exec rm -rv {} \;

find /var/log -type f | while read file
do
	cat /dev/null | tee $file
done

rm /etc/resolv.conf /etc/hostname
