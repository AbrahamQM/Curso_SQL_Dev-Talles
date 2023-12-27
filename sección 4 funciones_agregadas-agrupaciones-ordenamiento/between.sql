--obtenemos un rango de followers (ORDENADO DESCENDENTE) usando operadores relacionales
SELECT
    first_name,
    last_name,
    followers
FROM
    users
WHERE
    followers > 4600 AND followers < 4700
ORDER BY followers DESC; --ASC sería en orden ascendente ver siguiente ejemplo
    
    
--ahora usaremos el operador BETWEEN orden ascendente de followers
SELECT
    first_name,
    last_name,
    followers
FROM
    users
WHERE
    followers BETWEEN 4600 AND 4700
ORDER BY followers ASC;