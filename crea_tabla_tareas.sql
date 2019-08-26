CREATE TABLE tareas (
	id int(8) not null auto_increment,
	titulo varchar(64),
	prioridad int(1),
	fecha_ini date),
	fecha_fin date,
	hora_ini time,
	hora_fin time,
	completada boolean,
	Notas varchar(512),
	PRIMARY KEY (id)
);