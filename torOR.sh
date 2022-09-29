#!/bin/bash
# get the number of connections to the tor OR port
# output the value in prtg's X:Y:Z expected format

# do we have what we need? if not ... die
NETSTAT=$(which netstat)
GREP=$(which grep)
WC=$(which wc)
IP=$(which ip)

die(){

        exit 999

}

preparation(){

        if [ ! -x $NETSTAT ] || [ ! -x $GREP ] || [ ! -x $WC ] || [ ! -x $IP ]
        then
                echo "2:500:critical command not found."
                die
        fi

}

# okay, we look good, let's go
IP4=$(ip -4 route list | grep default -A 1 | awk 'FNR == 2 {print $9}')
IP6=$(ip -6 route list | grep "metric 100" | awk '{print $1}' | sed 's/.\{5\}$//')

check_service(){

        # unset all of our loop variables
        unset conns conns4 conns6
        conns4=0
        conns6=0

        # get all established inbound connections to the tor OR port
        conns4=$(/usr/bin/netstat -an | grep $IP4:110 | grep ESTABLISHED | wc -l)
        conns6=$(/usr/bin/netstat -anW | grep $IP6:110 | grep ESTABLISHED | wc -l)
	conns=$(($conns4 + $conns6))

        # print it out for prtg
        echo "0:$conns:OK"
        exit 0

}

main () {

        preparation
        check_service

}

main
