-- Resultado esperado:

-- Count Union - Tarea
-- Total |  Continent
-- 5	  | Antarctica
-- 28	  | Oceania
-- 46	  | Europe
-- 51	  | America  Aqui se deben unificar todos continentes que sean america
-- 51	  | Asia
-- 58	  | Africa

SELECT
	count(*) AS Total,
	c."name" AS Continent
FROM
	continent c
INNER JOIN country co
ON
	c.code = co.continent
WHERE
	c."name" NOT LIKE '%America%'
GROUP BY
	c."name"
UNION
SELECT
	sum(Total) AS Total ,
	'America' AS Continent
FROM
	(
	SELECT
		count(*) AS Total
	FROM
		continent c
	INNER JOIN country co
ON
		Continent = c.code
	WHERE
		c."name" LIKE '%America%'
	GROUP BY
		Continent
) AS Americas
ORDER BY
	Total,
	Continent ASC ;


--RESULTADO:
--total|continent |
-------+----------+
--    5|Antarctica|
--   28|Oceania   |
--   46|Europe    |
--   51|America   |
--   51|Asia      |
--   58|Africa    |


