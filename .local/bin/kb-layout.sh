#!/usr/bin/env bash
LNG=$(xkblayout-state print %s )
case $LNG in
  "latam")
    CLR=\🇦🇷 ;; 
  "ara")
    CLR=\🇸🇾 ;; 
  *)
esac
echo "$CLR"
