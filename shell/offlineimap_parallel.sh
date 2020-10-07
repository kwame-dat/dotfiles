#!/bin/sh
offlineimap -a jw & pid1=$!
offlineimap -a arksolutions & pid2=$!
offlineimap -a netsells & pid3=$!

wait $pid1
wait $pid2
wait $pid3
echo "Last execution: $(date)"
