

--**************************** USO DE ROWTYPE EN EXEPCIONES *****************************
--rowtype le indica que es de tipo línea de registro de una tabla
--Sintaxis:
--nombreDeTabla%rowtype

CREATE OR replace FUNCTION max_raise_2(emp_id int)
RETURNS numeric(8,2) 
AS
$$
declare 
	
	selected_employee employees%rowtype; --************NUEVO
	selected_job jobs%rowtype; --************NUEVO
	possible_raise numeric(8,2);

BEGIN
	--puesto y salario
	SELECT * INTO selected_employee	--************NUEVO
	from employees 
	where employee_id = emp_id;

	--max_salary para su trabajo
	select * into selected_job
	from jobs
	where job_id = selected_employee.job_id; --************NUEVO

	--Cálculos
	possible_raise = selected_job.max_salary - selected_employee.salary; --************NUEVO

	if (possible_raise < 0) 
		then RAISE EXCEPTION 'Empleado id: % and name: % con salario mayor a max_salary' , emp_id, selected_employee.first_name;
	end if; 

	--Devolvemos
	return possible_raise;
END;
	
$$
LANGUAGE plpgsql;

--Volvemos a usar la función
SELECT max_raise_2(206);
--DEVUELVE EL SIGUIENTE ERROR, incluyendo el nombre del empleado:
--SQL Error [P0001]: ERROR: Empleado id: 206 and name: William con salario mayor a max_salary
--  Where: PL/pgSQL function max_raise_2(integer) line 23 at RAISE

