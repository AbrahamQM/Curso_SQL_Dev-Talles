SELECT * FROM city;

--vamos a intentar crear un índice unique que relacione como únicos name, countrycode y district
create unique index "unique_name_countrycode_disctrict" on city (
	name, countrycode, district
);
--Da este error:
--SQL Error [23505]: ERROR: could not create unique index "unique_name_countrycode_disctrict"
--Detail: Key (name, countrycode, district)=(Jinzhou, CHN, Liaoning) is duplicated.

-- hay campos duplicados para (Jinzhou, CHN, Liaoning) así que busco los registros duplicados
SELECT * FROM city
where name = 'Jinzhou' 
	and countrycode = 'CHN' 
	and district = 'Liaoning';
--devuelve:
--1944	Jinzhou	CHN	Liaoning	570000
--2238	Jinzhou	CHN	Liaoning	95761

--Modifico el segundo regristro para añadirle un Old al name para evitar los duplicados
update city set name = 'Jinzhou Old' where id = 2238;

-- ahora si puedo crear el índice único
create unique index "unique_name_countrycode_disctrict" on city (
	name, countrycode, district
);

--Ahora el profe pide tarea crear indice no único en district
create index "index_dictrict" on city(
	district
);

--drop index "index_dictrict"; --esto elimina el índice