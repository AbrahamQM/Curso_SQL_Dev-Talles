-- después de Actualización masiva.sql


--procedemos a cambiar el tipo de dato de country a int4 para que sea igual que el continent
ALTER TABLE country ALTER COLUMN continent TYPE int4;
--da este error:
--SQL Error [42804]: ERROR: column "continent" cannot be cast automatically to type integer
--  Hint: You might need to specify "USING continent::integer".

--solución
ALTER TABLE country 
ALTER COLUMN continent TYPE int4
USING continent::integer;

--Establecemos la relación de country.continent con la tabla continent
 alter table country 
	add constraint fk_country_continent
	foreign key (continent)
	references continent(code);
	
select * from country;
select * from continent;

-- ya podemos eliminar la tabla country_backup para no tener datos innecesarios
drop table country_backup; 

