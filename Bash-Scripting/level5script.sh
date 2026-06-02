#!/bin/bash

mkdir "Battlefield"
touch ./Battlefield/knight.txt
touch ./Battlefield/sorcerer.txt
touch ./Battlefield/rogue.txt

FILE="./Battlefield/knight.txt"
mkdir "Archive"
if [[ -f $FILE ]]; then
    echo "Knight exists"
    mv $FILE Archive/
fi

Battlefield_contents=$(find ~/Battlefield)
Archive_contents=$(find ~/Archive)

Echo "$Battlefield_contents"
Echo "$Archive_contents"


