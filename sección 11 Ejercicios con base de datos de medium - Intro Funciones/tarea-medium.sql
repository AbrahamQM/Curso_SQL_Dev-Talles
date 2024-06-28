-- 1. Cuantos Post hay - 1050
SELECT count(*) FROM posts;


-- 2. Cuantos Post publicados hay - 543
SELECT count(*) FROM posts WHERE published;

-- 3. Cual es el Post mas reciente
-- 544 - nisi commodo officia...2024-05-30 00:29:21.277
SELECT * FROM posts ORDER BY created_at DESC LIMIT 1;


-- 4. Quiero los 10 usuarios con más post, cantidad de posts, id y nombre
/*
4	1553	Jessie Sexton
3	1400	Prince Fuentes
3	1830	Hull George
3	470	Traci Wood
3	441	Livingston Davis
3	1942	Inez Dennis
3	1665	Maggie Davidson
3	524	Lidia Sparks
3	436	Mccoy Boone
3	2034	Bonita Rowe
*/
SELECT count(p) AS cantidad, u.user_id ,u.name
FROM users u 
INNER JOIN posts p ON u.user_id = p.created_by 
GROUP BY u.name, u.user_id 
ORDER BY cantidad DESC 
LIMIT 10;



-- 5. Quiero los 5 post con más "Claps" sumando la columna "counter"
/*
692	sit excepteur ex ipsum magna fugiat laborum exercitation fugiat
646	do deserunt ea
542	do
504	ea est sunt magna consectetur tempor cupidatat
502	amet exercitation tempor laborum fugiat aliquip dolore
*/
SELECT sum(c.counter) AS cantidad, p.title  
FROM posts p
INNER JOIN claps c ON c.post_id = p.post_id 
GROUP BY p.title 
ORDER BY cantidad DESC 
LIMIT 5;


-- 6. Top 5 de personas que han dado más claps (voto único no acumulado ) *count
/*
7	Lillian Hodge
6	Dominguez Carson
6	Marva Joyner
6	Lela Cardenas
6	Rose Owen
*/
SELECT count(c) AS claps, u.name
FROM users u 
INNER JOIN claps c ON c.user_id = u.user_id 
GROUP BY u."name" 
ORDER BY claps DESC 
LIMIT 5;


-- 7. Top 5 personas con votos acumulados (sumar counter)
/*
437	Rose Owen
394	Marva Joyner
386	Marquez Kennedy
379	Jenna Roth
364	Lillian Hodge
*/
SELECT sum(c.counter)  AS summatory, u.name
FROM users u 
INNER JOIN claps c ON c.user_id = u.user_id 
GROUP BY u."name" 
ORDER BY summatory DESC 
LIMIT 5;


-- 8. Cuantos usuarios NO tienen listas de favoritos creada
-- 329
SELECT count(u)  
FROM users u 
LEFT JOIN user_lists ul ON ul.user_id = u.user_id
WHERE ul.user_id  IS NULL ;


-- 9. Quiero el comentario con id 1
-- Y en el mismo resultado, quiero sus respuestas (visibles e invisibles)
-- Tip: union
/*
1	    648	1905	elit id...
3058	583	1797	tempor mollit...
4649	51	1842	laborum mollit...
4768	835	1447	nostrud nulla...
*/

SELECT
	comment_id,
	post_id,
	user_id,
	"content"
FROM
	"comments" c
WHERE
	c.comment_id = 1
UNION
SELECT
	comment_id,
	post_id,
	user_id,
	"content"
FROM
	"comments" c
WHERE
	c.comment_parent_id = 1
ORDER BY
	comment_id;



-- ** 10. Avanzado
-- Investigar sobre el json_agg y json_build_object
-- Crear una única linea de respuesta, con las respuestas
-- del comentario con id 1 (comment_parent_id = 1)
-- Mostrar el user_id y el contenido del comentario

-- Salida esperada:
/*
"[{""user"" : 1797, ""comment"" : ""tempor mollit aliqua dolore cupidatat dolor tempor""}, {""user"" : 1842, ""comment"" : ""laborum mollit amet aliqua enim eiusmod ut""},{""user"" : 1447, ""comment"" : ""nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat""}]"
*/
SELECT json_agg("content")
	FROM
		"comments" c
	WHERE
		c.comment_parent_id = 1;
--json_agg                                                                                                                                                                      |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--["tempor mollit aliqua dolore cupidatat dolor tempor", "laborum mollit amet aliqua enim eiusmod ut", "nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat"]|
	
SELECT jsonb_build_object(
		'user', user_id,
		'comment', "content" 
	) AS contenido_del_comentario
