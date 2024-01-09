

select a.name, a.continent from country a;
-- Aquí obtenemos el nombre y el código del continente.


--Ahora queremos obtener el nombre del continente que está en la tabla continent
--FORMA CON WHERE (que explica el profe en clase)
select a.name as country, b.name as continent 
from country a, continent b
where a.continent = b.code
order by country;



--FORMA CON UN INNER JOIN (me adelanto a la siguiente lección para comprobar como sería)
--Para ello debemos unir ambas tablas como se ve a continuación
--buscando la clave foránea común
SELECT a.name, a.continent as código_continente, b.name as nombre_continente 
from country a
inner join continent b 
on a.continent = b.code ;
