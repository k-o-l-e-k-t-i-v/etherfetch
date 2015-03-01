#!/bin/bash

# usage: 
# ./etherfetchSc.sh http://etherpad.address.com/xxxyyyyzzz
# script to parse etherpad and pipe it live into supercollider.js
# multiuser livecoding session
# requires curl and https://github.com/crucialfelix/supercolliderjs

if (( $# < 1 )); then
  echo "please specify etherpad address"
  exit 1
fi

rm /tmp/lang
mkfifo /tmp/lang
(while true; do curl -vs $@/export/txt > /tmp/lang && sleep 2s ; done)&
tail -f /tmp/lang | supercolliderJs
