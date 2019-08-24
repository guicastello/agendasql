#! /bin/bash
echo "==================="
echo " Alta Agenda-SQL "
echo "==================="
echo -ne "fecha: ";read fecha
echo -ne "hora inicio: "; read hini
echo -ne "hora fin: "; read hfin
echo -ne "todo el dia: "; read tld
echo -ne "Descripcion: "; read desc

mysql agenda -e "insert into agenda.calendario (fecha, hora_ini, hora_fin, todo_dia, descripcion) values ('$fecha', '$hini', '$hfin', '$tld', '$desc');"



