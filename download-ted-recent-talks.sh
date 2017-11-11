#!/bin/bash

n=7

usage () {
    echo "Usage: $0 [n]"
    echo "       n=top n TED talks listed on the page."
    return 0
}

down_ted_once () {
    [ $# -eq 1 ] || exit 3
    url="$1"
    fn="${url##*/}"
    fn="${fn%%\?*}"
    wget -O $fn $url
    #echo wget -O $fn $url

}

if [ $# -gt 2 ]; then
    usage
fi

if [ $# -eq 2 ]; then
    n="$1"
fi

TED_URL='https://www.ted.com/talks/quick-list'

wget -O - "$TED_URL" 2>/dev/null |\
    grep High |\
    cut -f2 -d'"' |\
    head -n $n |\
    while read url; do down_ted_once "$url"; done

echo "Done."
