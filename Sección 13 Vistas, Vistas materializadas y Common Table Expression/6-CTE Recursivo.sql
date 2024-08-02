--CTE Recursivo

--Documentacion oficial
--https://www.postgresql.org/docs/15/queries-with.html


--sintasis:
--WITH RECURSIVE nombre(nombres de los campos/valores separados por comas) AS (
--	--inicializacion o 1º nivel
--	UNION
--	--query recursiva
--	)
-- SELECT campos
-- ...;

WITH RECURSIVE countdown( val ) AS (
	SELECT 5 AS val
	UNION
		SELECT val -1 
		FROM countdown
		WHERE val > 1
	)
SELECT * FROM countdown;
--Ojo la funcion recursiva resta 1 al valor siempre que cumpla la condición, 
--Por eso aunque la condición sea que es > 1, cuando es 2, el resultado de la función es 1
--val|
-----+
--  5|
--  4|
--  3|
--  2|
--  1|