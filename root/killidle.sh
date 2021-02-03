#!/bin/bash

PTS_LIST=`who -s | awk '{ print $2 }'`

cd /dev
for i in ${PTS_LIST}
do
    PTS_USER=`stat -c '%U' $i`
    PTS_IDLETIME=`stat -c '%X' $i | awk '{ print '"$(date +%s)"'-$1 }'`
    if [ "$PTS_USER" != "root" ]
    then
        if (( $PTS_IDLETIME > 10800 ))
        then
            PTS_PID=`ps -t $i -o pid | tail -n 1`
            kill -1 $PTS_PID
        fi
    fi
done
