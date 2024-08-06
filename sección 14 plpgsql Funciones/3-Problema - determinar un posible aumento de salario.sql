

--Comprobamos que todos los empleados tienen un salario
SELECT * FROM employees e LIMIT 4;
--employee_id|first_name|last_name|email                           |phone_number|hire_date |job_id|salary  |manager_id|department_id|
-------------+----------+---------+--------------------------------+------------+----------+------+--------+----------+-------------+
--        100|Steven    |King     |steven.king@sqltutorial.org     |515.123.4567|1987-06-17|     4|24000.00|          |            9|
--        101|Neena     |Kochhar  |neena.kochhar@sqltutorial.org   |515.123.4568|1989-09-21|     5|17000.00|       100|            9|
--        102|Lex       |De Haan  |lex.de haan@sqltutorial.org     |515.123.4569|1993-01-13|     5|17000.00|       100|            9|
--        103|Alexander |Hunold   |alexander.hunold@sqltutorial.org|590.423.4567|1990-01-03|     9| 9000.00|       102|            6|


--Cada empleo tiene un salario mínimo y máximo
SELECT * FROM jobs j LIMIT 4;
--job_id|job_title               |min_salary|max_salary|
--------+------------------------+----------+----------+
--     1|Public Accountant       |   4200.00|   9000.00|
--     2|Accounting Manager      |   8200.00|  16000.00|
--     3|Administration Assistant|   3000.00|   6000.00|
--     4|President               |  20000.00|  40000.00|


--Creamos una "relación" entre los trabajos y los empleados
SELECT
	e.employee_id,
	e.first_name ,
	e.salary,
	j.max_salary
FROM
	employees e
INNER JOIN jobs j ON
	e.job_id = j.job_id
LIMIT 5;
--employee_id|first_name|salary  |max_salary|
-------------+----------+--------+----------+
--        100|Steven    |24000.00|  40000.00|
--        101|Neena     |17000.00|  30000.00|
--        102|Lex       |17000.00|  30000.00|
--        103|Alexander | 9000.00|  10000.00|
--        104|Bruce     | 6000.00|  10000.00|


--Ahora queremos obtener esos mismos datos añadiendo además el máximo aumento de salario para ese empleado y trabajo
SELECT
	e.employee_id,
	e.first_name ,
	e.salary,
	j.max_salary,
	j.max_salary - e.salary  AS max_salary_raise
FROM
	employees e
INNER JOIN jobs j ON
	e.job_id = j.job_id
LIMIT 5;
--employee_id|first_name|salary  |max_salary|max_salary_raise|
-------------+----------+--------+----------+----------------+
--        100|Steven    |24000.00|  40000.00|        16000.00|
--        101|Neena     |17000.00|  30000.00|        13000.00|
--        102|Lex       |17000.00|  30000.00|        13000.00|
--        103|Alexander | 9000.00|  10000.00|         1000.00|
--        104|Bruce     | 6000.00|  10000.00|         4000.00|



