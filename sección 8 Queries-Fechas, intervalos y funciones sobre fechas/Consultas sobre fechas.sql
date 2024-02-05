SELECT
	*
FROM
	employees ;
--Ejemplo obteniendo los empleados contratados despues de 1998 ordenamdo por fecha de manera ascendente
SELECT
	*
FROM
	employees
WHERE
	hire_date > '1998-01-01'
ORDER BY
	hire_date ASC;
--employee_id|first_name |last_name  |email                            |phone_number|hire_date |job_id|salary |manager_id|department_id|
-------------+-----------+-----------+---------------------------------+------------+----------+------+-------+----------+-------------+
--        106|Valli      |Pataballa  |valli.pataballa@sqltutorial.org  |590.423.4560|1998-02-05|     9|4800.00|       103|            6|
--        112|Jose Manuel|Urman      |jose manuel.urman@sqltutorial.org|515.124.4469|1998-03-07|     6|7800.00|       108|           10|
--        176|Jonathon   |Taylor     |jonathon.taylor@sqltutorial.org  |            |1998-03-24|    16|8600.00|       100|            8|
--        177|Jack       |Livingston |jack.livingston@sqltutorial.org  |            |1998-04-23|    16|8400.00|       100|            8|
--        126|Irene      |Mikkilineni|irene.mikkilineni@sqltutorial.org|650.124.1224|1998-09-28|    18|2700.00|       120|            5|
--        118|Guy        |Himuro     |guy.himuro@sqltutorial.org       |515.127.4565|1998-11-15|    13|2600.00|       114|            3|
--        107|Diana      |Lorentz    |diana.lorentz@sqltutorial.org    |590.423.5567|1999-02-07|     9|4200.00|       103|            6|
--        178|Kimberely  |Grant      |kimberely.grant@sqltutorial.org  |            |1999-05-24|    16|7000.00|       100|            8|
--        119|Karen      |Colmenares |karen.colmenares@sqltutorial.org |515.127.4566|1999-08-10|    13|2500.00|       114|            3|
--        113|Luis       |Popp       |luis.popp@sqltutorial.org        |515.124.4567|1999-12-07|     6|6900.00|       108|           10|
--        179|Charles    |Johnson    |charles.johnson@sqltutorial.org  |            |2000-01-04|    16|6200.00|       100|            8|

--Selecionar la primera y últimas fechas
SELECT
	max(hire_date) AS fecha_ultimo_contrato,
	min(hire_date) AS fecha_primer_contrato
FROM
	employees ;
--fecha_ultimo_contrato|fecha_primer_contrato|
-----------------------+---------------------+
--           2000-01-04|           1987-06-17|


--seleccionar elenmentos en un rango de fechas 
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1992-01-01';
--employee_id|first_name|last_name|email                           |phone_number|hire_date |job_id|salary |manager_id|department_id|
-------------+----------+---------+--------------------------------+------------+----------+------+-------+----------+-------------+
--        103|Alexander |Hunold   |alexander.hunold@sqltutorial.org|590.423.4567|1990-01-03|     9|9000.00|       102|            6|
--        104|Bruce     |Ernst    |bruce.ernst@sqltutorial.org     |590.423.4568|1991-05-21|     9|6000.00|       103|            6|

