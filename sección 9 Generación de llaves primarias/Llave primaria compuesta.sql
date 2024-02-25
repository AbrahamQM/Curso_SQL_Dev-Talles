
--Creamos una tabla con una clave primaria compuesta
--De manera que cada valor por separado no tiene por que se único
--Pero la combinación de ambos si debe serlo.
CREATE TABLE usersComposedPkey (
	name varchar,
	surname varchar,
	PRIMARY KEY (name, surname)
);

--Voy a realizar la prueba de insertar varios elementos para comprobar 
--que la combinación de ambos valores va a ser realmente única
INSERT INTO userscomposedpkey VALUES ('Abraham', 'Quintana');
INSERT INTO userscomposedpkey VALUES ('Abraham', 'Micó'); 
--inserta bien porque no se repite la combinación
--name   |surname |
---------+--------+
--Abraham|Quintana|
--Abraham|Micó    |

INSERT INTO userscomposedpkey VALUES ('Abraham', 'Quintana');
--Da el siguiente error como se espera ya que la combinación es únuca
--SQL Error [23505]: ERROR: duplicate key value violates unique constraint "userscomposedpkey_pkey"
--  Detail: Key (name, surname)=(Abraham, Quintana) already exists.


