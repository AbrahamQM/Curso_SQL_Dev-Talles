select	* from country;

-- vamos a crear una constraint 'check' para asegurarnos de que el surfacearea no sea negativo
alter table country add check(
surfacearea >= 0
);

-- ahora vamos a crear un CHECK CON MÚLTIPLES POSIBILIDADES "Strings"
select distinct(continent) from country;

--resultado:
--Asia
--South America
--North America
--Oceania
--Antarctica
--Africa
--Europe

-- vamos a hacer que solo se pudedan introducir registros que estén en ese listado
alter table country add check(
	(continent = 'Asia'::text) or  -- el ::text en este caso es opcional, pero es para indicarle el tipo de dato a la tabla
	(continent = 'South America'::text) or 
	(continent = 'North America'::text) or 
	(continent = 'Oceania'::text) or 
	(continent = 'Antarctica'::text) or 
	(continent = 'Africa'::text) or 
	(continent = 'Europe'::text) or
	(continent = 'Central America'::text) 
);


--ELIMINAR UNA CONSTRAINT
alter table country drop constraint "country_continent_check";

