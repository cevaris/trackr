#!/usr/bin/env bash

USER=$1   #$1 user id
KEY=$2    #$2 user pub key
DEVICE=$3 #$3 device path

# Create user account
sudo useradd -p $(openssl passwd -1 'd4k1Va1AB') "user$1"

# Create directory structure
mkdir -p "/home/user$1/.ssh/"

# Adding public key to authorized_keys
echo $2  > "/home/user$1/.ssh/authorized_keys"

sudo mkfs -t ext4 $3
sudo mount $3 "/home/user$1"
sudo chown "user$1" "/home/user$1"