--Docu oficial:
-- https://www.postgresql.org/docs/current/queries-with.html


--consulta para trabajar con ella
SELECT
	date_trunc('week'::TEXT,
	posts.created_at) AS weeks,
	sum(claps.counter) AS total_claps,
	count(DISTINCT posts.post_id) AS number_of_posts,
	count(*) AS number_of_claps
FROM
	posts
JOIN claps ON
	claps.post_id = posts.post_id
GROUP BY
	(date_trunc('week'::TEXT,
	posts.created_at))
ORDER BY
	(date_trunc('week'::TEXT,
	posts.created_at)) DESC;
-- weeks                  |total_claps|number_of_posts|number_of_claps|
-------------------------+-----------+---------------+---------------+
--2024-05-27 00:00:00.000|        130|              1|              3|
--2024-05-20 00:00:00.000|        604|              3|             10|
--2024-05-13 00:00:00.000|        601|              5|             12|
--2024-05-06 00:00:00.000|       1166|              5|             20|
--2024-04-29 00:00:00.000|        465|              3|              8|
-- ...
  
 -- ******************* CTE--WITH ****************************
 
 --sintaxis
-- WITH nombre_del_with AS ( consulta ) SELECT ( campos deseados) from nombre_del_with WHERE coondiones GORUP BY ...;
 
--Ej:
WITH posts_week AS (
	SELECT
		date_trunc('week'::TEXT,
		posts.created_at) AS weeks,
		sum(claps.counter) AS total_claps,
		count(DISTINCT posts.post_id) AS number_of_posts,
		count(*) AS number_of_claps
	FROM
		posts
	JOIN claps ON
		claps.post_id = posts.post_id
	GROUP BY
		(date_trunc('week'::TEXT,
		posts.created_at))
	ORDER BY
		(date_trunc('week'::TEXT,
		posts.created_at)) DESC --ojo, sin ;
	)
SELECT * FROM posts_week LIMIT 3;

--weeks                  |total_claps|number_of_posts|number_of_claps|
-------------------------+-----------+---------------+---------------+
--2024-05-27 00:00:00.000|        130|              1|              3|
--2024-05-20 00:00:00.000|        604|              3|             10|
--2024-05-13 00:00:00.000|        601|              5|             12|


--SUPONEMOS QUE QUEREMOS los posts de 2024 que tengan mas de 600 claps usando el with:
WITH posts_week AS (
	SELECT
		date_trunc('week'::TEXT,
		posts.created_at) AS weeks,
		sum(claps.counter) AS total_claps,
		count(DISTINCT posts.post_id) AS number_of_posts,
		count(*) AS number_of_claps
	FROM
		posts
	JOIN claps ON
		claps.post_id = posts.post_id
	GROUP BY
		(date_trunc('week'::TEXT,
		posts.created_at))
	ORDER BY
		(date_trunc('week'::TEXT,
		posts.created_at)) DESC --ojo, sin ;
	)
SELECT * FROM posts_week 
WHERE weeks BETWEEN '2024-01-01' AND '2024-12-31'
	AND total_claps > 600;
--weeks                  |total_claps|number_of_posts|number_of_claps|
-------------------------+-----------+---------------+---------------+
--2024-05-20 00:00:00.000|        604|              3|             10|
--2024-05-13 00:00:00.000|        601|              5|             12|
--2024-05-06 00:00:00.000|       1166|              5|             20|
--2024-04-22 00:00:00.000|       1086|              5|             20|
--...





