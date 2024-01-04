

--=========================================================================================--
--=========================================================================================--
--VIDEO CREANDO LLAVE FORÁNEA

--Creamos la clabe foránea para country y city, donde el campo que los referencia es country.code y city.countrycode
--metemos la relación en la tabla city porque es la ciudad la que tiene un campo que hace referencia a la otra tabla.
alter table city 
	add constraint fk_country_code
	foreign key (countrycode)
	references country(code);
--Da el error 
--SQL Error [23503]: ERROR: insert or update on table "city" violates foreign key constraint "fk_country_code"
--Detail: Key (countrycode)=(AFG) is not present in table "country".
--reviso por que da ese error (no existe el re4gistro code (AFG) en country
select
	*
from
	country
where
	code = 'AFG';
-- no devuelve nada
--inserción que nos da el profe para insertar el país que falta
insert
	into
	country
values('AFG',
	'Afghanistan',
	'Asia',
	'Southern Asia',
	652860,
	1919,
	40000000,
	62,
	69000000,
	null,
	'Afghanistan',
	'Totalitarian',
	null,
	null,
	'AF');


--ahora volvemos a intentar crear la foreign key
alter table city 
	add constraint fk_country_code
	foreign key (countrycode)
	references country(code);
	

--=========================================================================================--
--=========================================================================================--
--SIGUIENTE VIDEO "Llave foránea con countrycode"
--Tarea, se pide crear la llave foránea con countryLanguage
select * from countrylanguage;
select * from country;

alter table countrylanguage  
	add constraint fk_country_code
	foreign key (countrycode)
	references country(code);
	
-- para eliminar esa foreign key sería con 
--ALTER TABLE public.countrylanguage DROP CONSTRAINT fk_country_code;

--=========================================================================================--
--=========================================================================================--
--SIGUIENTE VÍDEO "ON DELETE - CASCADE"
select * from country where code = 'AFG'; --devuelve un país
--AFG	Afghanistan	Asia	Southern Asia	652860.0	1919	40000000	62.0	69000000.00		Afghanistan	Totalitarian			AF


select * from city where countrycode = 'AFG'; --devuelve tres ciudades
--id|name          |countrycode|district|population|
----+--------------+-----------+--------+----------+
-- 2|Qandahar      |AFG        |Qandahar|    237500|
-- 3|Herat         |AFG        |Herat   |    186800|
-- 4|Mazar-e-Sharif|AFG        |Balkh   |    127800|

select * from countrylanguage where countrycode = 'AFG'; -- hay 4 idiomas en
countrycode|language  |isofficial|percentage|
-----------+----------+----------+----------+
AFG        |Dari      |true      |      32.1|
AFG        |Uzbek     |false     |       8.8|
AFG        |Turkmenian|false     |       1.9|
AFG        |Balochi   |false     |       0.9|

--Ahora se quiere que se borre en cascada todas las ciudades que corresponden a ese país
delete from country where code = 'AFG'; 
--da el error:
--SQL Error [23503]: ERROR: update or delete on table "country" violates foreign key constraint "fk_country_code" on table "city"
--  Detail: Key (code)=(AFG) is still referenced from table "city".

--El profe edita mediante el tableplus las foreign keys que las relaciona y les setea 'on delete'= Cascade
Con código hay que eliminar la fk y volver a crearla 
alter table public.city drop constraint fk_country_code;

alter table public.city add constraint fk_country_code foreign key (countrycode) references public.country(code) on
delete
	cascade;

alter table public.countrylanguage drop constraint fk_country_code;

alter table public.countrylanguage add constraint fk_country_code foreign key (countrycode) references public.country(code) on
delete
	cascade;


-- Ahora si puedo eliminar un país y además se eliminarán los idiomas y ciudades que dependen de este.
delete from country where code = 'AFG'; 

select * from country where code = 'AFG'; --no devuelve país
select * from city where countrycode = 'AFG'; --no devuelve ciudades
select * from countrylanguage where countrycode = 'AFG'; -- no devuielve idiomas
