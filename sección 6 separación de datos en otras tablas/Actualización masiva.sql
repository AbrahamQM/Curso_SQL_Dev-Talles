-- tras haber creado la copia de seguridad de la tabla country en Relación, checks y respaldo de country.sql
-- vamos a realizar la actualización masiva de la tabla 

select
	name,
	continent
from
	country;

--Obtenemos también el código de la tabla continent que hemos creado en 'tabla de continentes.sql'
select
	c.name,
	c.continent,
	(select code from continent b where b.name = c.continent ) as code_in_continent
from
	country c;
	
--Actualizamos la tabla country para insertar el id de la tabla continente en lugar de la relación
update country a
set continent = (select code from continent b where b.name = a.continent );

--comprobamos con 
select name, continent from country; 












