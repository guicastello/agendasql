#! /bin/bash
echo "==================="
echo " Backup Agenda-SQL "
echo "==================="
echo -ne "usuario: ";read usuario
mysqldump -u${usuario} -p agenda > agenda_`date +%Y-%m-%d_%H%M`.sql
