#!/bin/bash

clear ; ulimit -n 524288 10485760 ; VAL=$( ulimit -Sn ) ; echo -e "MAX_FILENO: $VAL"

FLAG=" -lpthread -lsqlite3 -lcrypto -lssl -lz" # -largon2
FILE=$(mktemp)
NAME="cocoDB"

if [ ! -d "./build" ] ; then 
  mkdir "./build"
fi

echo -e "\nKilling Service" ; $( killall $NAME )

echo -e "\nCompiling Service"
if !( g++ -o ./build/$NAME ./services/$NAME.cpp -I ./include $FLAG ) 2> "$FILE"; then
      echo -e "\n" ; cat "$FILE" >&2 ; exit
else
      echo -e "Done"
fi

echo -e "\nRunning Service" ; ./build/$NAME;
