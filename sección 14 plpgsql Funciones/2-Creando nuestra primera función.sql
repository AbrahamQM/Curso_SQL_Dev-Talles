
--Documentación oficial:
--https://www.postgresql.org/docs/current/sql-createfunction.html

--Ejemplos de funciones

--El mayor
SELECT GREATEST(1, 2, 5, 9, 12);
--greatest|
----------+
--      12|

--el que no sea null de dos elementos
SELECT COALESCE ( NULL, 'Example text');
--coalesce    |
--------------+
--Example text|


SELECT COALESCE ( NULL, NULL, 1);
--coalesce|
----------+
--       1|

--**************Creamos una funcion*************
--Ojo da problemas poner comentarios dentro 

CREATE OR REPLACE FUNCTION  greet_employee( employee_name varchar) --Construccion
--Indicar lo que devuelve
--Usamos $$ como {, o, } en java 
--declaraciones en caso de ser necesario van justo debajo del primer $$
RETURNS varchar 
AS 
$$

	begin
		return 'Hola mundo';
	end;
$$
LANGUAGE plpgsql; --indicamos el lenguaje

--Llamada a la función
SELECT * FROM greet_employee('pepe');
--greet_employee|
----------------+
--Hola mundo    |



--Usamos el parámetro
CREATE OR REPLACE FUNCTION  greet_employee( employee_name varchar) 
RETURNS varchar 
AS 
$$

	begin
		return 'Hola ' || employee_name;
	end;
$$
LANGUAGE plpgsql; 

--La probamos
SELECT * FROM greet_employee('pepe');
--greet_employee|
----------------+
--Hola pepe     |



--Usamos la funcion para saludar a todos los empleados

SELECT greet_employee(first_name) AS Saludo
FROM employees e 
LIMIT 4;
--saludo        |
----------------+
--Hola Steven   |
--Hola Neena    |
--Hola Lex      |
--Hola Alexander|
