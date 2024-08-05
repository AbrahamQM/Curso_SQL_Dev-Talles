
--Tabla creada en la sesión 9 para queries recursivos
SELECT * FROM employees;
--id|name                |reports_to|
----+--------------------+----------+
-- 1|Jefe Carlos         |          |
-- 2|Sub-Jefe Susana     |         1|
-- 3|Sub-Jefe Juan       |         1|
-- 4|Gerente Pedro       |         3|
-- 5|Gerente Melissa     |         3|
-- 6|Gerente Carmen      |         2|
-- 7|Sub-Gerente Ramiro  |         5|
-- 8|Programador Fernando|         7|
-- 9|Programador Eduardo |         7|
--10|Presidente Carla    |          |

--Ahora queremos obtener de forma recursiva los elementos que dependen de el Jefe Juan directa o indirectamente
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to
	FROM employees
	WHERE id = 1
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
)
SELECT * FROM bosses;
--Resultado devuelve todos los que dependen directa o indirectamente de el empleado con id 1
--id|name                |reports_to|
----+--------------------+----------+
-- 1|Jefe Carlos         |          |
-- 2|Sub-Jefe Susana     |         1|
-- 3|Sub-Jefe Juan       |         1|
-- 4|Gerente Pedro       |         3|
-- 5|Gerente Melissa     |         3|
-- 6|Gerente Carmen      |         2|
-- 7|Sub-Gerente Ramiro  |         5|
-- 8|Programador Fernando|         7|
-- 9|Programador Eduardo |         7|


--Ahora quiero todos los que dependen de 'Gerente Melissa' delimitando por el nombre
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to
	FROM employees
	WHERE name = 'Gerente Melissa'
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
)
SELECT * FROM bosses;
--id|name                |reports_to|
----+--------------------+----------+
-- 5|Gerente Melissa     |         3|
-- 7|Sub-Gerente Ramiro  |         5|
-- 8|Programador Fernando|         7|
-- 9|Programador Eduardo |         7|


--Indroduzco un nuevo empleado que dependera de Programador Fernando
INSERT INTO employees 
VALUES ( nextval('employees_id_seq'), 'Jr. Mariano', (SELECT id FROM employees WHERE name = 'Programador Fernando'));
--id|name                |reports_to|
----+--------------------+----------+
-- 1|Jefe Carlos         |          |
-- 2|Sub-Jefe Susana     |         1|
-- 3|Sub-Jefe Juan       |         1|
-- 4|Gerente Pedro       |         3|
-- 5|Gerente Melissa     |         3|
-- 6|Gerente Carmen      |         2|
-- 7|Sub-Gerente Ramiro  |         5|
-- 8|Programador Fernando|         7|
-- 9|Programador Eduardo |         7|
--11|Jr. Mariano         |         8|


--Ahora obtengo todos los empleados que dependen de 'Sub-Gerente Ramiro'
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to
	FROM employees
	WHERE name = 'Sub-Gerente Ramiro' 
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
)
SELECT * FROM bosses;
--id|name                |reports_to|
----+--------------------+----------+
-- 7|Sub-Gerente Ramiro  |         5|
-- 8|Programador Fernando|         7|
-- 9|Programador Eduardo |         7|
--11|Jr. Mariano         |         8|
