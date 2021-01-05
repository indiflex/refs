#!/bin/sh

print_try() {
    echo "Try './datefmt3.sh -h' for more information!"
    exit 1
}

print_help() {
    echo "usage : ./datefmt3.sh -d <diffs> -u <unit> [-f format]"
    echo "usage : ./datefmt3.sh --diffs <diffs> --unit <unit> [--format format]"
    exit 1
}

options="$(getopt -o d:u:f:h -l diffs:,unit:,format:,help -- "$@")"
eval set -- $options

while true
do
    # echo "$1, $2  [$@]"
    case $1 in
        -d|--diffs)
            D=$2
            shift 2;;
        -u|--unit)
            U=$2
            shift 2;;
        -f|--format)
            F=$2
            shift 2;;
        -h|--help)
            print_help;;
        --)
            break;;
        *)
            print_try;;
    esac
done

RET=`date $F --date="$D $U"`
echo "$RET"
