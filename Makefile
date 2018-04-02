.PHONY: clean all

all: base gnuradio

base: base.json
	packer build base.json

gnuradio: gnuradio.json
	packer build gnuradio.json

clean:
	rm -fr vms
	rm -fr packer_cache

