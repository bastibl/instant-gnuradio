.PHONY: clean all

all: vms/gnuradio/instant-gnuradio.ova

vms/base/instant-gnuradio-base.ova: base.json
	packer build base.json

vms/gnuradio/instant-gnuradio.ova: gnuradio.json assets/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz vms/base/instant-gnuradio-base.ova
	packer build gnuradio.json

assets/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz:
	cd assets && wget http://registrationcenter-download.intel.com/akdlm/irc_nas/12556/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz

clean:
	rm -fr vms
	rm -fr packer_cache
	rm -rf assets/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz
