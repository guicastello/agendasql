CREATE USER 'guillermo'@'%' IDENTIFIED BY 'Jajat3jod1!';
GRANT ALL PRIVILEGES ON agenda.* TO 'guillermo'@'%' WITH GRANT OPTION;
CREATE USER 'guillermo'@'localhost' IDENTIFIED BY 'Jajat3jod1!';
GRANT ALL PRIVILEGES ON agenda.* TO 'guillermo'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
