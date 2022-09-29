#!/bin/sh

# get all of our variables in order
NETSTAT=`which netstat`
IP4=$(ip -4 route list | grep default -A 1 | awk 'FNR == 2 {print $9}')
IP6=$(ip -6 route list | grep "metric 100" | awk '{print $1}' | sed 's/.\{5\}$//')

die(){
        exit 999
}

preparation(){
        if [ ! -x $NETSTAT ]
        then
                echo "2:500:netstat not found."
                die
        fi
}

check_service(){

        # unset all of our loop variables
        unset conns conns4 conns6
        conns4=0
        conns6=0

        # get all established inbound connections to the tor obfs4 bridge port
        conns4=$(/usr/bin/netstat -an | grep $IP4:993 | grep ESTABLISHED | wc -l)
        conns6=$(/usr/bin/netstat -anW | grep $IP6:993 | grep ESTABLISHED | wc -l)
	conns=$(($conns4 + $conns6))

        # print it out for prtg
        echo "0:$conns:OK"
        exit 0
}

main ()
        preparation
        check_service
}

main

