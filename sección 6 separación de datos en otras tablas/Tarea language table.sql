

-- Tarea con countryLanguage

-- Crear la tabla de language

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS language_code_seq;


-- Table Definition
CREATE TABLE "public"."language" (
    "code" int4 NOT NULL DEFAULT 	nextval('language_code_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("code")
);

-- Crear una columna en countrylanguage
ALTER TABLE countrylanguage
ADD COLUMN languagecode varchar(3);


-- Empezar con el select para confirmar lo que vamos a actualizar
select * from language;-- tabla vacía
select * from countrylanguage;
select distinct(language) from countrylanguage;

select
	"language",
	(
	select
		code
	from
		"language" l
	where
		c."language" = l.name)
from
	countrylanguage c ;


-- Actualizar todos los registros
--++language
insert into language(name) 
	select distinct(language) from countrylanguage;

--++countrylanguage
select l.code as code, c.countrycode as country from language l, countrylanguage c where c.language = l.name;

update countrylanguage c
set languagecode = (select l.code from language l where c.language = l.name );


-- Cambiar tipo de dato en countrylanguage - languagecode por int4
alter table countrylanguage 
alter column languagecode type int4
	using languagecode::integer;

-- Crear el forening key y constraints de no nulo el language_code

alter table countrylanguage 
	add constraint fk_countrylanguage_language
	foreign key (languagecode)
	references language(code);

alter table countrylanguage 
alter column languagecode set not NULL;

-- Revisar lo creado
select * from countrylanguage;