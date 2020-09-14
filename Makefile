.PHONY: clean all base gnuradio

all: vms/gnuradio/instant-gnuradio.ova

gnuradio: vms/gnuradio/instant-gnuradio.ova

base: vms/base/instant-gnuradio-base.ova

vms/base/instant-gnuradio-base.ova: base.json scripts/setup-base.sh scripts/init-base.sh
	packer build --force base.json

vms/gnuradio/instant-gnuradio.ova: gnuradio.json assets/l_opencl_p_18.1.0.015.tgz vms/base/instant-gnuradio-base.ova scripts/setup-gnuradio.sh
	packer build --force gnuradio.json

 assets/l_opencl_p_18.1.0.015.tgz:
	cd assets && wget https://www.fleark.de/l_opencl_p_18.1.0.015.tgz

clean:
	rm -rf vms
	rm -rf packer_cache
	rm -rf assets/l_opencl_p_18.1.0.015.tgz
