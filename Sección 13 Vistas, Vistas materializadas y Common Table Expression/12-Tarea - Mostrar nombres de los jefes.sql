
--Mostrar el nombre de la persona de la que depende directamente cada empleado en lugar del reports_to
--Empezar con Jefe Carlos, obviando a Presidente Carla

WITH RECURSIVE organization AS (
	SELECT id, name, 'himself'::text AS boss_name, reports_to, 0 AS depth 
	FROM employees WHERE id = 1
	UNION
	SELECT e.id,  e.name, o.name, e.reports_to, depth + 1
	FROM employees e
	INNER JOIN organization o ON o.id = e.reports_to
)
SELECT id, name, boss_name, depth FROM organization;

--id|name                |boss_name           |depth|
----+--------------------+--------------------+-----+
-- 1|Jefe Carlos         |himself             |    0|
-- 2|Sub-Jefe Susana     |Jefe Carlos         |    1|
-- 3|Sub-Jefe Juan       |Jefe Carlos         |    1|
-- 4|Gerente Pedro       |Sub-Jefe Juan       |    2|
-- 5|Gerente Melissa     |Sub-Jefe Juan       |    2|
-- 6|Gerente Carmen      |Sub-Jefe Susana     |    2|
-- 7|Sub-Gerente Ramiro  |Gerente Melissa     |    3|
-- 8|Programador Fernando|Sub-Gerente Ramiro  |    4|
-- 9|Programador Eduardo |Sub-Gerente Ramiro  |    4|
--11|Jr. Mariano         |Programador Fernando|    5|


-- Solución del profesor:
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to, 0 AS DEPTH --aqui introduzco la profundidad DEPTH (variable de control)
	FROM employees
	WHERE id = 1
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to , DEPTH + 1 --aqui incremento la profundidad 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
)
SELECT b.*, e."name" AS reports_to_name FROM bosses b
LEFT JOIN employees e ON e.id = b.reports_to
order BY depth asc;
--id|name                |reports_to|depth|reports_to_name     |
----+--------------------+----------+-----+--------------------+
-- 1|Jefe Carlos         |          |    0|                    |
-- 2|Sub-Jefe Susana     |         1|    1|Jefe Carlos         |
-- 3|Sub-Jefe Juan       |         1|    1|Jefe Carlos         |
-- 4|Gerente Pedro       |         3|    2|Sub-Jefe Juan       |
-- 6|Gerente Carmen      |         2|    2|Sub-Jefe Susana     |
-- 5|Gerente Melissa     |         3|    2|Sub-Jefe Juan       |
-- 7|Sub-Gerente Ramiro  |         5|    3|Gerente Melissa     |
-- 9|Programador Eduardo |         7|    4|Sub-Gerente Ramiro  |
-- 8|Programador Fernando|         7|    4|Sub-Gerente Ramiro  |
--11|Jr. Mariano         |         8|    5|Programador Fernando|
