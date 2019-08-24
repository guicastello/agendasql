#! /bin/bash
echo "======================+++++======="
echo " Busca por DEscripcion Agenda-SQL "
echo "===========================+++++=="
echo -ne "Descripcion: ";read descripcion
mysql agenda -e "SELECT * FROM calendario WHERE descripcion like '%"${descripcion}"%';"
