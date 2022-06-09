#!/bin/bash

sensors | awk '/edge/ {print "🔥"$2}'
