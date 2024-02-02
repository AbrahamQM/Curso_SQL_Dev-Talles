select * from countrylanguage where isofficial = true;
select * from country;
select * from continent;
Select * from "language";

--*************** EJ 1*******************
-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

select languagecode , "language"  from countrylanguage where isofficial = true;--obtengo todos los idiomas y codigo que son oficiales

select code from continent WHERE name LIKE 'Europe'; --obtengo el código de contienente Europa (5)

--paises que pertenecen a europa
SELECT
	country.name
FROM
	country
INNER JOIN continent c
ON
	country.continent = c.code
WHERE
	c."name" LIKE 'Europe' ;

--Integro todo
SELECT
	count(*) AS paises,
	--Sumo la cantidad de paises que hablan cada idioma
	a.languagecode ,
	a."language"
FROM
	countrylanguage a
INNER JOIN
	country b 
	ON
	a.countrycode = b.code
WHERE
	b.continent = (
		SELECT
			code
		FROM
			continent
		WHERE
			name LIKE 'Europe'
		)
AND	
	isofficial = TRUE
GROUP BY
	languagecode,
	LANGUAGE
ORDER BY
	paises DESC
	--los ordeno 
LIMIT 1;-- selecciono solo el primero
--paises|languagecode|language|
--------+------------+--------+
--     6|         101|German  |


--Solución del profestor: Similar a la mía



--*************** EJ 2*******************

-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)
SELECT
	name
FROM
	country c
INNER JOIN countrylanguage c2 
ON
	c.code = c2.countrycode
WHERE
	c2."language" = (
		SELECT
			total.language
		FROM
			(
			SELECT
				count(*) AS paises,--Sumo la cantidad de paises que hablan cada idioma
			languagecode ,
			"language"
		FROM
			countrylanguage a
		INNER JOIN
			country b 
			ON a.countrycode = b.code
		WHERE 
			b.continent = (
						SELECT
							code
						FROM
							continent
						WHERE
							name LIKE 'Europe'
						)
		AND	
			isofficial = TRUE
		GROUP BY languagecode, LANGUAGE
		ORDER BY paises DESC --los ordeno 
		LIMIT 1-- selecciono solo el primero
		) AS total
	)
AND c2.isofficial ;
--name         |
---------------+
--Austria      |
--Belgium      |
--Switzerland  |
--Germany      |
--Liechtenstein|
--Luxembourg   |



--Solucion del profesor(No incluye las subquery): 
--El seleccionó el código del alemán para obtener el resultado (pero esto es por que cogió el resultado del ej 1)
SELECT * FROM country a
INNER JOIN countrylanguage b ON a.code = b.countrycode 
WHERE a.continent  = 5 
AND b.isofficial 
AND b.languagecode = 101;