FROM "comments" c 
WHERE comment_parent_id = 1;
--contenido_del_comentario                                                                           |
-----------------------------------------------------------------------------------------------------+
--{"user": 1797, "comment": "tempor mollit aliqua dolore cupidatat dolor tempor"}                    |
--{"user": 1842, "comment": "laborum mollit amet aliqua enim eiusmod ut"}                            |
--{"user": 1447, "comment": "nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat"}|

--ahora lo unifico en un array de objetos
SELECT jsonb_agg(
	jsonb_build_object(
		'user', user_id,
		'comment', "content" 
	)) 
FROM "comments" c 
WHERE comment_parent_id = 1;
--jsonb_agg                                                                                                                                                                                                                                                      |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
--[{"user": 1797, "comment": "tempor mollit aliqua dolore cupidatat dolor tempor"}, {"user": 1842, "comment": "laborum mollit amet aliqua enim eiusmod ut"}, {"user": 1447, "comment": "nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat"}]|




-- ** 11. Avanzado
-- Listar todos los comentarios principales (no respuestas) 
-- Y crear una columna adicional "replies" con las respuestas en formato JSON

--personalmente añado el id y el conteo de respuestas para despues poder comprobar que el resultado coincide.
SELECT c.comment_id, c.content, count(c2.*) AS replies_quantity, json_agg(c2.content) AS replies
FROM "comments" c
JOIN "comments" c2 ON c2.comment_parent_id = c.comment_id
WHERE c.comment_parent_id IS NULL
GROUP BY c.CONTENT, c.comment_id;

--comment_id|content                                                                        |replies_quantity|replies                                                                                                                                                                           
------------+-------------------------------------------------------------------------------+----------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--         1|elit id aute consequat culpa ullamco                                           |               3|["tempor mollit aliqua dolore cupidatat dolor tempor", "nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat", "laborum mollit amet aliqua enim eiusmod ut"]    
--         2|ipsum ut est adipisicing do                                                    |               3|["ex duis", "mollit in officia non esse duis culpa", "sint laborum ut nisi magna"]                                                                                                
--         3|ut consectetur ullamco do                                                      |               2|["sit ipsum non reprehenderit minim non exercitation veniam et ad", "sunt occaecat reprehenderit amet"]                                                                           
--         4|dolore enim                                                                    |               3|["ex Lorem cupidatat esse", "magna occaecat amet et dolore", "sint velit laboris pariatur ipsum id officia eiusmod sint culpa"]                                                   
--         5|sit sunt proident anim occaecat ipsum velit sit cillum do                      |               1|["elit tempor irure laboris aute aliqua nulla et aute laboris"]                                                                                                                   
--         6|labore esse fugiat adipisicing est laborum                                     |               4|["duis laborum", "duis commodo dolore", "aliquip ex qui cillum cillum ipsum", "anim fugiat occaecat id minim aliquip occaecat laborum commodo do"]                                
--         7|velit culpa est enim laboris velit voluptate exercitation magna                |               3|["exercitation anim dolore voluptate id ullamco ipsum", "cupidatat nulla", "pariatur proident aute ea ad adipisicing culpa laboris Lorem"]                                        
--         8|quis in incididunt sint sit minim esse aliqua sint cupidatat                   |               4|["qui in eu est sit ad eiusmod anim", "cupidatat Lorem sunt excepteur consequat", "dolor cillum exercitation cillum eu", "aliqua excepteur in mollit tempor"]                     
--         9|qui sunt nostrud fugiat amet eu ad in est cupidatat                            |               3|["irure do et", "id magna fugiat dolore commodo proident tempor non", "ad consequat aute"]                                                                                        
--        10|est quis                                                                       |               3|["laborum sit", "labore ad tempor adipisicing ex esse ad sint mollit dolore", "nulla voluptate voluptate irure esse"]                                                             
-- RECORTADO SOLO PARA MUESTRA

--consulta para comprobar que las replicas coinciden con el resultaro en un elemento de ejemplo.
SELECT count(*) FROM "comments" c 
WHERE c.comment_parent_id = 6;
--count|
-------+
--    4|

--solución del profesor pero eso no coincide con lo que pide el enunciado y tarda (0.1s Aprox) 10 veces mas que mi consulta (0.01s aprox)
SELECT 	
	c.CONTENT, 
	(
		SELECT json_agg( json_build_object(
				'user', c2.user_id,
				'comment', c2.content
		))
		FROM "comments" c2 WHERE c2.comment_parent_id = c.comment_id 
	) AS replies
FROM "comments" c 
WHERE comment_parent_id IS NULL;
	
