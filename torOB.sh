#!/bin/sh

NETSTAT=`which netstat`

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

	# unset all of our variables
	unset conns conns4 conns6

        # get all established inbound connections to the tor obfs4 bridge port
        conns4=$(/usr/bin/netstat -an | grep '155.138.193.95:993' | grep ESTABLISHED | wc -l)
        conns6=$(/usr/bin/netstat -an | grep '2001:19f0:5401:23c4:5400:04ff:fe27:43d2:993' | grep ESTABLISHED | wc -l)
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

