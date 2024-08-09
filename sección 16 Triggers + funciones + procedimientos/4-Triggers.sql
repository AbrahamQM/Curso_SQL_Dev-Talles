
--Documentación oficial:
--https://www.postgresql.org/docs/current/sql-createtrigger.html

--Sintaxis
--CREATE [ OR REPLACE ] [ CONSTRAINT ] TRIGGER name { BEFORE | AFTER | INSTEAD OF } { event [ OR ... ] }
--    ON table_name
--    [ FROM referenced_table_name ]
--    [ NOT DEFERRABLE | [ DEFERRABLE ] [ INITIALLY IMMEDIATE | INITIALLY DEFERRED ] ]
--    [ REFERENCING { { OLD | NEW } TABLE [ AS ] transition_relation_name } [ ... ] ]
--    [ FOR [ EACH ] { ROW | STATEMENT } ]
--    [ WHEN ( condition ) ]
--    EXECUTE { FUNCTION | PROCEDURE } function_name ( arguments )
--
--where event can be one of:
--
--    INSERT
--    UPDATE [ OF column_name [, ... ] ]
--    DELETE
--    TRUNCATE


--Crearemos una nueva tabla sessions para crear un trigger de pruebas
--Va a almacenar cuando se ha realizado una actualizacion en la tabla user_credentials
CREATE TABLE "session" (
	id serial,
	user_id int,
	last_login timestamp	
);


--Creo la funcion que va a lanzar el trigger //También puede ser un procedimiento
CREATE OR REPLACE FUNCTION create_session_log()
RETURNS TRIGGER AS 
$$
begin
	insert into "session" (user_id, last_login)
	values (NEW.id, now()); --Al usar NEW, ver explicación con +++++ al final
	
	return NEW; 
end;
$$
LANGUAGE plpgsql;

--Creamos el trigger
CREATE OR REPLACE TRIGGER create_sesion_trigger 
AFTER UPDATE
ON user_credentials
FOR EACH ROW 
EXECUTE FUNCTION create_session_log();

--****************  PRUEBAS ***************
--Compruebo la tabla antes de hacer login
SELECT * FROM "session";
--id|user_id|last_login|
----+-------+----------+


--1º LOGIN CORRECTO
CALL user_login_with('fernando', '123456');
--Log-in done, User: fernando

SELECT * FROM "session";
--id|user_id|last_login             |
----+-------+-----------------------+
-- 1|      1|2024-08-09 20:08:16.177|


--2º LOGIN CORRECTO
CALL user_login_with('fernando', '123456');
--Log-in done, User: fernando

SELECT * FROM "session";
--id|user_id|last_login             |
----+-------+-----------------------+
-- 1|      1|2024-08-09 20:08:16.177|
-- 2|      1|2024-08-09 20:09:12.732|



-- +++++ El NEW, que usamos en la función hace referencia al registro modificado,
--por lo que si hacemos NEW.username se obtendrá el nombre del usuario al cual se le ha actualizado CUALQUIER CAMPO.
-- ++También se puede usar OLD.campo : la diferencia está en que:
-- OLD hará referencia al valor antes de la modificación en ese registro de la tabla.
-- NEW hará referencia al valor después de la modificación en ese registro de la tabla.

--Ej de uso que veremos en la siguiente sesión(5): WHEN OLD.last_update is distict from NEW.last_update 