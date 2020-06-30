#!/bin/sh
offlineimap -a jw & pid1=$!
offlineimap -a arksolutions & pid2=$!
offlineimap -a netsells & pid3=$!
offlineimap -a thetrainline & pid4=$!

wait $pid1
wait $pid2
wait $pid3
wait $pid4
echo "Last execution: $(date)"
