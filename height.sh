#!/bin/bash

MONEROD="/opt/monero/current/monerod"

die () {
        exit 999
}

preparation () {
        if [ ! -x $MONEROD ]
        then
                echo "2:500:monerod not found."
                die
        fi
}

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

