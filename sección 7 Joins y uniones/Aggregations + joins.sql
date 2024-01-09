

--Imaginemos que queremos contar todos los contienentes que hay en county
SELECT
	count(*) AS quantity,
	continent
FROM
	country
GROUP BY
	continent
ORDER BY
	continent ASC;

--Devuelve esto (pero no es facilmente legible):
--quantity|continent|
----------+---------+
--      58|        1|
--       5|        2|
--      51|        3|
--       2|        4|
--      46|        5|
--      35|        6|
--      28|        7|
--      14|        8|

--Ejercicio:
--Hacer un inner join para que en lugar del code se muestre el name que está en la tabla continent
-- Odrenado por la cantidad de manera ascendente
SELECT
	count(*) AS quantity,
	b."name"
FROM
	country a
INNER JOIN continent b
ON
	a.continent = b.code
GROUP BY
	b."name"
ORDER BY
	quantity ASC;

--Devuelve
--quantity|name           |
----------+---------------+
--       2|Central America|
--       5|Antarctica     |
--      14|South America  |
--      28|Oceania        |
--      35|North America  |
--      46|Europe         |
--      51|Asia           |
--      58|Africa         |

--Pero esto no muestra los contienentes que no aparecen en la tabla country
--Para resolverlo debemos obtener los que no aparecen ni una vez como hicimos en la sesión RIGHT OUTER JOIN.sql
SELECT
	count(*) AS quantity, b.name AS continents_without_use
FROM
	country a
RIGHT JOIN continent b
ON
	b.code = a.continent
WHERE
	a.continent IS NULL 
GROUP BY continents_without_use;
--Resultado:
--quantity|continents_without_use|
----------+----------------------+
--       1|New Continent1        |
--       1|New Continent         |
--       1|New Continent2        |

--EL PROBLEMA ES QUE APARECE 1 EN LA CANTIDAD (ya que la consulta lo devuelve una vez cada uno),
--PERO EN LA TABLA country NO APARECEN
--ASÍ QUE DEBEMOS SUSTITUIR EL COUNT POR UN 0 PARA MOSTRAR EL RESULTADO REAL: 

SELECT
	0 AS quantity, b.name AS continents_without_use
FROM
	country a
RIGHT JOIN continent b
ON
	b.code = a.continent
WHERE
	a.continent IS NULL ;

--quantity|continents_without_use|
----------+----------------------+
--       0|New Continent         |
--       0|New Continent1        |
--       0|New Continent2        |

--Pero esto solo trae los elementos que no aparecen en la tabla country.

--SOLUCION:
--hacer una union entre ambas querys
SELECT
	count(*) AS quantity,
	b."name"
FROM
	country a
INNER JOIN continent b
ON
	a.continent = b.code
GROUP BY
	b."name"
UNION 
	(
		SELECT 0 AS quantity, b.name AS continents_without_use
	FROM
		country a
	RIGHT JOIN continent b
	ON
		b.code = a.continent
	WHERE
		a.continent IS NULL 
	)
ORDER BY
	quantity ASC;

--Esto trae el resultado esperado:
--quantity|name           |
----------+---------------+
--       0|New Continent1 |
--       0|New Continent  |
--       0|New Continent2 |
--       2|Central America|
--       5|Antarctica     |
--      14|South America  |
--      28|Oceania        |
--      35|North America  |
--      46|Europe         |
--      51|Asia           |
--      58|Africa         |



