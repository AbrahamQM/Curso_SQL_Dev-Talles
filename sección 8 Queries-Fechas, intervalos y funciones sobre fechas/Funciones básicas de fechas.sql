SELECT * FROM employees ;

--Documentación oficial de fechas con postgres
https://www.postgresql.org/docs/8.1/functions-datetime.html
--Otra documentación interesante
https://www.postgresqltutorial.com/postgresql-date-functions/postgresql-date_part/

--Funciones básicas de fechas

--Now()
SELECT now() AS ahora; 
--ahora                        |
-------------------------------+
--2024-02-05 19:18:05.685 +0000|

-- CURRENT_DATE
SELECT current_date  AS Fecha_actual;
--fecha_actual|
--------------+
--  2024-02-05|


--Current_time
SELECT current_time AS Hora_actual;
--hora_actual   |
----------------+
--19:20:31 +0000|


--date_part()
SELECT 
	date_part('hours', now()) AS hora,
	date_part('minutes', now()) AS minutos,
	date_part('seconds', now()) AS segundos,
	date_part('days', now()) AS día,
	date_part('months', now()) AS mes,
	date_part('years', now()) AS año,
	date_part('decade', now()) AS decada,
	date_part('doy', now()) AS Dia_del_año,
	date_part('dow', now()) AS Dia_de_semana,
	date_part('quarter', now()) AS Trimestre,
	date_part('week', now()) AS semana;
--hora|minutos|segundos |día|mes|año   |decada|dia_del_año|dia_de_semana|trimestre|semana|
------+-------+---------+---+---+------+------+-----------+-------------+---------+------+
--19.0|   38.0|15.244026|5.0|2.0|2024.0| 202.0|       36.0|          1.0|      1.0|   6.0|



--Resumen
SELECT now() AS ahora, 
	current_date AS Fecha_actual,
	current_time AS Hora_actual; 
--ahora                        |fecha_actual|hora_actual   |
-------------------------------+------------+--------------+
--2024-02-05 19:22:27.399 +0000|  2024-02-05|19:22:27 +0000|






