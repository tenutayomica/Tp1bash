#!/bin/bash


filePath="$HOME/EPNro1/salida/${FILENAME}.txt"
entradaPath="$HOME/EPNro1/entrada"
procesadoPath="$HOME/EPNro1/procesado"
 
if [[ ! -f "$filePath" ]]; then
   touch "$filePath"
fi
while true; do
   for file in "$entradaPath"/*; do
    if [[ -f "$file" ]]; then  
     padron=$(awk '{print $1}' "$file")
     if  ! grep -q -w "$padron" "$filePath" ; then
      cat "$file" >> "$filePath"
     fi
     mv "$file" "$procesadoPath"
     fi
    done
    sleep 2

done		


