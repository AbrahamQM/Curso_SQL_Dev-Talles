SELECT * FROM country;

alter table country 
add primary key (code); 
-- en el primer intento da error: could not create unique index "country_pkey"
--Detail: Key (code)=(NLD) is duplicated.
select * from country where code = 'NLD'; --muestra que hay dos elementos con ese code
--Eliminamos uno de los dos registros para evitar duplicidad
begin;
delete from country where code = 'NLD' and code2 = 'NA';
rollback;
--- ahora si podemos añadir la clave primaria
alter table country 
add primary key (code); 