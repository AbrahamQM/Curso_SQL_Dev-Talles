DROP TABLE users2 ; 

--Vamos a crear una tabla users2 con un id autogenerado como serial
CREATE TABLE users2 (
	user_id SERIAL PRIMARY KEY,
	username varchar
)

--El problema de crearlo así es que permite que se inserten id de manera manual 
--siempre que no se repita el id (primary key). pero nos podemos saltar números a mano
--lo cual cuando se intente a gregar un elemento asignándole el siguinte valor
--del serial, va a dar problemas cuando toque asignar un valor que ya ha sido asignado.
-- EJ:

--aquí inserta un elemento con el id autogenerado
INSERT INTO users2 (username) values( 'Abraham' );
--user_id|username|
---------+--------+
--      1|Abraham |
--inserto otro definiendo yo el id a mano
INSERT INTO users2 (user_id, username) values(3, 'Paco'  );
--user_id|username|
-------+--------+
--      1|Abraham |
--      3|Paco    |

--Ahora si intento insertar 2 elementos usando el serial autoincremental de nuevo
--el primero lo crea sin problema con el id 2 que no se ha usado
INSERT INTO users2 (username) values( 'Ana' );
--user_id|username|
---------+--------+
--      1|Abraham |
--      3|Paco    |
--      2|Ana     |

--pero si lo vuelvo a hacer, da un error porque el autoincremental va a intentar usar 
--el id 3 que ya existe:
INSERT INTO users2 (username) values( 'Jose' );
--Error:
--SQL Error [23505]: ERROR: duplicate key value violates unique constraint "users2_pkey"
--  Detail: Key (user_id)=(3) already exists.

--*************************SOLUCIÓN*********************************
--Usar(al definir la tabla) id de tipo IDENTITY para definir el id en lugar de un SERIAL
--Definiéndolo como ALWAYS 
-- de esta manera nos aseguramos de que no se pueden insertar valores a mano en el id
CREATE TABLE users3 (
	user_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	username VARCHAR
);
--Ahora al intentar insertar un valor en el id a mano da este error
INSERT INTO users3 (user_id, username) values(1, 'Paco'  );
--SQL Error [428C9]: ERROR: cannot insert a non-DEFAULT value into column "user_id"
--  Detail: Column "user_id" is an identity column defined as GENERATED ALWAYS.
--  Hint: Use OVERRIDING SYSTEM VALUE to override.
INSERT INTO users3 (username) values( 'Paco'  );
--user_id|username|
---------+--------+
--      1|Paco    |


--Para definir como queremos que se administre el id por ejemplo: 
--empezando por el número 100 e incrementando de 3 en 3
CREATE TABLE users4 (
	user_id INTEGER GENERATED ALWAYS AS IDENTITY (
		START WITH 100 INCREMENT BY 3) PRIMARY KEY ,
	username VARCHAR
);
INSERT INTO users4 (username) values('Paco');
INSERT INTO users4 (username) values('Lucas');
INSERT INTO users4 (username) values('Juan');
--user_id|username|
---------+--------+
--    100|Paco    |
--    103|Lucas   |
--    106|Juan    |

