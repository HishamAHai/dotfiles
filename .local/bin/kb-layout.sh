#!/usr/bin/env bash
LNG=$(xkblayout-state print %s )
case $LNG in
  "latam")
    CLR=\π¦π· ;; 
  "ara")
    CLR=\πΈπΎ ;; 
  *)
esac
echo "$CLR"
