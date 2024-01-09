

-- EJERCICIO:
--Obtener un listado de todos los continentes que no tienen registros en la tabla de paises
--Utilizando un RIGHT OUTER JOIN CON EXCLUSIÓN
SELECT
	b.name AS continents_without_use
FROM
	country a
RIGHT JOIN continent b
ON
	b.code = a.continent
WHERE
	a.continent IS NULL ;
--Devuelve:

--continents_without_use|
------------------------+
--New Continent         |
--New Continent1        |
--New Continent2        |