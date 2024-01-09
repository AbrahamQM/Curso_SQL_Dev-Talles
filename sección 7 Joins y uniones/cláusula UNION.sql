SELECT * FROM continent;

--Si nos piden todos los de américa,
SELECT * FROM continent where name like '%America%';

-- Ahora quieren todos los que tengan code que sea 1. 3 o 5
SELECT * FROM continent where code in (1,3,5);

-- Y si quisiéramos unir los resultados simplemente añadimos la cláusula UNION entre ambas consultas.
--IMPORTANTE: Ambas consultas deben devolver el mismo número de columnas o dará error
--Además el tipo de dato de cada columna debe ser el mismo para todos los resultados
SELECT * FROM continent where name like '%America%'
UNION
SELECT * FROM continent where code in (1,3,5)
order by name ASC;


--Ahora voy a incluir una 3ª columna donde indico la counsulta y lo voy a ordenar por esa columna
SELECT code, name, 'consulta1' as no_consulta FROM continent where name like '%America%'
UNION
SELECT code, name, 'consulta2' FROM continent where code in (1,3,5)
order by no_consulta ASC;
