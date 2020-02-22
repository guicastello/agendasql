#!/bin/bash

### Definicion de Variables ###
opcion=0						# se usa para elegir qué tarea se va a realizar
bold="\033[1m"					# Pone los atributos del texto en "Bold".
rset="\033[0m"					# Desactiva los Atributos del texto.
rvrs="\033[7m"					# Invierte el texto
ylow="\033[33m"					# Letras en Amarillo
fdoa="\033[44m"					# Letras en Blancas con fondo azul.
subr="\033[4m"					# Letras subrayadas
hoy="$(date +%Y-%m-%d)"			# obtengo la fecha del día de hoy (YYYY/MM/DD)
efe="$(date +%m-%d)"			# fecha dia/mes para efemerides
VERSION="V1.0"					# Version
#LOG="agendasql-"$VERSION".log"	# Nombre del log 

### Definicion de Funciones ###
#
# Función mcur posiciona el cursor fuera del menu para manener prolijo el loop
#
#	function mcur(){
#		echo -e "\033[12;5H";
#	}

#
# Función Pausa, detiene la ejecución del script hasta presionar [ENTER] ###
#
	function pausa(){
		echo -en $bold"Presione una tecla"$rset;
		read pausa;
	}
### Funcion Escribe Log ###
#	function 2LOG() {
#		echo $(date +%Y-%m-%d_%H:%M)": "$1 >> $LOG
#}


### Función menú muestra el menú ###
	clear
	echo -e "================================================================================================================================="
	echo -e "\t\t\t\t\t"$subr$bold$ylow"Bitácora SQL - Login y"$rset"\tversion: "$VERSION
	echo -e "================================================================================================================================="
       mysql -e "use agenda;"
	   echo -ne " usuario: ";read username;
	   echo -ne " password: "; read password;
	   # SELECT EXISTS(SELECT * FROM yourTableName WHERE yourCondition);
       export valido=$(mysql agenda -e "SELECT EXISTS(SELECT * FROM users WHERE username ='${username}' AND password ='${password}');"|tail -1;)
	   echo valido;
	   if [ ${valido} == "1" ] then
        echo "usuario valido";
	   }else{
	      echo "usuario invalido";}
	   fi
	   pausa;
exit 0
