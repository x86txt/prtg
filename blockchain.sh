#!/bin/sh

MONEROD="/opt/monero/current/monerod"

die(){
        exit 999
}

preparation(){
        if [ ! -x $MONEROD ]
        then
                echo "2:500:monerod not found."
                die
        fi
}

check_service(){
        # get percentage of blockchain downloaded
        bcpercent=$(/opt/monero/current/monerod sync_info | grep target | cut -d"(" -f2 | cut -b 1,2)

        if [ $bcpercent != 10 ]
         then
          percent=$bcpercent
         else
          percent=100
         fi

        # print it out for prtg
        echo 0:$percent:OK
        exit 0
}

main ()
        preparation
        check_service
}

main

