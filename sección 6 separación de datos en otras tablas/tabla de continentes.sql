

--Crear una nueva tabla que se llame continent y que volquemos ahí todos los continentes
select distinct(continent) from country order by continent ;
--continent      |
-----------------+
--Africa         |
--Antarctica     |
--Asia           |
--Central America|
--Europe         |
--North America  |
--Oceania        |
--South America  |

-- el crea la tabla con el editor gráfico pero yo lo voy a hacer con SQL
CREATE TABLE continent (
	code SERIAL NOT NULL,
	name TEXT NOT NULL,
	PRIMARY KEY (code)
	);

-- ahora insertamos los diferentes continentes
insert
	into
	continent (name) 
select
	distinct(continent)
from
	country
order by
	continent ;
	
select * from continent;
--code|name           |
------+---------------+
--   1|Africa         |
--   2|Antarctica     |
--   3|Asia           |
--   4|Central America|
--   5|Europe         |
--   6|North America  |
--   7|Oceania        |
--   8|South America  |


