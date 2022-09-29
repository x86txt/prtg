#!/bin/bash
# get the total percentage of monero blockchain
# -- check out the ugly hack to avoid fixing triple digit percentage output, line 34-39
# output the value in prtg's X:Y:Z expected format

# do we have what we need? if not ... die
GREP=$(which grep)
CUT=$(which cut)
MONEROD="/opt/monero/current/monerod"

die(){

        exit 999

}

preparation(){

        if [ ! -x $GREP ] || [ ! -x $MONEROD ]
        then
                echo "2:500:critical command not found."
                die
        fi

}


# okay, we look good, let's go
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

main () {

        preparation
        check_service

}

main
