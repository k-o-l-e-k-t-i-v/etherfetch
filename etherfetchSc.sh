#!/bin/bash

# usage: 
# ./etherfetchSc.sh http://etherpad.address.com/xxxyyyyzzz
# script to parse etherpad and pipe it live into supercollider.js
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

#tail -f /tmp/lang 2> >(grep -v truncated >&2) | grep -v -e "^\/\/.*" --line-buffered | sclang
#(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | sed 'Wf a\'/n'/g')
#(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | awk 'BEGIN {RS=""}{gsub(/\n/,"",$0); print $0}' | supercolliderJs)
#(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | awk '{printf "%s",$0} END {print ""}' | supercolliderJs)
#(tail -f /tmp/lang | grep -v -e "^\/\/.*" --line-buffered | awk 1 OSR=' ' | sed -u 'N;s/\n//')
# /tmp/preproc | supercolliderJs
