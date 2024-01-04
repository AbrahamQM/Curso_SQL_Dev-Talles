SELECT * FROM country;

--Crear índice único por name 
create unique index "unique_country_name" on country(
	name
);

--Crear un indice por continente y comprobar si cambia la velocidad de respuesta
SELECT * FROM country where continent = 'Africa'; --sin crear el índice tarda 3-4ms

--este índice no es unique porque hay múltiples paises con el mismo continente
create index "country_continent" on country( 
	continent
);
--esto no lo hizo el profe pero por comprobar si cambia el tiempo
SELECT * FROM country where continent = 'Africa'; --tras crear el indice tarda hasta más(seguramente no lo estoy usando bien)



