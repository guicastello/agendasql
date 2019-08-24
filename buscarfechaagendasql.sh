#! /bin/bash
echo "============================="
echo " Busca por fecha Agenda-SQL "
echo "============================="
echo -ne "fecha: ";read fecha
mysql agenda -e "SELECT * FROM agenda.calendario WHERE fecha like '%"${fecha}"%';"
