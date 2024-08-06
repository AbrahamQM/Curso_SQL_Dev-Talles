

--Vamos a crear una función similar a la de la sesión anterior (4)
--Pero usaremos múltiples variables y consultas para aprender su uso:
CREATE OR replace FUNCTION max_raise_2(emp_id int)
RETURNS numeric(8,2) 
AS
$$
declare 
	employee_job_id int;
	current_salary numeric(8,2);
	job_max_salary numeric(8,2);
	possible_raise numeric(8,2);

BEGIN
	--puesto y salario
	SELECT 
		job_id, salary into employee_job_id, current_salary
	from employees where employee_id = emp_id;

	--max_salary para su trabajo
	select 
		max_salary into job_max_salary
	from jobs
	where job_id = employee_job_id;

	--Cálculos
	possible_raise = job_max_salary - current_salary;

	--Devolvemos
	return possible_raise;
END;
	
$$
LANGUAGE plpgsql;


--consulta que usamos en la sesión anterior añadiendo la nueva función
SELECT
	e.employee_id,
	e.first_name ,
	max_raise(e.employee_id),
	max_raise_2(e.employee_id)
FROM employees e
LIMIT 5;
--employee_id|first_name|max_raise|max_raise_2|
-------------+----------+---------+-----------+
--        100|Steven    | 16000.00|   16000.00|
--        101|Neena     | 13000.00|   13000.00|
--        102|Lex       | 13000.00|   13000.00|
--        103|Alexander |  1000.00|    1000.00|
--        104|Bruce     |  4000.00|    4000.00|

