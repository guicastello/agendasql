#! /bin/bash
echo "================================="
echo " Baja por Descripcion Agenda-SQL "
echo "================================="
echo -ne "Fecha: ";read fecha
mysql agenda -e "select * from calendario where fecha like '%"${fecha}"%';"
echo -ne "Ingrese Id a Borrar: "; read id
mysql agenda -e "DELETE FROM calendario WHERE  id = "${id}";"
mysql agenda -e "select * from calendario WHERE fecha like '%"${fecha}"%';"
