#! /bin/bash
echo "==================="
echo " Backup Agenda-SQL "
echo "==================="
mysqldump agenda > agenda_`date +%Y-%m-%d_%H%M`.sql
