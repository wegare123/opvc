#!/bin/bash
#opvc (Wegare)
host="$(cat /root/akun/opvc.txt | grep -i host | cut -d= -f2 | head -n1)"
route="$(route | grep -i $host| head -n1 | awk '{print $1}')" 
route2="$(route | grep -i tun0 | head -n1 | awk '{print $8}')" 
	if [[ -z $route2 ]]; then
		   printf '\n' | opvc
           exit
    elif [[ -z $route ]]; then
		   printf '\n' | opvc
           exit
	fi
