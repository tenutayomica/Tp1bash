#! bin/bash

FILENAME="$1"
ContainmentDir="$2"
fileNamePath="${ContainmentDir}/salida/${FILENAME}.txt"
entradaPath="${ContainmentDir}/entrada"
procesandoPath="${ContainmentDir}/procesando"

if [[ -d "$ContainmentDir" ]]; then
 
 if [[ ! -f "$fileNamePath" ]]; then
   touch "$fileNamePath"
 fi
 
 for file in "$entradaPath"/*;
 do
  if [[ -f "$file" ]]; then
  
   padron=$(awk '{print $1}' "$file")
   if  ! grep -q -w "$padron" "$fileNamePath" ; then
    cat "$file" >> "$fileNamePath"
   fi
   mv "$file" "$procesandoPath"
  fi
 done

else
echo "no dir"
 
fi
