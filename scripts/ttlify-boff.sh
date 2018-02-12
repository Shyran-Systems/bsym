#!/bin/zsh

WD="/data/data-source/bloom-boff"
NOW=`dconv now`

for i in "${WD}/download-nobackup"/*dif.20*; do
	echo "FILE=${i}"
	bsdcat "${i}"
	rm -f -- "${i}"
done \
	| tee >(xz -c > "${WD}/archive/raw_${NOW}.xz") \
	| "${WD}/scripts/ttlify-boff.awk" --diff \
	| tee >(gzip -c > "${WD}/tmp/ttl.d_${NOW}.gz")
