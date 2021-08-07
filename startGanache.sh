#!/bin/bash

[ -d "log" ] && echo "Directory /path/to/dir exists." || echo "Error: Directory /path/to/dir does not exists." && mkdir log

DATE=`date +%m-%d-%Y:%T`
echo "Date: $DATE"

INFURA="https://mainnet.infura.io/v3/dcfa67d4f6a840a39906acfa7a043963"

ganache-cli --fork $INFURA --unlock --account "0xf38b5679751228eab7d9f3aa02bd0b0c0f7b44e448c0cfd410a1d7053efb6c56,123456789000000000000000"  | tee "log/$DATE.log"

ADDRESS=`grep -A 2 'Available Accounts' log/$DATE.log | grep -P "0x" | awk '{print $2}'`
KEY=`grep -A 2 'Private Keys' | grep "0x" | awk '{print $2}'`

echo "Account is: $ADDRESS"
echo "Key is: $KEY"