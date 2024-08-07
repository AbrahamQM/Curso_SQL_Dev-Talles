

--Vamos a crear un procedimiento para aumentar los salarios usando
--la función que creamos en sesiones anteriores para obtener el máximo
--aumento de salario de un empleado, dado su id:
 
--CREATE OR REPLACE FUNCTION public.max_raise(emp_id integer)
-- RETURNS numeric
--
--AS $$
--declare 
--	possible_raise numeric(8,2);
--
--BEGIN
--	SELECT
--		j.max_salary - e.salary  into possible_raise
--	FROM
--		employees e
--	INNER JOIN jobs j ON e.job_id = j.job_id
--	WHERE e.employee_id	= emp_id;
--
--	return possible_raise;
--	
--END;
--	
--$$
--LANGUAGE plpgsql;


SELECT e.employee_id, max_raise(e.employee_id)
FROM employees e 
LIMIT 4;
--employee_id|max_raise|
-------------+---------+
--        100| 16000.00|
--        101| 13000.00|
--        102| 13000.00|
--        103|  1000.00|

--*****************Creación del procedimiento de aumento de sueldo*****************
--Imaginemos que queremos aumentar un 1%(DEL AUMENTO MÁXIMO) el salario a los empleados 

--Sacamos los cálculos
SELECT 
	current_date AS date,
	salary,
	max_raise(employee_id),
	1 AS percentage,
	max_raise(employee_id) * 0.01 AS "amount",
	salary + max_raise(employee_id) * 0.01 AS "result_salary"
FROM employees e ;
--date      |salary  |max_raise|percentage|amount  |result_salary|
------------+--------+---------+----------+--------+-------------+
--2024-08-07|24000.00| 16000.00|         1|160.0000|   24160.0000|
--2024-08-07|17000.00| 13000.00|         1|130.0000|   17130.0000|
--2024-08-07|17000.00| 13000.00|         1|130.0000|   17130.0000|
--2024-08-07| 9000.00|  1000.00|         1| 10.0000|    9010.0000|
--...



--**Creamos una tabla para almacenar el histórico de aumentos**
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS raise_history_id_seq;

-- Table Definition
CREATE TABLE "public"."raise_history" (
    "id" int4 NOT NULL DEFAULT nextval('raise_history_id_seq'::regclass),
    "date" date,
    "employee_id" int4,
    "base_salary" numeric(8,2),
    "amount" numeric(8,2),
    "percentage" numeric(4,2),
    PRIMARY KEY ("id")
);

SELECT * FROM raise_history rh ;
--id|date|employee_id|base_salary|amount|percentage|
----+----+-----------+-----------+------+----------+


--**Volvemos a la creación del procedimiento**
CREATE OR REPLACE
PROCEDURE controlled_raise(percentage NUMERIC(4,
2))
AS 
$$
	DECLARE 
		real_percentage numeric(8,2);
		total_employees int;

	BEGIN
		RAISE NOTICE 'Porcentaje a aumentar: %', percentage;
		
		real_percentage = percentage / 100;
--Insertamos en la tabla historico
		insert into raise_history (date, employee_id, base_salary, amount, percentage)
			SELECT 
				current_date AS date,
				employee_id,
				salary,
				max_raise(employee_id) * real_percentage AS "amount",
				percentage
			FROM employees e ;	
--Actualizamos la tabla de empleados
		update employees 
			set salary = salary + (max_raise(employee_id) * real_percentage);
		
		COMMIT;
--Notificamos los datos	
		select count(*) into total_employees from raise_history;
		RAISE NOTICE 'Empleados afectados: %', total_employees;
	END;

$$
LANGUAGE plpgsql;


--LLAMAMOS AL PROCEDIMIENTO
CALL controlled_raise(1);
--Porcentaje a aumentar: 1
--Empleados afectados: 40

--COMPROBAMOS LOS DATOS:
SELECT * FROM raise_history rh LIMIT 4;
--id|date      |employee_id|base_salary|amount|percentage|
----+----------+-----------+-----------+------+----------+
-- 1|2024-08-07|        100|   24000.00|160.00|      1.00|
-- 2|2024-08-07|        101|   17000.00|130.00|      1.00|
-- 3|2024-08-07|        102|   17000.00|130.00|      1.00|
-- 4|2024-08-07|        103|    9000.00| 10.00|      1.00|


SELECT e.employee_id, e.first_name, e.salary 
FROM employees e 
WHERE e.employee_id IN (
	SELECT rh.employee_id FROM raise_history rh LIMIT 4
);
--employee_id|first_name|salary  |
-------------+----------+--------+
--        100|Steven    |24160.00|
--        101|Neena     |17130.00|
--        102|Lex       |17130.00|
--        103|Alexander | 9010.00|



--ESTE PROCEDIMIENTO QUE HEMOS CREADO, SE PUEDE MEJORAR ej CREANDO COMPROBACIONES