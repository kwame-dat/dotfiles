#!/bin/sh
offlineimap -a tony.ampomah.jw@gmail.com & pid1=$!
offlineimap -a tony@arksolutions.it & pid2=$!
offlineimap -a tony.ampomah@netsells.co.uk & pid3=$!
offlineimap -a tony.ampomah@thetrainline.com & pid4=$!

wait $pid1
wait $pid2
wait $pid3
wait $pid4
echo "Last execution: $(date)"
