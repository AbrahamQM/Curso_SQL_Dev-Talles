--Incrementar dias, meses, años a la fecha del último contrato
SELECT 
	max(hire_date) AS fecha_original,
	max(hire_date) + INTERVAL '1 days' AS incrementado_1_dia,
	max(hire_date) + INTERVAL '1 months' AS incrementado_1_mes,
	max(hire_date) + INTERVAL '1 years' AS incrementado_1_año,
	max(hire_date) + INTERVAL '1 years' + INTERVAL '1 months'
	+ INTERVAL '1 days'AS incrementado_1año_1mes_y_1dia
FROM
	employees;
--fecha_original|incrementado_1_dia     |incrementado_1_mes     |incrementado_1_año     |incrementado_1año_1mes_y_1dia|
----------------+-----------------------+-----------------------+-----------------------+-----------------------------+
--    2000-01-04|2000-01-05 00:00:00.000|2000-02-04 00:00:00.000|2001-01-04 00:00:00.000|      2001-02-05 00:00:00.000|



--Crear un intervalo de días, meses o años en una fecha ej:
SELECT 
	MAKE_INTERVAL( YEARS := 15) AS quince_años,
	MAKE_INTERVAL( YEARS := date_part('year', now())::integer ) AS años,
	MAKE_INTERVAL( YEARS := date_part('month', now())::integer ) AS meses,
	MAKE_INTERVAL( YEARS := date_part('days', now())::integer ) AS dias; 
--quince_años|años      |meses  |dias   |
-------------+----------+-------+-------+
--   15 years|2024 years|2 years|5 years|



