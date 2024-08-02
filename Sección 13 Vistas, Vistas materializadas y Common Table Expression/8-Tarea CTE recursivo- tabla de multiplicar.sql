--Hacer una tabla de multiplicar del 5 hasta el  5*5

WITH RECURSIVE multiplication_table(base, val, res) AS (
	SELECT 5 AS base, 0 AS val, 0 AS res
	UNION
		SELECT base, val + 1, (val + 1)  * base AS res
		FROM multiplication_table
		WHERE val < 5
)
SELECT * FROM multiplication_table;
--base|val|res|
------+---+---+
--   5|  0|  0|
--   5|  1|  5|
--   5|  2| 10|
--   5|  3| 15|
--   5|  4| 20|
--   5|  5| 25|