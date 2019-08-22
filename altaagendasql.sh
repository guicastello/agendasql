#! /bin/bash
echo "==================="
echo " Alta Agenda-SQL "
echo "==================="
echo -ne "fecha: ";read fecha
echo -ne "hora inicio: "; read hini
echo -ne "hora fin: "; read hfin
echo -ne "todo el dia: "; read tld
echo -ne "Descripcion: "; read desc
echo -ne "Usuario: "; read usuario
echo "insert into agenda.calendario (fecha, hora_ini, hora_fin, todo_dia, decripcion) values ('$fecha', '$hini', '$hfin', '$tld', '$desc');" > /tmp/altaagenda.sql
mysql -u $usuario agenda -p < /tmp/altaagenda.sql
rm /tmp/altaagenda.sql


