#! bin/bash

nom="$1"
FILENAME="$HOME/EPNro1/salida/${nom}.txt"
entradaPath="$HOME/EPNro1/entrada"
procesadoPath="$HOME/EPNro1/procesado"
 
 if [[ ! -f "$FILENAME" ]]; then
   touch "$FILENAME"
 fi
   for file in "$entradaPath"/*;
    do
    if [[ -f "$file" ]]; then  
     padron=$(awk '{print $1}' "$file")
     if  ! grep -q -w "$padron" "$FILENAME" ; then
      cat "$file" >> "$FILENAME"
     fi
     mv "$file" "$procesadoPath"
     echo "proceso finalizado"
  fi
 done



