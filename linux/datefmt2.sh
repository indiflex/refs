#!/bin/sh

print_try() {
    echo "Try './datefmt2.sh -h' for more information!"
    exit 1
}

print_help() {
    echo "usage : ./datefmt2.sh -d <diffs> -u <unit> [-f format]"
    exit 1
}

while getopts d:u:f:h opt
do
    # echo "opt=$opt, OPTARG=$OPTARG"
    case $opt in
        d)
            D=$OPTARG;;
        u)
            U=$OPTARG;;
        f)
            F=$OPTARG;;
        h)
            print_help;;
        *)
            print_try;;
    esac
done

if [ -z $F ]; then
    F="+%m-%d"
fi

RET=`date $F --date="$D $U"`
echo "$RET"
