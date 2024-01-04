select * from country;

--crear una coppia de la tabla country antes de hacer modificaciones.

--1 copio el ddl de la tabla country y le modifico el nombre 
CREATE TABLE public.country_backup (
	code bpchar(3) NOT NULL,
	"name" text NOT NULL,
	continent text NOT NULL,
	region text NOT NULL,
	surfacearea float4 NOT NULL,
	indepyear int2 NULL,
	population int4 NOT NULL,
	lifeexpectancy float4 NULL,
	gnp numeric(10, 2) NULL,
	gnpold numeric(10, 2) NULL,
	localname text NOT NULL,
	governmentform text NOT NULL,
	headofstate text NULL,
	capital int4 NULL,
	code2 bpchar(2) NOT NULL,
	CONSTRAINT country_continent_check CHECK (((continent = 'Asia'::text) OR (continent = 'South America'::text) OR (continent = 'North America'::text) OR (continent = 'Oceania'::text) OR (continent = 'Antarctica'::text) OR (continent = 'Africa'::text) OR (continent = 'Europe'::text) OR (continent = 'Central America'::text))),
	PRIMARY KEY (code),
	CONSTRAINT country_surfacearea_check CHECK ((surfacearea >= (0)::double precision))
);

--2 Hacer el volcado de los datos en country_backup
insert into public.country_backup (
	code, name,	continent, region, surfacearea,	indepyear, population, lifeexpectancy, gnp, gnpold , localname,
	governmentform, headofstate, capital, code2) --LOS CAMPOS SE PUEDEN OBVIAR
	select * from country;

select COUNT(*) from country_backup; --239 REGISTROS
select COUNT(*) from country;--239 REGISTROS

-- Eliminamos el check del campo continent
 alter table country drop constraint country_continent_check;
 
 
