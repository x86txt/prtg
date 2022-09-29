#!/bin/bash
# get the monero blockchain height
# output the value in prtg's X:Y:Z expected format

# do we have what we need? if not ... die
SED=$(which sed)
MONEROD="/opt/monero/current/monerod"

die(){

        exit 999

}

preparation(){

        if [ ! -x $SED ] || [ ! -x $MONEROD ]
        then
                echo "2:500:critical command not found."
                die
        fi

}

# okay, we look good, let's go
check_service () {

        # get percentage of blockchain downloaded
        bcheight=$(/opt/monero/current/monerod print_height | sed -n '2 p' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g")
        # print it out for prtg
        echo "0:$bcheight:OK"
        exit 0

}

main () {

        preparation
        check_service

}

main
