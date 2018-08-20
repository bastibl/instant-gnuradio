.PHONY: clean all base gnuradio

all: vms/gnuradio/instant-gnuradio.ova

gnuradio: vms/gnuradio/instant-gnuradio.ova

base: vms/base/instant-gnuradio-base.ova

vms/base/instant-gnuradio-base.ova: base.json scripts/setup-base.sh scripts/init-base.sh
	packer build --force base.json

vms/gnuradio/instant-gnuradio.ova: gnuradio.json assets/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz vms/base/instant-gnuradio-base.ova scripts/setup-gnuradido.sh
	packer build --force gnuradio.json

assets/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz:
	cd assets && wget http://registrationcenter-download.intel.com/akdlm/irc_nas/12556/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz

clean:
	rm -fr vms
	rm -fr packer_cache
	rm -rf assets/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz
