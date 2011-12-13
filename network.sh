#! /bin/bash

myen0=`ifconfig en0 | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'`

if [ "$myen0" != "" ]
then
echo "Ethernet: $myen0"
else
echo "Ethernet: INACTIVE"
fi

mytun0=`ifconfig tun0 2>/dev/null| grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'`

if [ "$mytun0" != "" ]
then
echo "OpenVPN: $mytun0"
else
echo "OpenVPN: INACTIVE"
fi

