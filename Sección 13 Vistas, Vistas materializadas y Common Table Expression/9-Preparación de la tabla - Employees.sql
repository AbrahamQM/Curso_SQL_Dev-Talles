

--Creamos una tabla de ejemplo para hacer consultas recursivas (el profesor la crea con tablepus en lugar de con código)
CREATE TABLE employees (
	id serial,
	name varchar(60),
	reports_to integer);
	
SELECT * FROM employees;
TRUNCATE TABLE employees;
ALTER SEQUENCE employees_id_seq RESTART WITH 1;



--Insertamos valores iniciales
INSERT INTO employees 
VALUES ( nextval('employees_id_seq'), 'Jefe Carlos', null),
	( nextval('employees_id_seq'), 'Sub-Jefe Susana', 1),
	( nextval('employees_id_seq'), 'Sub-Jefe Juan', 1),
	( nextval('employees_id_seq'), 'Gerente Pedro', 3),
	( nextval('employees_id_seq'), 'Gerente Melissa', 3),
	( nextval('employees_id_seq'), 'Gerente Carmen', 2),
	( nextval('employees_id_seq'), 'Sub-Gerente Ramiro', 5),
	( nextval('employees_id_seq'), 'Programador Fernando', 7),
	( nextval('employees_id_seq'), 'Programador Eduardo', 7),	
	( nextval('employees_id_seq'), 'Presidente Carla', null);


