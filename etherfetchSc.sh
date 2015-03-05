#!/bin/bash

# usage: 
# ./etherfetchSc.sh http://etherpad.address.com/xxxyyyyzzz
# script to parse etherpad and pipe it live into supercollider
# multiuser livecoding session
# requires curl

if (( $# < 1 )); then
  echo "please specify etherpad address"
  exit 1
fi

rm /tmp/lang
rm /tmp/lang2
mkfifo /tmp/lang
mkfifo /tmp/lang2
(while true; do curl -vs $@/export/txt | grep -v -e "\/\/.*" > /tmp/lang && sleep 2s ; done)&
(while true; do echo -n "`cat /tmp/lang`" | tr -d '\n' > /tmp/lang2 &&  echo -e "\r" > /tmp/lang2 && sleep 2s ;done)&
sleep 10s && tail -f /tmp/lang2 | sclang
