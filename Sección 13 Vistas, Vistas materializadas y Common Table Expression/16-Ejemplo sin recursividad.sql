

--Queremos mostrar sugerencias de seguidores a los usuarios 
--basándonos en las personas que ellos ya siguen

--Estado de los seguidores
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


--*************Queremos obtener los elementos seguidos jerárquicamente**********************
--Indicando por ejempo a Morgan Freeman que sigue a Elon Musk, que le puede interesas seguir a Harrison Ford
--Ya que Elon Musk sigue a Harrison ford.

--Obtenemos las sugerencias de seguidores (1 nivel) para Morgan Freeman

--(solución del profesor) 
SELECT * FROM followers f 
WHERE leader_id IN (
	SELECT follower_id 
	FROM followers 
	WHERE leader_id = 1); 
--id|leader_id|follower_id|
----+---------+-----------+
-- 3|        2|          6|
-- 5|        3|          8|
-- 6|        3|         11|

--(Mi solucion) Incluyendo los nombres y discriminando por el nombre en lugar del id
SELECT u1.name  AS sugguest
FROM "user" u1 
WHERE u1.id IN (
	SELECT f.follower_id FROM followers f
	WHERE f.leader_id IN (
		SELECT f2.follower_id FROM followers f2 		
		WHERE f2.leader_id IN (
			SELECT u2.id 
			FROM "user" u2 
			WHERE u2.name = 'Morgan Freeman'
			)
	)	
);
--sugguest     |         |
---------------+
--Harrison Ford|
--Julia Roberts|
--Bruce Lee    |


