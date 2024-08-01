--Una vista materializada es una copia de una vista en memoria.

--Si no actualizamos la vista materializada, los datos no se van a actualizar.


--Vamos a crear una vista materializada basándonos en la vista que creamos en la seccion anterior ver:
--vistas.sql
--solo hay que incluir la palabra materialized
CREATE MATERIALIZED	VIEW comments_and_claps_per_week_mat_view AS --esta es la sintaxis para la creación de vistas MATERIALIZADAS  
SELECT date_trunc('week', p.created_at) AS week, count( DISTINCT p.post_id) AS posts_of_the_week, sum( c.counter ) AS total_claps
FROM posts p 
INNER JOIN claps c ON c.post_id = p.post_id 
GROUP BY week
ORDER BY week DESC; 

--accedemos a los datos
SELECT * FROM comments_and_claps_per_week_mat_view;
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

-- es exactamente lo mismo que usar la vista no materializada que creamos en la otra sección
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


--******************** COMPROBAMOS QUE LOS DATOS NO SE ACTUALIZAN AUTOMÁTICAMENTE EN LA VISTA MATERIALIZADA


--Ahora ACTUALIZAMOS LA FECHA DE EL REGISTRO AL QUE LE PUSIMOS FECHA DE 2025
--le asignamos la misma fecha pero del año 2019
UPDATE posts SET created_at = '2019-12-15'::date WHERE post_id = 1;


SELECT created_at FROM posts p WHERE post_id = 1;
--created_at             |
-------------------------+
--2019-12-15 00:00:00.000|


--si pido los datos de la vista materializada, sigue apareciendo en primer lugar
SELECT * FROM comments_and_claps_per_week_mat_view LIMIT 5;
--week                   |posts_of_the_week|total_claps|
-------------------------+-----------------+-----------+
--2025-12-15 00:00:00.000|                1|        108|
--2024-05-27 00:00:00.000|                1|        130|
--2024-05-20 00:00:00.000|                3|        604|
--2024-05-13 00:00:00.000|                5|        601|
--2024-05-06 00:00:00.000|                5|       1166|


--Sin embargo si pido los datos de nuevo a la vista normal, al estar ordenados por semanas, 
--ese registro ya no aparece porque no está el primero, sino que es del año 2019
SELECT * FROM comments_and_claps_per_week_view LIMIT 5;
--week                   |posts_of_the_week|total_claps|
-------------------------+-----------------+-----------+
--2024-05-27 00:00:00.000|                1|        130|
--2024-05-20 00:00:00.000|                3|        604|
--2024-05-13 00:00:00.000|                5|        601|
--2024-05-06 00:00:00.000|                5|       1166|
--2024-04-29 00:00:00.000|                3|        465|


-- ************************** REFESCAR LA VISTA MATERIALIZADA ***********************************

--Para actualizar los datos de la vista materializada, utilizamos la palabra REFRESH MATERIALIZED VIEW nombre_de_la_vista;
REFRESH MATERIALIZED VIEW comments_and_claps_per_week_mat_view;

--consulto los datos para comprobar que se actualizaron
SELECT * FROM comments_and_claps_per_week_mat_view LIMIT 5;
-----------------------+-----------------+-----------+
--2024-05-27 00:00:00.000|                1|        130|
--2024-05-20 00:00:00.000|                3|        604|
--2024-05-13 00:00:00.000|                5|        601|
--2024-05-06 00:00:00.000|                5|       1166|
--2024-04-29 00:00:00.000|                3|        465|

--Ahora los datos si están actualizados
--selecciono el registro que hemos actualizado tiene date de 2019
SELECT * FROM comments_and_claps_per_week_mat_view ORDER BY week ASC LIMIT 2;
--week                   |posts_of_the_week|total_claps|
-------------------------+-----------------+-----------+
--2019-12-09 00:00:00.000|                1|        108|--------OJO------APARECE  LA FECHA 2019-12-09 PORQUE ES LA SEMANA DE ESE DÍA lo que seleccionamos en la vista
--2019-12-30 00:00:00.000|                3|        507|

-- o también
SELECT * FROM comments_and_claps_per_week_mat_view WHERE week = '2019-12-09'::date;
--week                   |posts_of_the_week|total_claps|
-------------------------+-----------------+-----------+
--2019-12-09 00:00:00.000|                1|        108|



