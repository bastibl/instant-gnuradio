.PHONY: clean all base sdr

all: vms/sdr/instant-sdr.ova

sdr: vms/sdr/instant-sdr.ova

base: vms/base/instant-sdr-base.ova

vms/base/instant-sdr-base.ova: base.json scripts/setup-base.sh scripts/init-base.sh
	packer build --force base.json

vms/sdr/instant-sdr.ova: sdr.json assets/l_opencl_p_18.1.0.015.tgz vms/base/instant-sdr-base.ova scripts/setup-sdr.sh
	packer build --force sdr.json

 assets/l_opencl_p_18.1.0.015.tgz:
	cd assets && wget https://www.fleark.de/l_opencl_p_18.1.0.015.tgz

clean:
	rm -rf vms
	rm -rf packer_cache
	rm -rf assets/l_opencl_p_18.1.0.015.tgz
