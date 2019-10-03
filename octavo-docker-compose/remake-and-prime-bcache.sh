#!/bin/bash
set -e
if [ -f "/sys/fs/bcache/b73a05f2-9880-4527-b9ba-abe0d981b712/stop" ]; then
  echo 1 > /sys/fs/bcache/b73a05f2-9880-4527-b9ba-abe0d981b712/stop
fi
if [ -f "/sys/block/vdc/bcache/stop" ]; then
  echo 1 > /sys/block/vdc/bcache/stop
fi
sleep 1
wipefs -a /dev/vdc
wipefs -a /dev/vdb
make-bcache -C /dev/vdb -B /dev/vdc --cset-uuid b73a05f2-9880-4527-b9ba-abe0d981b712
sleep 1
mount /dev/bcache0 /data
echo 0 > /sys/fs/bcache/b73a05f2-9880-4527-b9ba-abe0d981b712/congested_write_threshold_us 
echo 0 > /sys/fs/bcache/b73a05f2-9880-4527-b9ba-abe0d981b712/congested_read_threshold_us 
echo 0 > /sys/block/bcache0/bcache/sequential_cutoff
vmtouch -t /data &

