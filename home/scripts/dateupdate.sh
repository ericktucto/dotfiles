#!/usr/bin/env bash

newDate=$(curl -s http://worldtimeapi.org/api/timezone/America/Lima | grep -oP '"datetime":"\K[^"]+' | sed 's/T/ /' | sed 's/\..*//')

sudo date -s "$newDate"
