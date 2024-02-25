
--Creamos una secuencia a mano de ejemplo
CREATE SEQUENCE user_sequence;
--Ver la carpeta schema.sequences. Ej en data tiene lo siguiente:
--last_value|log_cnt|is_called|
------------+-------+---------+
--         1|      0|false    |

--Eliminamos la secuencia a mano
DROP SEQUENCE user_sequence;

--Obtener el siguiente valor de la secuencia
SELECT nextval('user_sequence');
--nextval|
---------+
--      1|

--Si vuelvo a ejecutar el nextval(secuancia) se va incrementando
--Lo voy a ejecutar 3 veces más;
SELECT nextval('user_sequence'); -- x 3
--nextval|
---------+
--      4|

--Obtengo el último usado sin que incremente 
--da igual cuantas veces ejecute last_value porque no incremente, 
--es un valor de la secuancua como vimo en Ln:3-7:
SELECT LAST_VALUE FROM user_sequence; 
--nextval|
---------+
--      4|

--OTRA MANERA: Obtengo el valor actual sin llamar al elemento LAST_VALUE
--Usando la funcion currval(secuancia)
SELECT currval('user_sequence') AS valor_actual; 
--valor_actual|
--------------+
--           4|
           
--Reseteo el valor de la secuencia
ALTER SEQUENCE user_sequence RESTART WITH 1;
SELECT LAST_VALUE FROM user_sequence; 
--last_value|
------------+
--         1|


--Obtengo el valor actual, el siguiente y el actual de nuevo
--Va a incrementar el valor al ejecutar el nextval()
SELECT currval('user_sequence') AS antes, 
	nextval('user_sequence') AS siguiente,
	currval('user_sequence') AS despues; 
--antes|siguiente|despues|
-------+---------+-------+
--    1|        2|      2|



--Creamos otra tabla para probar la secuancia:
CREATE TABLE users6 (
	user_id integer PRIMARY KEY DEFAULT nextval('user_sequence'),
	username varchar
);
INSERT INTO users6 (username) VALUES ('Abraham');
INSERT INTO users6 (username) VALUES ('Lucas');
INSERT INTO users6 (username) VALUES ('Paco');
--Los id van a empezar en el valor siguiente al que lo dejé 3 
--user_id|username|
---------+--------+
--      4|Abraham |
--      5|Lucas   |
--      6|Paco    |