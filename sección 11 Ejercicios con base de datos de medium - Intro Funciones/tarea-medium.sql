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


-- 9. Quiero el comentario con id
-- Y en el mismo resultado, quiero sus respuestas (visibles e invisibles)
-- Tip: union
/*
1	    648	1905	elit id...
3058	583	1797	tempor mollit...
4649	51	1842	laborum mollit...
4768	835	1447	nostrud nulla...
*/

--visibles:
SELECT child.comment_id,  visible    
FROM  "comments" child 
WHERE child.comment_parent_id IS NOT NULL AND child.visible 
GROUP BY child.comment_id ;
--ocultos:
SELECT child.comment_id,  visible   
FROM  "comments" child 
WHERE child.comment_parent_id IS NOT NULL AND NOT child.visible 
GROUP BY child.comment_id ;


SELECT father.comment_id  AS id, null AS visibles, NULL AS invisibles, father."content" AS "content"   
FROM "comments" father 
WHERE father.comment_parent_id IS NULL
UNION 
	SELECT child.comment_id AS id, NULL, NULL, child.visible::TEXT   
	FROM  "comments" child 
	WHERE child.comment_parent_id IS NOT NULL AND child.visible 
	GROUP BY child.comment_id 
--GROUP BY father.comment_id  
--ORDER BY id
LIMIT 5;




SELECT child.comment_id,  count(child) AS visibles, '' AS content   
FROM  "comments" child 
WHERE child.comment_parent_id IS NOT NULL AND child.visible 
GROUP BY child.comment_id ;


-- ** 10. Avanzado
-- Investigar sobre el json_agg y json_build_object
-- Crear una única linea de respuesta, con las respuestas
-- del comentario con id 1 (comment_parent_id = 1)
-- Mostrar el user_id y el contenido del comentario

-- Salida esperada:
/*
"[{""user"" : 1797, ""comment"" : ""tempor mollit aliqua dolore cupidatat dolor tempor""}, {""user"" : 1842, ""comment"" : ""laborum mollit amet aliqua enim eiusmod ut""}, {""user"" : 1447, ""comment"" : ""nostrud nulla duis enim duis reprehenderit laboris voluptate cupidatat""}]"
*/





-- ** 11. Avanzado
-- Listar todos los comentarios principales (no respuestas) 
-- Y crear una columna adicional "replies" con las respuestas en formato JSON






