--Obtener los años que lleva cada traabajador contratado

SELECT
	first_name AS nombre, 
	hire_date AS fecha_contrato,
	MAKE_INTERVAL( YEARS := 
		date_part( 'year',	current_date)::integer 
		- 
		EXTRACT(YEARS FROM hire_date)::integer)
	AS años_trabajados
FROM
	employees
ORDER BY años_trabajados ASC  ;

--nombre     |fecha_contrato|años_trabajados|
-------------+--------------+---------------+
--Charles    |    2000-01-04|       24 years|
--Luis       |    1999-12-07|       25 years|
--...		 | ...			|		...		|
--Alexander  |    1990-01-03|       34 years|
--Neena      |    1989-09-21|       35 years|
--Steven     |    1987-06-17|       37 years|
--Jennifer   |    1987-09-17|       37 years|



--TAREA:
--actualizar la base de datos de empleados sumándole 24 años
--a la fecha de contratación sin ejecutar funciones para obtener el año
--el año debe ir hard-coded
--SENTENCIAS PARA EVITAR AUTOCOMMIT(por seguridad)
BEGIN; --comienzo de la query
ROLLBACK; --para deshacer los cambios si hay error
COMMIT; --para confirmar los cambios

--ACTUALIZO
UPDATE employees 
SET hire_date = hire_date + INTERVAL '24 years';


--COMPRUEBO LOS CAMBIOS
SELECT
	first_name AS nombre, 
	hire_date AS fecha_contrato,
	MAKE_INTERVAL( YEARS := 
		date_part( 'year',	current_date)::integer 
		- 
		EXTRACT(YEARS FROM hire_date)::integer)
	AS años_trabajados
FROM
	employees
ORDER BY años_trabajados ASC  ;
--nombre     |fecha_contrato|años_trabajados|
-------------+--------------+---------------+
--Charles    |    2024-01-04|       00:00:00|
--Luis       |    2023-12-07|         1 year|
--...			...				...
--Steven     |    2011-06-17|       13 years|
--Jennifer   |    2011-09-17|       13 years|

