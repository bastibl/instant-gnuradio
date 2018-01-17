#!/bin/bash

for ((i=0;i<$(nproc);i++))
do
	echo "CPU $i: switch to governor performance"
	sudo cpufreq-set -c $i -r -g performance
done
