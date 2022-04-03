#!/bin/bash/

echo 'BlackJack_Dealer'
awk '{print $1,$2,$3,$4}' "$1" | grep -i "$2"
echo 'Roulette_Dealer'
awk '{print $1,$2,$5,$6}' "$1" | grep -i "$2"
echo 'Texas_Hold_EM_Dealer'
awk '{print $1,$2,$7,$8}' "$1" | grep -i "$2"