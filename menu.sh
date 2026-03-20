#!/bin/bash

MENU="Elige uno:\n\t(1) Crear entorno.\n\t(2) Correr proceso\n\t(3) Mostrar listado de alumnos(salida/FILENAME.txt) ordenado por numero de padrón.\n\t(4) Mostrar las 10 notas mas altas del listado (salida/FILENAME.txt).\n\t(5) Buscar estudiante por numero de padrón.\n\t(6) Salir.\nEscribe el NUMERO de opcion que desees: "
OPTION=0
KEEP_WORKING='y'
INITIAL_FLAG='n'

if [[ $1 == "-h" ]] ; then
	echo "Imprimir mensaje de ayuda"
	exit
elif [[ $1 == "-d" ]] ; then
	echo "Esta opcion borrara todos los archivos generados por este programa y matara todos los procesos que inicio ¿estas seguro de esto?[(Y)es, continua/(N)o, salir.]"
	read SEGURO_BORRAR
	if [[ $SEGURO_BORRAR == "n" || $SEGURO_BORRAR == "N" ]] ; then
		exit
	fi
	#aca deberia estar el codigo para la opcion -d
	exit
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
			;;
		2)
			echo "opcion 2 seleccionada "
			;;
		3)
			echo "opcion 3 seleccionada"
			;;
		4)
			echo "opcion 4 seleccionada "
			;;
		5)
			echo "opcion 5 seleccionada"
			echo -n "ingrese un numero de padron: "
			read padron

			#cualquiera de las dos opciones funciona
			cat /$HOME/EPNro1/salida/FILENAME.txt | grep $padron
			#grep "$padron" "/$HOME/EPNro1/salida/FILENAME.txt"
			;;
		6)
			echo "saliendo..."
			exit
			;;
	esac


	echo "¿Queres hacer algo mas? [(Y)es/(N)o]"
	read KEEP_WORKING
	OPTION=0
done

echo "Adios!"
