SELECT * FROM continent;

--Se pide que insertemos un par de continentes mas, para después realizar un ejericio
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent');
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent1');
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent2');

--EJERCICIO obtener los siquientes datos con un FULL OUTER JOIN
--country a - name, continentCode(código numérico)
--continent b - name as continentName
SELECT a."name" , a.continent AS continentCode, b."name" AS continentName 
FROM country a 
FULL OUTER JOIN continent b
ON a.continent = b.code 
ORDER BY a.continent  DESC ;
--name                                        |continentcode|continentname  |
----------------------------------------------+-------------+---------------+
--                                            |             |New Continent2 |
--                                            |             |New Continent  |
--                                            |             |New Continent1 |
--Ecuador                                     |            8|South America  |
--Bolivia                                     |            8|South America  |
--Argentina                                   |            8|South America  |
--Paraguay                                    |            8|South America  |
--...

--Vemos que trae también los elementos (continent.name) cuyo code no aparece en la tabla country

--De esta manera podemos ver los elementos que no se están utilizando.

