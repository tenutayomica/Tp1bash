#!/bin/bash


# Verificación de existencia o no nulidad de FILENAME y no es -d

if [[ -z "$FILENAME" ]] && [[ "$1" != "-d" ]]; then
	echo "Error: Variable de entorno FILENAME no definida."
	echo "Defínila en la terminal con: export FILENAME=nombre_archivo"
	exit 1
fi


MENU="Elige uno:\n\t(1) Crear entorno.\n\t(2) Correr proceso\n\t(3) Mostrar listado de alumnos(salida/FILENAME.txt) ordenado por numero de padrón.\n\t(4) Mostrar las 10 notas mas altas del listado (salida/FILENAME.txt).\n\t(5) Buscar estudiante por numero de padrón.\n\t(6) Salir.\nEscribe el NUMERO de opcion que desees: "
OPTION=0
KEEP_WORKING='y'
INITIAL_FLAG='n'
filePath="$HOME/EPNro1/salida/${FILENAME}.txt"


crear_entorno(){
	
	mkdir $HOME/EPNro1
	mkdir $HOME/EPNro1/entrada	
	mkdir $HOME/EPNro1/salida
	mkdir $HOME/EPNro1/procesado
	cp $(pwd)/consolidar.sh $HOME/EPNro1
}
mostrar_ordenados(){
	if [[ ! -f "$filePath" ]]; then
		echo "El archivo $FILENAME no existe."
		return 1;
	fi
	echo "Listado de alumnos ordenados por número de padrón:"
	sort -n "$filePath" | column -t -s ' '
}

mostrar_top10(){
	if [[ ! -f "$filePath" ]]; then
		echo "El archivo $FILENAME no existe."
		return 1;
	fi
		echo "Las 10 notas más altas:"
		sort -k5 -rn "$filePath" | head -10 | column -t -s ' '	
}

correr_proceso(){
 if [[ -d "$HOME/EPNro1" ]]; then
     bash "$HOME/EPNro1/consolidar.sh" "$FILENAME" & 
	echo $! > "$HOME/EPNro1/consolidar.pid"

 else
    echo "crear entorno seleccionando opción 1"
 fi
}

buscar_padron(){
			
			echo -n "ingrese un numero de padron: "
			read padron
			cat "$filePath" | grep $padron

}

if [[ $1 == "-h" ]] ; then
	echo "Imprimir mensaje de ayuda"
	exit
elif [[ $1 == "-d" ]] ; then
	echo "Esta opcion borrara todos los archivos generados por este programa y matara todos los procesos que inicio ¿estas seguro de esto?[(Y)es, continua/(N)o, salir.]"
	read SEGURO_BORRAR
	if [[ $SEGURO_BORRAR != "y" && $SEGURO_BORRAR != "Y" ]] ; then
		exit 0
	fi
	if [ -d /$HOME/EPNro1 ];then
		PID_CONSOLIDAR=$(cat "$HOME/EPNro1/consolidar.pid")
		kill "$PID_CONSOLIDAR" 2>/dev/null
		echo "proceso consolidar.sh finalizado"
		rm -r /$HOME/EPNro1
		echo "eliminamos el directorio EPNro1, junto con todo su contenido"
		exit 0
	else
		echo "No encontramos el directorio "$HOME"/EPNro1"
		exit 1
	fi
elif [[ $1 == "-o"[1-5] ]] ; then 
	OPTION=$( echo "$1" | sed "s/[^1-5.]*//g" ) #saca el numero de la flag -o[1-5] y lo guarda en OPICON.
	INITIAL_FLAG='y'
elif [[ -n $1 ]] ; then #si hay al menos un parametro, avisar sobre uso incorrecto. si hubiera sido un parametro valido, se habria ejecutado antes. 
	echo "Uso incorrecto, ejecutar con el parametro \"-h\" para mas informacion."
	exit
fi


while [[ $KEEP_WORKING == "Y" || $KEEP_WORKING == "y" ]] ; do
	while [[ !(${OPTION} > 0 && ${OPTION} -le 6) ]]  ; do
		echo "¿Que te gustaria hacer?"
		echo -en $MENU
		read OPTION
	done

	case ${OPTION} in
		1)
			echo "opcion 1 seleccionada"
			crear_entorno ;;
		2)
			echo "opcion 2 seleccionada"
            correr_proceso ;;
		3)
			echo "opcion 3 seleccionada"
			mostrar_ordenados ;;
		4)
			echo "opcion 4 seleccionada"
            mostrar_top10 ;; 

		5)
			echo "opcion 5 seleccionada"
			buscar_padron ;;

		6)
			echo "saliendo..."
    			exit 0
			;;
	esac


	echo "¿Queres hacer algo mas? [(Y)es/(N)o]"
	read KEEP_WORKING
	OPTION=0
done

echo "Adios!"