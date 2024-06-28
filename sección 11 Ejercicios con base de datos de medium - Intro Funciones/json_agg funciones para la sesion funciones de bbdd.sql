
--Consulta inicial para crear la función
select 
	json_agg( json_build_object(
	  'user', comments.user_id,
	  'comment', comments.content
	))
from comments where comment_parent_id = 1;


--La tarea va a ser crear una función a partir de la consulta anterior

--Sintaxis básica para la creaciín de una función
CREATE or REPLACE FUNCTION sayhello()
RETURNS varchar
AS 
$$ --es como { o } en java
BEGIN	
	RETURN 'Hola mundo';
END;
$$
LANGUAGE plpgsql;


--llamada a la función
SELECT sayhello();
--sayhello  |
------------+
--Hola mundo|


--Usar la respuesta de la funcion ademas de mas datos.
SELECT sayhello() AS saludo, u.name FROM users u LIMIT 3;
--saludo    |name            |
------------+----------------+
--Hola mundo|Helga Mayo      |
--Hola mundo|Carmela Mitchell|
--Hola mundo|Huffman Estrada |


--***********  PASO DE PARÁMETROS ****************
--Modifico la función para pasarle el nombre del usuario como parámetro
CREATE or REPLACE FUNCTION sayhello( name varchar)
RETURNS varchar
AS 
$$ 
BEGIN	
	RETURN 'Hola ' || name ; --SE USA || PARA AÑADIR LOS PARÁMETROS
END;
$$
LANGUAGE plpgsql;


--Sin embargo son dos funciones diferentes, una con argumento y otra que no lo tiene
--así que si llamo a la función sin pasarle parámetros, sigue llamando a la primera funcion que cree LN 33
SELECT sayhello() AS saludo, u.username FROM users u LIMIT 3;
--saludo    |username  |
------------+----------+
--Hola mundo|helga831  |
--Hola mundo|carmela768|
--Hola mundo|huffman377|

--Uso la función pasándole el nombre de los usuarios
SELECT sayhello(u.name) AS saludo_con_nombre FROM users u LIMIT 3;
--saludo_con_nombre    |
-----------------------+
--Hola Helga Mayo      |
--Hola Carmela Mitchell|
--Hola Huffman Estrada |

--Ahora voy a crear la función que ejecute la sentencia de Ln 3
--para que de el resultado del id que le pasemos por parámetro
CREATE OR REPLACE FUNCTION get_comment_replies(id integer)
RETURNS JSON --en este caso va a devolver json para poder reutilizarlo,
-- aunque se prodrúa retornar varchar haciendo un casteo al final de la consulta con ::varchar
AS 
$$ 
BEGIN	
	RETURN (
		select 
			json_agg( json_build_object(
			  'user', comments.user_id,
			  'comment', comments.content
			))
		from comments 
		where comment_parent_id = id --aqui NO se usa el || 
	);
END;
$$
LANGUAGE plpgsql;

--Llamo a la función pasandole un id
SELECT get_comment_replies(1);
--RESULTADO lo he dividido en varias líneas para que sea más fácil de leer
--get_comment_replies                                                                                                                                                                                                                                            |
---------------------------------------------------------------------------------------
--[{"user" : 1797, "comment" : "tempor mollit aliqua dolore cupidatat dolor tempor"}, 
--{"user" : 1842, "comment" : "laborum mollit amet aliqua enim eiusmod ut"}, 
--{"user" : 1447, "comment" : "nostrud nulla duis enim duis reprehenderit laboris voluptate cupida|


--lanzo la misma consulta pero sin la función para comprobar el resultado
SELECT
	json_agg( json_build_object(
			  'user',
	comments.user_id,
	'comment',
	comments.content
			))
FROM
	COMMENTS
WHERE
	comment_parent_id = 1;
--json_agg                                                                                                                                                                                                                                                       |
---------------------------------------------------------------------------------------
--[{"user" : 1797, "comment" : "tempor mollit aliqua dolore cupidatat dolor tempor"}, 
--{"user" : 1842, "comment" : "laborum mollit amet aliqua enim eiusmod ut"}, 
--{"user" : 1447, "comment" : "nostrud nulla duis enim duis reprehenderit laboris voluptate cupida|


--************ USAR EL ESPACIO PARA DECLARACIONES **************
-- >>>>>Ojo he tenido problemas por poner comentarios entre los $$ y el declare<<<<<
CREATE OR REPLACE FUNCTION get_comment_replies_declarations(id integer)
RETURNS JSON --en este caso va a devolver json para poder reutilizarlo,
-- aunque se prodría retornar varchar haciendo un casteo al final de la consulta con ::varchar
AS 
--se ponen los $$ para poder usar el espacio para delcaraciones así
$$ 

DECLARE 
	result JSON; --declaracion

BEGIN	
--al declarar el result lo que retorna va al final del cuerpo de la funcion LN 140
	select 
		json_agg( json_build_object(
		  'user', comments.user_id,
		  'comment', comments.content
		)) 
	INTO result --aquí le asigno a RESULT el resultado de la consulta
	from comments 
	where comment_parent_id = id; --aqui NO se usa el || 

	RETURN result; -- aquí le indico que devuelva el contenido de result

END;
$$
LANGUAGE plpgsql;

-- >>>>>Uso la nueva función con declaraciones<<<<<
SELECT get_comment_replies_declarations(1);
--get_comment_replies_declarations                                                                                                                                                                                                                               |
---------------------------------------------------------------------------------------
--[{"user" : 1797, "comment" : "tempor mollit aliqua dolore cupidatat dolor tempor"}, 
--{"user" : 1842, "comment" : "laborum mollit amet aliqua enim eiusmod ut"}, 
--{"user" : 1447, "comment" : "nostrud nulla duis enim duis reprehenderit laboris voluptate cupida|



