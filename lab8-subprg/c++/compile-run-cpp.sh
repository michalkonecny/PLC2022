#!/bin/bash

set -e

function progress {
    echo "-------------------------------------------"
    echo "-------" $1
    echo "-------------------------------------------"
}

program_files=$*
if [ `ls $program_files 2>&1 >/dev/null | wc -l ` -gt 0 ]
then 
    echo "You used $0 incorrectly.  Please call it with a valid C++ file as follows:"
    echo "   bash $0 <file-name>.cpp"
else

    trap "progress 'cleaning up'; rm -f *.o ./a.out" SIGHUP SIGINT SIGTERM EXIT

    progress 'calling the compiler'
    g++ $program_files
    progress 'compiler finished'
    set +e
    progress 'starting the program'
    ./a.out
    progress 'program stopped'
fi

