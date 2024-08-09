

--tarea, crear un registro histórico de errores al loguear

--Creo la tabla
CREATE TABLE session_failed (
	id serial,
	username varchar,
	fail_date timestamp
	);

--Compruebo
SELECT * FROM session_failed;
--id|username|fail_date|
----+--------+---------+


--Ahora creo un nuevo procedimiento basándome en el anterior añadiendo un registro en la nueva tabla
CREATE OR REPLACE  PROCEDURE user_login_with_history(user_name varchar, user_password varchar)
AS 
$$
declare 
	is_correct boolean;
begin
	SELECT
		count(*) into is_correct
	FROM
		user_credentials uc
	WHERE
		uc.username = user_name
		AND "password" = crypt( user_password , "password");
	
	if is_correct
	 	then 	
			update user_credentials uc
				set last_login = now() 
				where uc.username = user_name
					AND "password" = crypt( user_password , "password");
			raise notice 'Log-in done, User: %', user_name;
		else --LO NUEVO
			insert into session_failed (username, fail_date)
					values (user_name, now());
			COMMIT; --OJO--- TENGO QUE HACER UN COMMIT ANTES DE LANZAR LAS EXEPCIONES O SE HARÁ UN ROLLBACK
			raise notice 'Incorrect credentials for User: %', user_name; --Lanzo mensaje
			raise exception 'Incorrect login exception for User: %', user_name;--Lanzo excepción
	end if;
 
end;
$$ LANGUAGE plpgsql;

--//////////////////////Compruebo el funcionamiento:\\\\\\\\\\\\\\\\\\\\\\\\\\


--******************LOGIN INCORRECTO**************
CALL user_login_with_history('fernando', '123458');
--SQL Error [P0001]: ERROR: Incorrect login exception for User: fernando
--  Where: PL/pgSQL function user_login_with_history(character varying,character varying) line 25 at RAISE

SELECT * FROM user_credentials uc WHERE username = 'fernando';
--id|username|password                                                    |last_login             |
----+--------+------------------------------------------------------------+-----------------------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 19:21:51.592|

SELECT * FROM session_failed;
--id|username|fail_date              |
----+--------+-----------------------+
-- 2|fernando|2024-08-09 19:41:49.208|


--******************LOGIN CORRECTO**************
CALL user_login_with_history('fernando', '123456');
--Log-in done, User: fernando
SELECT * FROM user_credentials uc WHERE username = 'fernando';
--id|username|password                                                    |last_login             |
----+--------+------------------------------------------------------------+-----------------------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 19:42:03.818|

SELECT * FROM session_failed;
--id|username|fail_date              |
----+--------+-----------------------+
-- 2|fernando|2024-08-09 19:41:49.208|



--La solución del profesor es idéntica a la mía pero quitando los avisos y con nombres diferentes.
