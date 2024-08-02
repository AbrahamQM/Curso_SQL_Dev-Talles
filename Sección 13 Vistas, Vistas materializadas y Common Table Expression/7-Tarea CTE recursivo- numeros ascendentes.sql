--Realizar un CTE recursivo que devuelva números ascendentes 0 a 5.

WITH RECURSIVE counter(val) AS (
	SELECT 0 AS val
	UNION
		SELECT val + 1 
		FROM counter
		WHERE val < 5
)
SELECT * FROM counter;

--Resultado:
--val|
-----+
--  0|
--  1|
--  2|
--  3|
--  4|
--  5|

--ahora lo mismo pero en orden descendente usando el mismo CTE
WITH RECURSIVE counter(val) AS (
	SELECT 0 AS val
	UNION
		SELECT val + 1 
		FROM counter
		WHERE val < 5
)
SELECT * FROM counter
ORDER BY val desc;
--val|
-----+
--  5|
--  4|
--  3|
--  2|
--  1|
--  0|