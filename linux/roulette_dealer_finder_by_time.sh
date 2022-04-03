#!/bin/bash

awk '{print $1,$2,$5,$6}' "$1" | grep -i "$2"