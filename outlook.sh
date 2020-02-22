#!/bin/bash

### Definicion de Variables ###
opcion=0						# se usa para elegir qué tarea se va a realizar
bold="\033[1m"					# Pone los atributos del texto en "Bold".
rset="\033[0m"					# Desactiva los Atributos del texto.
rvrs="\033[7m"					# Invierte el texto
ylow="\033[33m"					# Letras en Amarillo
lred="\033[1;31m"					# Letras en rojo
fdoa="\033[44m"					# Letras en Blancas con fondo azul.
subr="\033[4m"					# Letras subrayadas
hoy="$(date +%Y-%m-%d)"			# obtengo la fecha del día de hoy (YYYY/MM/DD)
efe="$(date +-%m-%d)"			# fecha dia/mes para efemerides
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
	echo -e "======================================================================"
	echo -e $subr$bold$ylow"Bitácora SQL - Que hay para hoy"$rset"\tversion: "$VERSION
	echo -e "======================================================================="
       mysql -e "use agenda;"
	   echo -e " > Agenda para el  dia de hoy:";
       mysql agenda -e "SELECT * FROM calendario WHERE fecha = CURDATE();";
	   echo -e " > Proximos Eventos:";
	   mysql agenda -e "SELECT fecha, hora_ini , hora_fin , todo_dia , descripcion FROM calendario WHERE fecha > CURDATE() ORDER BY fecha ASC;";
	   echo -e " > Efemerides:"
	   mysql agenda -e "SELECT fecha, descripcion FROM calendario WHERE fecha LIKE '%"${efe}"%' AND todo_dia = 'TRUE' ORDER BY fecha ASC";
	   echo -e $lred" > Tareas vencidas:";
       mysql agenda -e "SELECT fecha_fin, prioridad, titulo, Notas FROM tareas WHERE fecha_fin < CURDATE() AND completada = 'FALSE' ORDER BY fecha_fin ASC;";
	   echo -e $rset" > Tareas que vencen hoy:";
	   mysql agenda -e "SELECT * FROM tareas WHERE fecha_fin = CURDATE() ORDER BY fecha_fin ASC;";
	   pausa;
exit 0
