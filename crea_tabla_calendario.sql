CREATE TABLE calendario (
	id int(8) not null auto_increment,
	fecha DATE,
	hora_ini TIME,
	hora_fin TIME,
	todo_dia BOOLEAN,
	descripcion VARCHAR(256),
	PRIMARY KEY (id)
);