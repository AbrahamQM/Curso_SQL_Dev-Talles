

--Query para verificar si el login es correcto.
SELECT count(*) FROM user_credentials uc 
WHERE uc.username = 'fernando' 
	AND "password" = crypt('123456', "password");
	

--Procedimiento almacenado que recibe usuario y contraseña y comprueba las credenciales
--Devuelve un mensaje u otro dependiendo de si es correcto
--Actualiza el campo last_login
CREATE OR REPLACE  PROCEDURE user_login(user_name varchar, user_password varchar)
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
		else
			raise notice 'Incorrect credentials for User: %', user_name; --Lanzo mensaje
			raise exception 'Incorrect login exception for User: %', user_name;--Lanzo excepción
	end if;
 
end;
$$ LANGUAGE plpgsql;


--Llamamos al proceso
CALL user_login('fernando', '123456');
--Salida por consola:
--Log-in done, User: fernando

--Comprobamos el last login a ver si se ha actualizado:
SELECT * FROM user_credentials uc WHERE username = 'fernando';
--id|username|password                                                    |last_login             |
----+--------+------------------------------------------------------------+-----------------------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 19:21:51.592|


--Llamamos al proceso con pass incorrecta
CALL user_login('fernando', '123457');
--**Salida por consola:
--Incorrect credentials for User: fernando
--**Excepción lanzada
--SQL Error [P0001]: ERROR: Incorrect login exception for User: fernando
--  Where: PL/pgSQL function user_login(character varying,character varying) line 22 at RAISE


--Comprobamos el last login a ver si se ha actualizado:
SELECT * FROM user_credentials uc WHERE username = 'fernando'; 
--id|username|password                                                    |last_login             |
----+--------+------------------------------------------------------------+-----------------------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 19:21:51.592|


