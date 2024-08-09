


--Creamos una tabla de usuarios para practicar la encriptación y desenciptación
CREATE TABLE "user_credentials" (
	id serial,
	username varchar(50),
	"password" TEXT,
	last_login timestamp	
);

SELECT * FROM user_credentials;
--id|username|password|last_login|
----+--------+--------+----------+


INSERT INTO user_credentials (username, "password")
VALUES ('fernando', '123456');



SELECT * FROM user_credentials;
--id|username|password|last_login|
----+--------+--------+----------+
-- 1|fernando|123456  |          |

--***********************************Encriptamos contraseñas******************************

--primero "creamos"/instalamos la extensión pgcrypto
--DOCUMENTACIÓN OFICIAL: https://www.postgresql.org/docs/current/pgcrypto.html
CREATE EXTENSION pgcrypto;

--Ahora insertaremos los datos usando el encriptado 
--sintaxis: crypt( texto, selección_de_hash)
--ej:
INSERT INTO user_credentials (username, "password")
VALUES ('fernando', crypt('123456', gen_salt('bf')));

SELECT * FROM user_credentials;
--id|username|password                                                    |last_login|
----+--------+------------------------------------------------------------+----------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|          |

--*************las contraseñas encriptadas nunca serán identicas aunque el valor sea el mismo:
--OJO: cada vez que introduzcamos una contraseña encriptada, el resultado es diferente
--Incluso si usamos la misma contraseña

INSERT INTO user_credentials (username, "password")
VALUES ('fernando2', crypt('123456', gen_salt('bf')));

SELECT * FROM user_credentials;
--id|username |password                                                    |last_login|
----+---------+------------------------------------------------------------+----------+
-- 1|fernando |$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|          |
-- 2|fernando2|$2a$06$aq1OLQ2hp8GPEl60.HkFc.hhOasBgDWLfbO2NzPnypeTl83s7nPfS|          |


--**************************DESENCRIPTAR CONTRASEÑAS**********************************************

--Para comprobar el valor de una contaseña podemos hacer lo siguiente
SELECT * FROM user_credentials uc 
WHERE uc.username = 'fernando' 
	AND "password" = crypt('123456', "password");
--id|username|password                                                    |last_login|
----+--------+------------------------------------------------------------+----------+
-- 1|fernando|$2a$06$2pQKdKs2dDe7egtBPHGyKek1YNwNlAqEQRilut4T8eev8WbN2VpiO|          |

--Otros ejemplos de la documentación para actualizar o autenticar
--Example of setting a new password:
--
--UPDATE ... SET pswhash = crypt('new password', gen_salt('md5'));
--Example of authentication:
--
--SELECT (pswhash = crypt('entered password', pswhash)) AS pswmatch FROM ... ;
--This returns true if the entered password is correct.
--




