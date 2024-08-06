
--En la sesión anterior creamos la siguiente consulta para obtener el máximo aumento de 
--sueldo para un empleado, en relación a su trabajo
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


--****************** Creamos una función max_rise****************************
--que devolverá la cantidad máxima que se puede aumentar a un empleado

CREATE OR replace FUNCTION max_raise(emp_id int)
RETURNS numeric(8,2) 
AS
$$
declare 
	possible_raise numeric(8,2);

BEGIN
	SELECT
		j.max_salary - e.salary  into possible_raise
	FROM
		employees e
	INNER JOIN jobs j ON e.job_id = j.job_id
	WHERE e.employee_id	= emp_id;

	return possible_raise;
	
END;
	
$$
LANGUAGE plpgsql;


--Usamos la funcion junto con la consulta inicial para comprobar los datos
SELECT
	e.employee_id,
	e.first_name ,
	e.salary,
	j.max_salary,
	j.max_salary - e.salary  AS max_salary_raise,
	--Aqui le añado la función
	max_raise(e.employee_id) AS function_result
FROM
	employees e
INNER JOIN jobs j ON
	e.job_id = j.job_id
LIMIT 5;
--employee_id|first_name|salary  |max_salary|max_salary_raise|function_result|
-------------+----------+--------+----------+----------------+---------------+
--        100|Steven    |24000.00|  40000.00|        16000.00|       16000.00|
--        101|Neena     |17000.00|  30000.00|        13000.00|       13000.00|
--        102|Lex       |17000.00|  30000.00|        13000.00|       13000.00|
--        103|Alexander | 9000.00|  10000.00|         1000.00|        1000.00|
--        104|Bruce     | 6000.00|  10000.00|         4000.00|        4000.00|


--Ahora podemos usar la función así:
SELECT
	e.employee_id,
	e.first_name ,
	max_raise(e.employee_id)
FROM employees e
LIMIT 5;
--employee_id|first_name|max_raise|
-------------+----------+---------+
--        100|Steven    | 16000.00|
--        101|Neena     | 13000.00|
--        102|Lex       | 13000.00|
--        103|Alexander |  1000.00|
--        104|Bruce     |  4000.00|




