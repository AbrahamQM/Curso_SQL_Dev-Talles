


--Crearemos una función que devuelva una tabla de paises y regiones, algo así:
SELECT
	c.country_id,
	c.country_name,
	r.region_name 
FROM
	countries c
INNER JOIN regions r ON
	c.region_id = r.region_id ;
--country_id|country_name            |region_name           |
------------+------------------------+----------------------+
--AR        |Argentina               |Americas              |
--AU        |Australia               |Asia                  |
--BE        |Belgium                 |Europe                |
--BR        |Brazil                  |Americas              |
--CA        |Canada                  |Americas              |
--CH        |Switzerland             |Europe                |
--CN        |China                   |Asia                  |
--DE        |Germany                 |Europe                |
--DK        |Denmark                 |Europe                |
--EG        |Egypt                   |Middle East and Africa|
--FR        |France                  |Europe                |
--HK        |HongKong                |Asia                  |
--IL        |Israel                  |Middle East and Africa|
--IN        |India                   |Asia                  |
--IT        |Italy                   |Europe                |
--JP        |Japan                   |Asia                  |
--KW        |Kuwait                  |Middle East and Africa|
--MX        |Mexico                  |Americas              |
--NG        |Nigeria                 |Middle East and Africa|
--NL        |Netherlands             |Europe                |
--SG        |Singapore               |Asia                  |
--UK        |United Kingdom          |Europe                |
--US        |United States of America|Americas              |
--ZM        |Zambia                  |Middle East and Africa|
--ZW        |Zimbabwe                |Middle East and Africa|


CREATE OR REPLACE
FUNCTION country_region() 
	RETURNS TABLE (id CHARACTER(2), name varchar(40), region varchar(25))
	AS 
	$$
		BEGIN
			RETURN query 
				SELECT
					c.country_id,
					c.country_name,
					r.region_name
				FROM
					countries c
				INNER JOIN regions r ON
					c.region_id = r.region_id ;
		END;
	$$
	LANGUAGE plpgsql;
	

SELECT * FROM country_region();
--id|name                    |region                |
----+------------------------+----------------------+
--AR|Argentina               |Americas              |
--AU|Australia               |Asia                  |
--BE|Belgium                 |Europe                |
--BR|Brazil                  |Americas              |
--CA|Canada                  |Americas              |
--CH|Switzerland             |Europe                |
--CN|China                   |Asia                  |
--DE|Germany                 |Europe                |
--DK|Denmark                 |Europe                |
--EG|Egypt                   |Middle East and Africa|
--FR|France                  |Europe                |
--HK|HongKong                |Asia                  |
--IL|Israel                  |Middle East and Africa|
--IN|India                   |Asia                  |
--IT|Italy                   |Europe                |
--JP|Japan                   |Asia                  |
--KW|Kuwait                  |Middle East and Africa|
--MX|Mexico                  |Americas              |
--NG|Nigeria                 |Middle East and Africa|
--NL|Netherlands             |Europe                |
--SG|Singapore               |Asia                  |
--UK|United Kingdom          |Europe                |
--US|United States of America|Americas              |
--ZM|Zambia                  |Middle East and Africa|
--ZW|Zimbabwe                |Middle East and Africa|





