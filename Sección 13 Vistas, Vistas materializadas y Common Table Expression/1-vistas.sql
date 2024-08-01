
--DOCUMENTACIÓN OFICIAL
--https://www.postgresql.org/docs/current/sql-createview.html


--Supongamos que queremos agrupar los post por años
--Usaremos la función date_trunc.
SELECT date_trunc('week', created_at)AS weeks, count (*) 
FROM posts
GROUP BY weeks 
ORDER BY weeks DESC;
--weeks                  |count|
-----------------------+-----+
--2024-05-27 00:00:00.000|    1|
--2024-05-20 00:00:00.000|    3|
--2024-05-13 00:00:00.000|    5|
--2024-05-06 00:00:00.000|    5|
--2024-04-29 00:00:00.000|    3|
--2024-04-22 00:00:00.000|    5|
--2024-04-15 00:00:00.000|    5|
--2024-04-08 00:00:00.000|    2|
--2024-04-01 00:00:00.000|    5|
--2024-03-25 00:00:00.000|    5|
--...

--Lo mismo pero por años:
SELECT date_trunc('year', created_at)AS Years, count (*) 
FROM posts
GROUP BY Years 
ORDER BY Years DESC;
--years                  |count|
-----------------------+-----+
--2024-01-01 00:00:00.000|   94|
--2023-01-01 00:00:00.000|  231|
--2022-01-01 00:00:00.000|  231|
--2021-01-01 00:00:00.000|  263|
--2020-01-01 00:00:00.000|  231|

--Ahora vamos a modificar el post que tiene id= 1 para cambiarle el año del
--created_at y ponerle 2025 para tener solo uno con ese año
update posts p SET created_at = '2025-12-20'::date WHERE p.post_id = 1; 

SELECT created_at FROM posts p  WHERE p.post_id = 1; 
--created_at             |
-------------------------+
--2025-12-20 00:00:00.000|

SELECT date_trunc('year', created_at)AS Years, count (*) 
FROM posts
GROUP BY Years 
ORDER BY Years DESC;
--years                  |count|
-------------------------+-----+
--2025-01-01 00:00:00.000|    1|
--2024-01-01 00:00:00.000|   94|
--2023-01-01 00:00:00.000|  231|
--2022-01-01 00:00:00.000|  231|
--2021-01-01 00:00:00.000|  263|
--2020-01-01 00:00:00.000|  230|


--Ahora se pide saber el total de claps (counter) y posts por semana 
SELECT date_trunc('week', p.created_at) AS week, count( DISTINCT p.post_id) AS posts_of_the_week, sum( c.counter ) AS total_claps
FROM posts p 
INNER JOIN claps c ON c.post_id = p.post_id 
GROUP BY week
ORDER BY week DESC; 
--
--week                   |posts_of_the_week|total_claps|
-------------------------+-----------------+-----------+
--2025-12-15 00:00:00.000|                1|        108|
--2024-05-27 00:00:00.000|                1|        130|
--2024-05-20 00:00:00.000|                3|        604|
--2024-05-13 00:00:00.000|                5|        601|
--2024-05-06 00:00:00.000|                5|       1166|
--2024-04-29 00:00:00.000|                3|        465|
--2024-04-22 00:00:00.000|                5|       1086|
--...

--******************** CREAR UNA VISTA ******************************
-- ahora imaginemos que queremos obtener este dato muy a menudo,
--para ahorarnos realizar esta consulta cada vez, crearemos una vista.

CREATE VIEW comments_and_claps_per_week_view AS --esta es la sintaxis para la creación de vistas 
SELECT date_trunc('week', p.created_at) AS week, count( DISTINCT p.post_id) AS posts_of_the_week, sum( c.counter ) AS total_claps
FROM posts p 
INNER JOIN claps c ON c.post_id = p.post_id 
GROUP BY week
ORDER BY week DESC; 


--******************** USAR UNA VISTA ******************************
--para obtener el resultado simplemente:
SELECT * FROM comments_and_claps_per_week_view;
--week                   |posts_of_the_week|total_claps|
-------------------------+-----------------+-----------+
--2025-12-15 00:00:00.000|                1|        108|
--2024-05-27 00:00:00.000|                1|        130|
--2024-05-20 00:00:00.000|                3|        604|
--2024-05-13 00:00:00.000|                5|        601|
--2024-05-06 00:00:00.000|                5|       1166|
--2024-04-29 00:00:00.000|                3|        465|
--2024-04-22 00:00:00.000|                5|       1086|
--...


