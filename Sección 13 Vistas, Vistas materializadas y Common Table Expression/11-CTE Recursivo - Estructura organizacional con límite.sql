

--Uso de variables de control.
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to, 0 AS DEPTH --aqui introduzco la profundidad DEPTH (variable de control)
	FROM employees
	WHERE name = 'Gerente Melissa'
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to , DEPTH + 1 --aqui incremento la profundidad 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
)
SELECT * FROM bosses;

--id|name                |reports_to|depth|
----+--------------------+----------+-----+
-- 5|Gerente Melissa     |         3|    0|
-- 7|Sub-Gerente Ramiro  |         5|    1|
-- 8|Programador Fernando|         7|    2|
-- 9|Programador Eduardo |         7|    2|
--11|Jr. Mariano         |         8|    3|


--Ahora uso la profundidad para indicar un límite
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to, 0 AS DEPTH --aqui introduzco la profundidad DEPTH (variable de control)
	FROM employees
	WHERE name = 'Gerente Melissa'
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to , DEPTH + 1 --aqui incremento la profundidad 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
		WHERE DEPTH < 2 -- aqui le indico que solo quiero 2 niveles de profundidad
)
SELECT * FROM bosses;

--id|name                |reports_to|depth|
----+--------------------+----------+-----+
-- 5|Gerente Melissa     |         3|    0|
-- 7|Sub-Gerente Ramiro  |         5|    1|
-- 8|Programador Fernando|         7|    2|
-- 9|Programador Eduardo |         7|    2|

---Muestro toda la estructura organizacional de la empresa con los niveles de profundidad
WITH RECURSIVE bosses AS (
	--initialization
	SELECT id, name, reports_to, 0 AS DEPTH --aqui introduzco la profundidad DEPTH (variable de control)
	FROM employees
	WHERE reports_to IS NULL --le indico que me seleccione como valores iniciales los que NO dependen de nadie
	UNION
	--recursive area
		SELECT e.id, e.name, e.reports_to , DEPTH + 1 --aqui incremento la profundidad 
		FROM employees e
		INNER JOIN bosses b ON b.id = e.reports_to
)
SELECT * FROM bosses;

--id|name                |reports_to|depth|
----+--------------------+----------+-----+
-- 1|Jefe Carlos         |          |    0|
--10|Presidente Carla    |          |    0|
-- 2|Sub-Jefe Susana     |         1|    1|
-- 3|Sub-Jefe Juan       |         1|    1|
-- 4|Gerente Pedro       |         3|    2|
-- 5|Gerente Melissa     |         3|    2|
-- 6|Gerente Carmen      |         2|    2|
-- 7|Sub-Gerente Ramiro  |         5|    3|
-- 8|Programador Fernando|         7|    4|
-- 9|Programador Eduardo |         7|    4|
--11|Jr. Mariano         |         8|    5|