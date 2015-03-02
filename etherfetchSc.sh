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
(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | awk 'BEGIN {RS=""}{gsub(/\n/,"",$0); print $0}' | supercolliderJs)
#(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | awk '{printf "%s",$0} END {print ""}' | supercolliderJs)
#(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | awk 1 OSR=' ' | sed -u 'N;s/\n//')
# /tmp/preproc | supercolliderJs
