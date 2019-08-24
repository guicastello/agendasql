#! /bin/bash
echo "============================================="
echo " Busca por fecha y modifica campo Agenda-SQL "
echo "============================================="
echo -ne "fecha: ";read fecha
mysql agenda -e "SELECT * FROM calendario WHERE fecha like '%"${fecha}"%';"
echo -e "Elija registro a modificar"
echo -ne "id: "; read id
echo -e "Elija campo a modificar\n"
echo -ne "1 fecha\t2 hora inicio\t3 hora fin\n"
echo -ne "4 todo el dia\t5 descripcion\n"
echo -ne "6 Cancelar\n"
echo -ne "opcion: ";read opcion
case $opcion in
	1) echo -ne "nueva fecha: ";read fecha
	   mysql agenda -e "UPDATE calendario SET fecha = '${fecha}' WHERE id  = ${id} ;";;
	2) echo -ne "nueva hora inicio: "; read hora_ini;
	   mysql agenda -e "UPDATE calendario SET hora_ini = '${hora_ini}' WHERE id  = ${id} ;";;
	3) echo -ne "nueva hora fin: "; read hora_fin;
	   mysql agenda -e "UPDATE calendario SET hora_fin = '${hora_fin}' WHERE id  = ${id} ;";;
	4) echo -ne "nueva todo_dia: "; read hora_ini;
	   mysql agenda -e "UPDATE calendario SET todo_dia = '${todo_dia}' WHERE id  = ${id} ;";;
	5) echo -ne "nueva descripcion: "; read hora_ini;
	   mysql agenda -e "UPDATE calendario SET descripcion = '${description}' WHERE id  = ${id} ;";;

esac
mysql agenda -e "SELECT * FROM calendario WHERE id  = ${id} ;"

