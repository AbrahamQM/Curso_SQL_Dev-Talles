-- Tarea mostrar el país con mas ciudades
-- Campos: toal de ciudades y nombre del país
-- Condición Usar inner join
SELECT
	*
FROM
	country;

SELECT
	*
FROM
	city ;


--Obtengo el listado de paises ordenado por cantidad de ciudades y pongo límite 1
SELECT
	count(*) AS Total,
	b.name AS Pais
FROM
	city c
INNER JOIN country b ON
	b.code = c.countrycode
GROUP BY
	Pais
ORDER BY
	Total DESC
LIMIT 1;
--total|pais |
-------+-----+
--  363|China|