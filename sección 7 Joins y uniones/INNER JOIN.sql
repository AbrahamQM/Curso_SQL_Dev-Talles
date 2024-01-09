SELECT a.name, a.continent AS código_continente, b.name AS nombre_continente 
FROM country a
INNER JOIN continent b 
ON a.continent = b.code 
ORDER BY a."name" ;
