

--Creamos un PROCEDIMIENTO para insertar regiones
--La sintaxis es casi idéntica al de las funciones
CREATE OR REPLACE PROCEDURE insert_region_proc(int, varchar) 
--Esta vez NO le indicamos nombre a los parámetros del 
--procedimiento para aprender otra forma de acceder a ellos.
AS 
$$
	BEGIN
		INSERT INTO regions( region_id, region_name)
			VALUES ($1, $2); --Accedemos a los valores por orden en lugar de por nombre
		ROLLBACK; --Añadimos un ROLLBACK para que NO almacene los cambios
	END;
$$
LANGUAGE plpgsql;

--Datos antes de usar el procedimiento
SELECT * FROM regions;
--region_id|region_name           |
-----------+----------------------+
--        1|Europe                |
--        2|Americas              |
--        3|Asia                  |
--        4|Middle East and Africa|


--Llamamos al procedimiento USANDO LA PALABRA CALL
CALL insert_region_proc(5, 'Central America');

--Los datos después de usar el procedimiento NO cambian porque tenemos un rollback
SELECT * FROM regions;
--region_id|region_name           |
-----------+----------------------+
--        1|Europe                |
--        2|Americas              |
--        3|Asia                  |
--        4|Middle East and Africa|


--Modificamos la función simulando una depuración
CREATE OR REPLACE PROCEDURE insert_region_proc(int, varchar) 
AS 
$$
	BEGIN
		INSERT INTO regions( region_id, region_name)
			VALUES ($1, $2); 
		--Usamos el mismo método que para lanzar la excepción en sesiones anteriores
		--Pero esta vez para lanzar informacion "RAISE NOTICE"
		RAISE NOTICE	'Variable 1: %, variable 2: %', $1, $2; 
		ROLLBACK; 
	END;
$$
LANGUAGE plpgsql;


--Llamamos a el procedimiento
CALL insert_region_proc(5, 'Central America');
--LA SALIDA ES:
--Variable 1: 5, variable 2: Central America
--Pero no se inserta nada poque seguimos teniendo el rollback


--Modificamos la función simulando una depuración añadiendo un commit
CREATE OR REPLACE PROCEDURE insert_region_proc(int, varchar) 
AS 
$$
	BEGIN
		INSERT INTO regions( region_id, region_name)
			VALUES ($1, $2); 

		RAISE NOTICE	'Variable 1: %, variable 2: %', $1, $2;
		--Ahora hago un commmit en lugar del ROLLBACK para comprobar los cambios.
		COMMIT;

	END;
$$
LANGUAGE plpgsql;

--Llamamos a el procedimiento
CALL insert_region_proc(5, 'Central America');
--LA SALIDA ES:
--Variable 1: 5, variable 2: Central America


--Los datos después de usar el procedimiento 
--OJO, ahora si cambian porque tenemos un commit en lugar del rollback
SELECT * FROM regions;
--region_id|region_name           |
-----------+----------------------+
--        1|Europe                |
--        2|Americas              |
--        3|Asia                  |
--        4|Middle East and Africa|
--        5|Central America       |


