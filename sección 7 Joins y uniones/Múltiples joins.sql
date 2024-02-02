--Quiero saber los idionmas oficiales que se hablan por continente

--Los idiomas oficiales de cada país
SELECT c.countrycode, c."language"  FROM countrylanguage c
WHERE c.isofficial IS TRUE;
--countrycode|language      |
-------------+--------------+
--ABW        |Dutch         |
--AFG        |Dari          |
--AIA        |English       |
--...		  ...



--Cada país con su continente
SELECT c.code  AS countryCode, cont."name" AS continent FROM country c 
INNER JOIN continent cont
ON c.continent = cont.code ;
--country                                     |continent      |
----------------------------------------------+---------------+
--Antarctica                                  |Antarctica     |
--Aruba                                       |North America  |
--Afghanistan                                 |Asia           |
--...		  									...

--Mi solución
SELECT
	conts.continent contintente,
	c."language" AS idiomas_oficiales
FROM
	countrylanguage c
INNER JOIN 
	(
	SELECT
		c.code AS countryCode,
		cont."name" AS continent
	FROM
		country c
	INNER JOIN continent cont
	ON
		c.continent = cont.code 
	) AS conts
	ON
	c.countrycode = conts.countryCode
WHERE
	c.isofficial IS TRUE
GROUP BY idiomas_oficiales, contintente --Para unificar los idiomas que se hablan mas de una vez por continente
ORDER BY conts.continent ASC ;


--Solución del profesor
SELECT
	DISTINCT a.LANGUAGE,
	c.name AS contient
FROM
	countrylanguage a
INNER JOIN country b ON
	a.countrycode = b.code
INNER JOIN continent c ON
	b.continent = c.code
WHERE
	a.isofficial
ORDER BY
	c.name;


--Ejercicio 2: Quiero saber cuantos idionmas oficiales que se hablan por continente
SELECT count(*) AS languages, continent
FROM (
	SELECT
		DISTINCT a."language",
		c."name" AS continent
	FROM
		countrylanguage a
	INNER JOIN country b ON
		a.countrycode = b.code
	INNER JOIN continent c ON
		b.continent = c.code
	WHERE
		a.isofficial
	) AS totales
GROUP BY continent
ORDER BY languages;


--TAREA: obtener el mismo resultado que en la query de idiomas por continente pero
-- usando una relacion entre countrylanguage campo (languagecode)
-- y la tabla language

--Creo la relación que se pide
SELECT countrycode, language FROM "language" l 
INNER JOIN countrylanguage c 
ON l.code = c.languagecode ;

--aplico la relacion a la query
SELECT
	DISTINCT l."name" , --uso el valor de la columna LANGUAGE en lugar de contrylanguage
	c."name" AS continent
FROM
		countrylanguage a
INNER JOIN country b ON
		a.countrycode = b.code
INNER JOIN continent c ON
		b.continent = c.code
INNER JOIN "language" l ON
		l.code = a.languagecode
WHERE
		a.isofficial;
