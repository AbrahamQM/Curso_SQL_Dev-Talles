-- Link a la docu sobre UUIDs
-- https://www.postgresql.org/docs/current/uuid-ossp.html

--Son identificadores unicos de registros 

--Ej para obtener un UUID usando la función gen_random_uuid();
SELECT gen_random_uuid() AS UUID;
--uuid                                |
--------------------------------------+
--a408e2b8-7e10-4ef3-85d9-75f3ede7fca3|

--Para instalar/crear extensiones por ejemplo para poder usar las "uuid-ossp Functions"
--(ver link a la docu)
--podemos usar la siguiente sintaxis (la tenemos en la hoja de postgres-cheatsheet)
--https://github.com/AbrahamQM/Curso_SQL_Dev-Talles/blob/main/postgres-cheatsheet.pdf
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
--Esto crea todas las funciones de la extensión
--podemos comprobar el resultado en la carpeta functions del schema en el que estamos trabajando

--ahora podemos usar otras funciones mas complejas para generar uuid (ver docu oficial)
SELECT uuid_generate_v4 () AS UUID_v4;
--uuid_v4                             |
--------------------------------------+
--f227f4f6-4593-4790-8046-d1874c892df2|

--Para eliminar las funciones:
DROP EXTENSION IF EXISTS "uuid-ossp";


--Vamos a usar un UUID en una tabla de ejemplo
--donde UUID es un tipo de postgres lo definimos como default (que permite insertar valores a mano) 
CREATE TABLE users5 (
	user_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY, 
	username varchar
);

--inserto valores
INSERT INTO users5 VALUES (uuid_generate_v4(), 'Abraham');
INSERT INTO users5 VALUES (uuid_generate_v4(), 'Lucas');
INSERT INTO users5 VALUES (uuid_generate_v4(), 'Paco');
--user_id                             |username|
--------------------------------------+--------+
--e627f4a8-0b10-4d6c-8991-50cb376cc23d|Abraham |
--71789c8a-c488-4d86-9bcf-28d3120318d8|Lucas   |
--1f470983-2c13-4f30-ba7b-74372c1e8f61|Paco    |

--Si intento ingresar com ouser_id algo que no es un UUID, da error:
INSERT INTO users5 VALUES ( 1, 'Paco');
--SQL Error [42804]: ERROR: column "user_id" is of type uuid but expression is of type integer
--  Hint: You will need to rewrite or cast the expression.
--  Position: 29

--Intento hacerlo con un cast
INSERT INTO users5 VALUES ( 1235487::uuid, 'Paco');
--SQL Error [42846]: ERROR: cannot cast type integer to uuid
--Tampoco me deja porque no tiene formato uuid

--Ahora lo hago pero poniendo el uuid v4 que obtuvimos al prinpio en ln:21-24
--f227f4f6-4593-4790-8046-d1874c892df2
INSERT INTO users5 VALUES ( 'f227f4f6-4593-4790-8046-d1874c892df2'::uuid, 'Paco');
--Esto si es posible, porque la cadena que le paso se puede castear a uuid
--user_id                             |username|
--------------------------------------+--------+
--e627f4a8-0b10-4d6c-8991-50cb376cc23d|Abraham |
--71789c8a-c488-4d86-9bcf-28d3120318d8|Lucas   |
--1f470983-2c13-4f30-ba7b-74372c1e8f61|Paco    |
--f227f4f6-4593-4790-8046-d1874c892df2|Paco    |
