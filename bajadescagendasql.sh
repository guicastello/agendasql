#! /bin/bash
echo "======================+++++======="
echo " Baja por Descripcion Agenda-SQL "
echo "===========================+++++=="
echo -ne "Descripcion: ";read descripcion
mysql agenda -e "DELETE FROM calendario WHERE descripcion like '%"${descripcion}"%';"
