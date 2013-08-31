#!/bin/bash
# octane2csv.sh
# convert multiple outputs of octane benchmark into a csv file.
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

[ $# -ge 1 ] || die "usage: $0 file1 file2 file3 ..."

tmpdir=`mktemp -d --suffix='.octane2csv'`

for i in $@; do
	#echo "Preprocessing $i"
	assert_file "$i"
	echo "$i" > $tmpdir/"$i"
	cat "$i" |\
		grep -v '^----' |\
		cut -f2 -d: |\
		sed 's:\s::g' \
		>> $tmpdir/"$i"
done 
paste -d, $tmpdir/*

