#!/bin/bash

log="log"

if [ -d $log ]; then
  # the directory exists
  [ "$(ls -A $log)" ] && 
  cd $log && rm -rf `ls -Ab` ||
  echo "Empty"
fi