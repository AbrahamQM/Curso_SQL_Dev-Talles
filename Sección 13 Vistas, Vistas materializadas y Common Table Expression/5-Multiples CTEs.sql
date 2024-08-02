--MULTIPLE CTEs

--1ª consulta de  ejemplo, empezamos extrayendo el total de claps que sacamos por post
SELECT post_id, sum(counter) AS claps
FROM claps
GROUP BY post_id;
--post_id|claps|
---------+-----+
--    652|  180|
--    273|  149|
--     51|  221|
--    951|  234|
--    839|  213|

--2ª consulta de ejemplo, obtenemos los posts creados en 2023
SELECT post_id, title, created_at FROM posts p 
WHERE created_at BETWEEN  '2023-01-01' AND '2023-12-31';
--post_id|title                                                                 |created_at             |
---------+----------------------------------------------------------------------+-----------------------+
--      5|veniam consectetur incididunt commodo irure adipisicing irure pariatur|2023-10-12 01:08:30.634|
--     11|duis laborum esse velit mollit adipisicing cillum nisi sit            |2023-09-05 17:57:22.650|
--     12|tempor cupidatat Lorem est                                            |2023-09-25 07:18:10.608|
--     14|culpa Lorem cupidatat ipsum elit culpa aliquip                        |2023-01-16 10:54:46.791|


--Ahora vamos a obtener los resultados con mas claps de la primera consulta 
--que aparezcan en la segunda (2023)
--usando dos CTE
WITH claps_per_post AS (
	SELECT post_id, sum(counter) AS claps
	FROM claps
	GROUP BY post_id
	), posts_from_2023 AS (
	SELECT post_id, title, created_at FROM posts p 
	WHERE created_at BETWEEN  '2023-01-01' AND '2023-12-31'
	)
SELECT * FROM claps_per_post cpp
WHERE cpp.post_id IN (SELECT post_id FROM posts_from_2023)
ORDER BY cpp.claps desc
LIMIT 3;
--post_id|claps|
---------+-----+
--    955|  504|
--    198|  502|
--     78|  440|

