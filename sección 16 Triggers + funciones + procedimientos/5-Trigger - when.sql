SELECT * FROM user_credentials uc ;

--Ahora queremos modifiar el trigger creado en la sesion 4 
--para que solo ejecute la función cuando se ha actualizado el lasr_login de user_credentials
--evitando así que se lance el trigger en caso de modificaciones en el username
CREATE OR REPLACE TRIGGER create_sesion_trigger 
AFTER UPDATE
ON user_credentials
FOR EACH ROW 
WHEN (OLD.last_login IS DISTINCT FROM NEW.last_login)
EXECUTE FUNCTION create_session_log();

--************** Compruebo el funcionamiento del trigger*****************
SELECT * FROM user_credentials uc ;
--id|username |password                                                    |last_login             |
----+---------+------------------------------------------------------------+-----------------------+
-- 2|fernando2|$2a$06$aq1OLQ2hp8GPEl60.HkFc.hhOasBgDWLfbO2NzPnypeTl83s7nPfS|                       |
-- 1|fernando |$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 20:09:12.732|

SELECT * FROM "session";
--id|user_id|last_login             |
----+-------+-----------------------+
-- 1|      1|2024-08-09 20:08:16.177|
-- 2|      1|2024-08-09 20:09:12.732|

--******************** Modifico un valor (NO DEBE LANZAR EL TRIGGER) ********************
--Modifico el nombre de el usuario con id 2
UPDATE user_credentials 
SET username = 'Pepe'
WHERE id = 2;

--Compruebo la modificación:
SELECT * FROM user_credentials;
--id|username|password                                                    |last_login             |
----+--------+------------------------------------------------------------+-----------------------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 20:09:12.732|
-- 2|Pepe    |$2a$06$aq1OLQ2hp8GPEl60.HkFc.hhOasBgDWLfbO2NzPnypeTl83s7nPfS|                       |


--Compruebo que no se han hecho cambios en session
SELECT * FROM "session";
--id|user_id|last_login             |
----+-------+-----------------------+
-- 1|      1|2024-08-09 20:08:16.177|
-- 2|      1|2024-08-09 20:09:12.732|

--******************** Hago login (SI DEBE LANZAR EL TRIGGER) ********************
--Ahora hago un nuevo login con pepe
CALL user_login_with_history('Pepe', '123456');
--Log-in done, User: Pepe


SELECT * FROM user_credentials;
--id|username|password                                                    |last_login             |
----+--------+------------------------------------------------------------+-----------------------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|2024-08-09 20:09:12.732|
-- 2|Pepe    |$2a$06$aq1OLQ2hp8GPEl60.HkFc.hhOasBgDWLfbO2NzPnypeTl83s7nPfS|2024-08-09 20:29:11.280| ---PEPE ha loggeado

SELECT * FROM "session";
--id|user_id|last_login             |
----+-------+-----------------------+
-- 1|      1|2024-08-09 20:08:16.177|
-- 2|      1|2024-08-09 20:09:12.732|
-- 3|      2|2024-08-09 20:29:11.280|  --Este es el nuevo registro por la modificacion del last_login