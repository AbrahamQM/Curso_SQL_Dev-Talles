--Ejemplo con CTE recursivo Documentacion
--https://cursos.devtalles.com/courses/take/sql-con-postgres/lessons/47119961-ejemplo-sin-recursividad-preparacion#:~:text=Ejemplo%20con%20CTE%20recursivo

-- Datos de db
SELECT * FROM "user";
--id|name          |birthday  |
----+--------------+----------+
-- 1|Morgan Freeman|1937-06-01|
-- 2|Elon Musk     |1971-06-28|
-- 3|Keanu Reeves  |1964-09-02|
-- 4|Robin Williams|1951-07-21|
-- 5|Tom Hanks     |1956-07-09|
-- 6|Harrison Ford |1942-07-13|
-- 7|Nicole Kidman |1967-06-20|
-- 8|Julia Roberts |1967-10-28|
-- 9|Nicolas Cage  |1964-01-07|
--10|Bill Murray   |1950-10-21|
--11|Bruce Lee     |1940-11-27|

SELECT * FROM followers f ; --Está vacía, 

--El profesor inserta los valores a mano, tras lo cual quedan los siguientes resultados en followers
--id|leader_id|follower_id|
----+---------+-----------+
-- 1|        1|          2|
-- 2|        1|          3|
-- 3|        2|          6|
-- 4|        6|          9|
-- 5|        3|          8|
-- 6|        3|         11|
-- 7|        9|          1|


--query que obtenga el nombre de cada usuario y a quien siga en lugar de los id de la tabla follower sin CTE
SELECT l.name AS leader, fol.name AS follower
FROM followers f
INNER JOIN "user" l ON f.leader_id = l.id 
INNER JOIN "user" fol ON f.follower_id = fol.id ;
--leader        |follower      | --Folower debería se follows to, ya que Morgan Freeman seigue a Elon Musk y no al revés
----------------+--------------+ -- Pero el profesor lo hizo así
--Morgan Freeman|Elon Musk     |
--Morgan Freeman|Keanu Reeves  |
--Elon Musk     |Harrison Ford |
--Harrison Ford |Nicolas Cage  |
--Keanu Reeves  |Julia Roberts |
--Keanu Reeves  |Bruce Lee     |
--Nicolas Cage  |Morgan Freeman|


