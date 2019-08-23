#! /bin/bash
echo "======================+++++======="
echo " Busca por DEscripcion Agenda-SQL "
echo "===========================+++++=="
echo -ne "Descripcion: ";read descripcion
# echo -ne "Usuario: "; read usuario

echo "SELECT * FROM agenda.calendario WHERE descripcion  like '%"${descripcion}"%';" > /tmp/buscafechaagenda.sql
mysql agenda < /tmp/buscafechaagenda.sql > salida.txt
rm /tmp/buscafechaagenda.sql

if  [[ -s salida.txt ]]; then
	cat salida.txt;
else
	echo "No existen registros.";
fi
rm salida.txt

