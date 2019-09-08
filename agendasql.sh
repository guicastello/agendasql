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
LOG="agendasql-"$VERSION".log"	# Nombre del log 

### Definicion de Funciones ###
#
# Función mcur posiciona el cursor fuera del menu para manener prolijo el loop
#
	function mcur(){
		echo -e "\033[12;5H";
	}

#
# Función Pausa, detiene la ejecución del script hasta presionar [ENTER] ###
#
	function pausa(){
		echo -en $bold"Presione una tecla"$rset;
		read pausa;
	}
### Funcion Escribe Log ###
	function 2LOG() {
		echo $(date +%Y-%m-%d_%H:%M)": "$1 >> $LOG
}


### Función menú muestra el menú ###
	function menu() {
		clear
		echo -e "=============================================================================================="
		echo -e "\t\t\t\t"$subr$bold$ylow"Bitácora SQL - Modulo Agenda"$rset"\tversion: "$VERSION
		echo -e "=============================================================================================="
		cal
		echo -ne "\033[4;21H | "
		echo -ne "\033[5;21H | "
		echo -e " 1) Alta\t\t\t4) Busca x fecha\t7) Backup"
		echo -ne "\033[6;21H | "
		echo -e " 2) Borra fecha\t\t5) Agenda para Hoy\t8) Modificar Registro"
		echo -ne "\033[7;21H | "
		echo -e " 3) Borra x Descripcion\t6) Efemerides\t\t9) Salir"
		echo -ne "\033[8;21H | "
		echo -ne "\033[9;21H |  opción: "
		echo -ne "\033[s" # grabo posision del cursor
		echo -ne "\033[10;21H | ";
		echo -ne "\033[11;1H=============================================================================================="
		echo -ne "\033[u" # restauro posicion del cursor
	}

#### Bucle Principal ####

if [ -ne $LOGFILE ]
       then
		echo > /dev/null
       else
		touch agenda.log
		chmod u+w agenda.log
		2LOG "Creación de Log file."
fi
2LOG "Inicio Log agendasql por el usuario "$(whoami)
mysql -e "use agenda;"
while [ $opcion != "9" ]; do
 menu
 read opcion
 case $opcion in

	1) mcur;
	   echo -e "> Alta registro";
	   echo -ne "fecha: ";read fecha;
	   echo -ne "hora inicio: "; read hini;
	   echo -ne "hora fin: "; read hfin;
	   echo -ne "todo el dia: "; read tld;
	   echo -ne "Descripcion: "; read desc;
	   mysql agenda -e "insert into agenda.calendario (fecha, hora_ini, hora_fin, todo_dia, descripcion) values ('${fecha}', '${hini}', '${hfin}', '${tld}', '${desc}');";
       pausa;
       2LOG "Alta de registro.";;

	2) mcur;
	   echo -e " > Borrar registro por fecha";
	   echo -ne "Fecha: ";read fecha;
	   mysql agenda -e "select * from calendario where fecha like '%"${fecha}"%';";
           echo -ne "Ingrese Id a Borrar: "; read id;
           mysql agenda -e "DELETE FROM calendario WHERE  id = "${id}";";
           mysql agenda -e "select * from calendario WHERE fecha like '%"${fecha}"%';";
	   pausa;
	   2LOG "Borrado fecha "$fecha;;

	3) mcur;
	   echo -e " > Borrar registro por descripcion";
	   echo -ne "Descripcion: ";read descripcion;
	   mysql agenda -e "SELECT * FROM calendario WHERE description LIKE '%"${descripcion}"%';";
	   echo -e "Ingrese Id a Borrar> "; read id;
           mysql agenda -e "DELETE FROM calendario WHERE id = "${id}";";
	   pausa;
	   2LOG "Borrado descripcion"$CALENDAR;;

	4) mcur;
	   echo -e " > Busqueda por fecha";
	   echo -ne "fecha: ";read fecha;
	   mysql agenda -e "SELECT * FROM calendario WHERE fecha like '%"${fecha}"%';";
	   pausa;
	   2LOG "Busqueda Fecha "$fecha;;

	5) mcur;
	   echo " > Agenda para el  dia de hoy";
           mysql agenda -e "SELECT * FROM calendario WHERE fecha like '%"${hoy}"%';";
           pausa;
           2LOG "Agenda de Hoy";;

	6) mcur;
	   echo -e " > Efemerides";
	   mysql agenda -e "SELECT * FROM calendario WHERE fecha LIKE '%"${efe}"%' AND todo_dia = 'TRUE';";
	   pausa;
	   2LOG "Efemerides";;

	7) mcur;
	   echo -e " > Backup agendasql";
	   mysqldump agenda > ~/agendasql/backups/agenda_`date +%Y-%m-%d_%H%M`.sql;
	   echo -e $bold"Backup OK"$rset;
	   pausa;
	   2LOG "Back up agenda";;

	8) mcur;
	   echo -ne "fecha: ";read fecha;
	   mysql agenda -e "SELECT * FROM calendario WHERE fecha like '%"${fecha}"%';";
	   echo -e " > Elija registro a modificar";
	   echo -ne "id: "; read id;
	   echo -e " > Elija campo a modificar:\n";
	   echo -e $rvrs"1"$rset" fecha "$rvrs"2"$rset" hora inicio "$rvrs"3"$rset" hora fin "$rvrs"4"$rset" todo el dia "$rvrs"5"$rset" descripcion "$rvrs"6"$rset" Cancelar\n";
	   echo -ne "opcion: ";read opcion;
	   case $opcion in
		1) echo -ne "nueva fecha: ";read fecha
		   mysql agenda -e "UPDATE calendario SET fecha = ${fecha} WHERE id = ${id} ;";;
		2) echo -ne "nueva hora inicio: "; read hora_ini;
		   mysql agenda -e "UPDATE calendario SET hora_ini = ${hora_ini} WHERE id = ${id};";;
		3) echo -ne "nueva hora fin: "; read hora_fin;
		   mysql agenda -e "UPDATE calendario SET hora_fin = ${hora_fin} WHERE id = ${id};";;
		4) echo -ne "nueva todo_dia: "; read todo_dia;
		   mysql agenda -e "UPDATE calendario SET todo_dia = ${todo_dia} WHERE id = ${id};";;
		5) echo -ne "nueva descripcion: "; read descripcion;
		   mysql agenda -e "UPDATE calendario SET descripcion = ${descripcion} WHERE id = ${id};";;
	   esac
	   mysql agenda -e "SELECT * FROM calendario WHERE id  = '$id' ;"
       pausa;;
  esac
done
2LOG "Fin de sessión "$(whoami)" en agendasql "
echo -e "\033[13;1H"
#
#-----------------------------------------------------------------------------------------------------------------
#
# H I S T O R Y

# 2019/08/24	Version 1.0
#		* Puesta en marcha del modulo integrado
#
exit 0
