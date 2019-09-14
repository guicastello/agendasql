#!/bin/bash

### Definicion de Variables ###
opcion=0					# se usa para elegir qué tarea se va a realizar
bold="\033[1m"					# Pone los atributos del texto en "Bold".
rset="\033[0m"					# Desactiva los Atributos del texto.
rvrs="\033[7m"					# Invierte el texto
ylow="\033[33m"					# Letras en Amarillo
fdoa="\033[44m"					# Letras en Blancas con fondo azul.
subr="\033[4m"					# Letras subrayadas
hoy="$(date +%Y-%m-%d)"				# obtengo la fecha del día de hoy (YYYY/MM/DD)
efe="$(date +-%m-%d)"				# fecha dia/mes para efemerides
VERSION="V1.0"					# Version
LOG="tareassql-"$VERSION".log"			# Nombre del log 
backup="~/agendasql/backup"			# PATH al backup

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
		echo -e "\t\t\t\t"$subr$bold$ylow"Bitácora SQL - Modulo Tareas"$rset"\tversion: "$VERSION
		echo -e "=============================================================================================="
		cal
		echo -ne "\033[4;21H | "
		echo -ne "\033[5;21H | "
		echo -e " 1) Alta\t\t\t4) Busca x fecha fin\t7) Modifica registro"
		echo -ne "\033[6;21H | "
		echo -e " 2) Borra tarea\t\t5) Tareas Incompletas\t8) Cierra Tareas"
		echo -ne "\033[7;21H | "
		echo -e " 3) Tareas de Hoy\t6) Backup\t\t9) Salir"
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
	   echo -ne "Titulo: "; read titulo;
	   echo -ne "Prioridad: "; read prioridad;
	   echo -ne "fecha inicio: ";read fecha_ini;
	   echo -ne "hora inicio: "; read hini;
	   echo -ne "fecha fin:"; read fecha_fin;
	   echo -ne "hora fin: "; read hfin;
	   echo -ne "Completa: "; read completada;
	   echo -ne "Descripcion: "; read Notas;
	   mysql agenda -e "insert into agenda.tareas (titulo, prioridad,fecha_ini,hora_ini,fecha_fin,hora_fin,completada,Notas) values ('${titulo}', '${prioridad}', '${fecha_ini}', '${hora_ini}', '${fecha_fin}', '${hora_fin}', '${completada}', '${Notas}');";
       pausa;
       2LOG "Alta de registro.";;

	2) mcur;
	   echo -e " > Borrar registro por titulo";
	   echo -ne "Fecha: ";read titulo;
	   mysql agenda -e "select * from tareas where fecha like '%"${titulo}"%';";
           echo -ne "Ingrese Id a Borrar: "; read id;
           mysql agenda -e "DELETE FROM tareas WHERE  id = "${id}";";
           mysql agenda -e "select * from tareas WHERE fecha like '%"${titulo}"%';";
	   pausa;
	   2LOG "Borrado titulo "$titulo;;

	3) mcur;
	   echo " > Tareas para el dia de hoy";
	   echo -e "\033[31;33;1m	- Tareas vencidas:\n";
       mysql agenda -e "SELECT * FROM tareas WHERE fecha_fin < CURDATE() AND completada = 'FALSE';";
	   echo -e $rset"	- Tareas que vencen hoy:\n";
       mysql agenda -e "SELECT * FROM tareas WHERE fecha_fin = CURDATE();";
      
       echo -e $rset;   
       pausa;
       2LOG "Agenda de Hoy";;

	4) mcur;
	   echo -e " > Busqueda por fecha de fin";
	   echo -ne "fecha fin: ";read fecha_fin;
	   mysql agenda -e "SELECT * FROM tareas WHERE fecha_fin like '%"${fecha_fin}"%';";
	   pausa;
	   2LOG "Busqueda de tareas por Fecha de Fin"$fecha_fin;;

	5) mcur;
	   echo -e " > Busqueda Tareas Imcompletas\n";
	   mysql agenda -e "SELECT * FROM tareas WHERE completada = 'FALSE';";
	   pausa;
	   2LOG "Busqueda de tareas Incompletas"$fecha_ini;;

	6) mcur;
	   echo -e " > Backup agendasql";
	   mysqldump agenda > ~/agendasql/backups/agenda_`date +%Y-%m-%d_%H%M`.sql;
	   echo -e $bold"Backup OK"$rset;
	   pausa;
	   2LOG "Back up agenda";;

	7) mcur;
	   echo -ne "fecha inicio: ";read fecha_ini;
	   mysql agenda -e "SELECT * FROM tareas WHERE fecha_ini like '%"${fecha_ini}"%';";
	   echo -e " > Elija registro a modificar";
	   echo -ne "id: "; read id;
	   echo -e " > Elija campo a modificar:\n";
	   echo -e $rvrs"1"$rset" titulo "$rvrs"2"$rset" prioridad "$rvrs"3"$rset" fecha inicio "$rvrs"4"$rset" fecha fin "$rvrs"5"$rset" hora inicio "$rvrs"6"$rset" hora fin "$rvrs"7"$rset" completada "$rvrs"8"$rset" notas "$rvrs"9"$rset" cancelar";
	   echo -ne "opcion: ";read opcion;
	   case $opcion in
		1) echo -ne "nueva titulo: ";read titulo;
		   mysql agenda -e "UPDATE tareas SET titulo = ${titulo} WHERE id = ${id} ;";;
		2) echo -ne "nueva prioridad: "; read prioridad;
		   mysql agenda -e "UPDATE tareas SET prioridad = ${prioridad} WHERE id = ${id};";;
		3) echo -ne "nueva fecha inicio: "; read fecha_ini;
		   mysql agenda -e "UPDATE tareas SET fecha_ini = ${fecha_ini} WHERE id = ${id};";;
		4) echo -ne "nueva fecha fin: "; read fecha_fin;
		   mysql agenda -e "UPDATE tareas SET fecha_fin = ${fecha_fin} WHERE id = ${id};";;
		5) echo -ne "nueva hora inicio: "; read hora_ini;
		   mysql agenda -e "UPDATE tareas SET hora_ini = ${hora_ini} WHERE id = ${id};";;
		6) echo -ne "nueva hora fin: "; read hora_ini;
		   mysql agenda -e "UPDATE tareas SET hora_fin = ${hora_fin} WHERE id = ${id};";;
		7) echo -ne "nueva completada: "; read completada;
		   mysql agenda -e "UPDATE tareas SET completada = ${completada} WHERE id = ${id};";;
		8) echo -ne "nueva hora inicio: "; read notas;
		   mysql agenda -e "UPDATE tareas SET Notas = ${notas} WHERE id = ${id};";;
	   esac
	   mysql agenda -e "SELECT * FROM tareas WHERE id  = '$id' ;"
	   2LOG "Modificacion registro de Tareas"
       pausa;;
	   
	 8) mcur;
	    echo -e " > Cierre de Tareas\n";
	    mysql agenda -e "SELECT * FROM tareas WHERE completada = 'FALSE';";
	    echo -ne "Ingrese Id de la tarea a completar: "; read id;
		mysql agenda -e "UPDATE tareas SET completada = "TRUE" WHERE id = ${id};";
		mysql agenda -e "SELECT * FROM tareas WHERE id = ${id};";
	    2LOG "Cierre de tareas"$fecha_ini;
	    pausa;;
  esac
done
2LOG "Fin de sessión "$(whoami)" en tareassql "
echo -e "\033[13;1H"
#
#-----------------------------------------------------------------------------------------------------------------
#
# H I S T O R Y

# 2019/08/24	Version 1.0
#		* Puesta en marcha del modulo integrado
# 2019/08/27
#		* Creacion modilo de tareas
exit 0
