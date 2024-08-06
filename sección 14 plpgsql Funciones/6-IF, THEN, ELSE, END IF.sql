
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


--Cambiamos manualmente el sueldo a un empleado para que cobre más de lo que puede
--Así podremos trabajar mejor con el.
--modificaremos el empleado con id 206
SELECT * FROM employees WHERE employee_id = 206;
--employee_id|first_name|last_name|email                        |phone_number|hire_date |job_id|salary |manager_id|department_id|
-------------+----------+---------+-----------------------------+------------+----------+------+-------+----------+-------------+
--        206|William   |Gietz    |william.gietz@sqltutorial.org|515.123.8181|1994-06-07|     1|8300.00|       205|           11|


--Le asignamos un salario de 9500
UPDATE employees SET salary = 9500 WHERE employee_id = 206;

--Nuevos datos:
--employee_id|first_name|last_name|email                        |phone_number|hire_date |job_id|salary |manager_id|department_id|
-------------+----------+---------+-----------------------------+------------+----------+------+-------+----------+-------------+
--        206|William   |Gietz    |william.gietz@sqltutorial.org|515.123.8181|1994-06-07|     1|9500.00|       205|           11|


SELECT max_raise_2(206);
--max_raise_2|
-------------+
--    -500.00|

--************************************USO DE IF, THEN*****************************
--Modificamos la función para que en caso de tener un aumento negativo, el valor sea 0 en lugar de negativo
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

	if (possible_raise < 0) --LO NUEVO DE LA FUNCIÓN
		then possible_raise = 0;
	end if; 

	--Devolvemos
	return possible_raise;
END;
	
$$
LANGUAGE plpgsql;


--Volvemos a usar la función
SELECT max_raise_2(206);
--max_raise_2|
-------------+
--       0.00|


--**************************** LANZAR UNA EXEPCIÓN EN CASO DE QUE TENGAMOS UN VALOR NEGATIVO *****************************
--Usamos RAISE EXCEPTION
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

	if (possible_raise < 0) --LO NUEVO DE LA FUNCIÓN
		then RAISE EXCEPTION 'Empleado id: %, con salario mayor a max_salary' , emp_id;
	end if; 

	--Devolvemos
	return possible_raise;
END;
	
$$
LANGUAGE plpgsql;

--Volvemos a usar la función
SELECT max_raise_2(206);
--DEVUELVE EL SIGUIENTE ERROR:
--SQL Error [P0001]: ERROR: Empleado id: 206, con salario mayor a max_salary
--  Where: PL/pgSQL function max_raise_2(integer) line 24 at RAISE

