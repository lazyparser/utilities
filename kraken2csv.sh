#!/bin/bash
# kraken2csv.sh
# convert multiple outputs of kraken benchmark into a csv file.
#
# Usage:
#     progname file1 file2 file3 ...

die () {
	echo "$*"
	exit 1
}

assert_file () {
	[ $# -eq 1 ] || die "assert_file: need one argument."
	[ -f "$1" ] || die "assert_file: File missing: $1"
}

tmpdir=`mktemp -d --suffix='.kraken2csv'`

for i in $@; do
	#echo "Preprocessing $i"
	assert_file "$i"
	echo "$i" > $tmpdir/"$i"
	cat "$i" |\
		grep '====' -A 29 |\
		grep 'ms' |\
		grep '^    \|Total' |\
		sed  's:ms +/-.*$::' |\
		sed  's:^\s*::' |\
		sed  's/:\s*/,/' |\
		cut -f2 -d, \
		>> $tmpdir/"$i"
done
paste -d, $tmpdir/*

