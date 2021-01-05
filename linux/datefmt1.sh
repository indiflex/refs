#!/bin/sh

if [ $# -lt 2 ]; then
    echo "usage : ./datefmt1.sh <diffs> <unit> [format]"
    echo "sample> ./datefmt1.sh 3 day +%m/%d"
    exit 1
fi

D=$1
U=$2

if [ $# -gt 2 ]; then
    F=$3
else
    F="+%Y-%m-%d"
fi

RET=`date $F --date="$D $U"`
echo "$RET"
