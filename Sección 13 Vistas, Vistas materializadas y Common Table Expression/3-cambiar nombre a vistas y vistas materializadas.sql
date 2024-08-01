
--Documentación oficial:
-- https://www.postgresql.org/docs/8.3/sql-alterview.html --Ojo fijarnos en la version de postgres que usamos

--Nos damos cuenta de que los nombres de las vistas que hemos creado, no se corresponden con 
--los datos que nos devuelve, porque 
--comments_and_claps_per_week_view y comments_and_claps_per_week_mat_view
--no nos devuelven los comentarios de cada semana, sino que nos devuelve
--las claps y, los post de cada semana


--Vamos a cambiarle el nombre a las vistas:

ALTER VIEW comments_and_claps_per_week_view RENAME TO posts_and_claps_per_week_view; 

ALTER MATERIALIZED VIEW comments_and_claps_per_week_mat_view RENAME TO posts_and_claps_per_week_mat_view; 

