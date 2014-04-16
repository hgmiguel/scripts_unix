#!/bin/sh

while :
do
    curl -s http://twitter.com/statuses/public_timeline.xml | sed  -ne '/<text/ s/<\/*text>//gp' | grep -Ei 'unix|linux|aix|solaris'
    sleep 30
done 
exit
