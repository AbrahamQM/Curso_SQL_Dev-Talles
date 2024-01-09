--ALTER SEQUENCE 'nombre de la secuencia' RESTART WITH 'el número que deseemos';

-- crear nuevos continentes

INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent');
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent1');
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent2');
--tras esto, la tabla contiene:
SELECT * FROM continent;
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
--   9|New Continent  |
--  10|New Continent1 |
--  11|New Continent2 |

--ahora elimino los elementos creados y la secuqncia continúa
DELETE FROM continent where code in (9, 10, 11);
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent3');
SELECT * FROM continent;
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
--  12|New Continent3 |

--voy a reiniciar la secuencia en 9
ALTER SEQUENCE continent_code_seq RESTART WITH 9;
INSERT INTO continent (code, name) values (nextval('continent_code_seq'), 'New Continent4');
SELECT * FROM continent;
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
--  12|New Continent3 |
--   9|New Continent4 |

--DEjo la tabla como estaba y la secuencia también
DELETE FROM continent where code in (12,9);
ALTER SEQUENCE continent_code_seq RESTART WITH 9;


--para ver el último número de secuencia
select last_value from continent_code_seq;
--Devuelve 9