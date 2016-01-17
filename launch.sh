#!/usr/bin/env bash

p_port=1337
pidfile="prolog/server.pid"

if [ -e "$pidfile" ]; then
	echo "Killing previous instance..."
	kill `cat $pidfile`
	sleep .5
fi
echo "Launching Prolog server..."
./prolog/daemon.pl --port=$p_port --pidfile=$pidfile

echo "Launching application..."
nw ./application/app &> /dev/null &
