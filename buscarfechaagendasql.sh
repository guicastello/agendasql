#! /bin/bash
echo "============================="
echo " Busca por fecha Agenda-SQL "
echo "============================="
echo -ne "fecha: ";read fecha
echo -ne "Usuario: "; read usuario

echo "SELECT * FROM agenda.calendario WHERE fecha='$fecha';" > /tmp/buscafechaagenda.sql
mysql -u $usuario agenda -p < /tmp/buscafechaagenda.sql > salida.txt
rm /tmp/buscafechaagenda.sql

if  [[ -s salida.txt ]]; then
	cat salida.txt|tail -1|xargs;
else
	echo "No existen registros.";
fi
rm salida.txt

