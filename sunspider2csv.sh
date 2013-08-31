#!/bin/bash
# sunspider2csv.sh
# convert multiple outputs of sunspider benchmark into a csv file.
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

tmpdir=`mktemp -d --suffix='.sunspider2csv'`
#echo "tmp data dir: $tmpdir"

for i in $@; do
	#echo "Preprocessing $i"
	assert_file "$i"
	echo "$i" > $tmpdir/"$i"
	cat "$i" |\
		grep '====' -A 50 |\
		grep 'ms' |\
		grep '^    \|Total' |\
		sed  's:ms +/-.*$::' |\
		sed  's:^\s*::' |\
		sed  's/:\s*/,/' |\
		cut -f2 -d, \
		>> $tmpdir/"$i"
done
paste -d, $tmpdir/*

