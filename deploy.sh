#!/bin/bash

DATE=`date +%m-%d-%Y:%T`
NAME="DEPLOY__$DATE.log"
truffle deploy | tee "log/$NAME"
ADDRESS=`grep "contract address" "log/$NAME" | grep -P '0x' | awk '{print $4}'`
echo "Address is: $ADDRESS";



if [ -z "$ADDRESS" ]
then
  echo "\$var is empty"
else
  echo "\$var is NOT empty"
  echo $ADDRESS > .address
fi