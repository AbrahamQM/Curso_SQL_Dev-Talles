select * from users limit 2;

-- 1. Cuantos usuarios tenemos con cuentas @google.com
-- Tip: count, like
select
    count(*)
from
    users
where
    email like '%@google.com';

-- 2. De qué países son los usuarios con cuentas de @google.com
-- Tip: distinct
SELECT
    DISTINCT(country)
from
    users
where
    email like '%@google.com';
    
-- 3. Cuantos usuarios hay por país (country)
-- Tip: Group by
SELECT
    count(*) as quantity_of_users,
    country
FROM
    users
GROUP BY
    country
order by
    quantity_of_users DESC;


-- 4. Listado de direcciones IP de todos los usuarios de Iceland
-- Campos requeridos first_name, last_name, country, last_connection
SELECT
    first_name,
    last_name,
    country,
    last_connection
from
    users
where
    country like 'Iceland';

-- 5. Cuantos de esos usuarios (query anterior) tiene dirección IP
-- que incia en 112.XXX.XXX.XXX
SELECT count(*)
from users
where country like 'Iceland'
and last_connection like '112.%';

-- 6. Listado de usuarios de Iceland, tienen dirección IP
-- que inicia en 112 ó 28 ó 188
-- Tip: Agrupar condiciones entre paréntesis 
SELECT
    first_name,
    last_name,
    country,
    last_connection
from
    users
where
    country like 'Iceland'
    and (last_connection like '112.%'
    OR last_connection like '28.%'
    OR last_connection like '188.%');

-- 7. Ordene el resultado anterior, por apellido (last_name) ascendente
-- y luego el first_name ascendentemente también
SELECT
    first_name,
    last_name,
    country,
    last_connection
from
    users
where
    country like 'Iceland'
    and (
        last_connection like '112.%'
        OR last_connection like '28.%'
        OR last_connection like '188.%'
    )
order by
    2 ASC,
    1 ASC;


-- 8. Listado de personas cuyo país está en este listado
-- ('Mexico', 'Honduras', 'Costa Rica')
-- Ordenar los resultados de por País asc, Primer nombre asc, apellido asc
-- Tip: Investigar IN
-- Tip2: Ver Operadores de Comparación en la hoja de atajos (primera página)
SELECT
    first_name,
    last_name,
    country
from
    users
where
    country IN ('Mexico', 'Honduras', 'Costa Rica')
ORDER BY
    3 ASC,
    1 ASC,
    2 ASC;

-- 9. Del query anterior, cuente cuántas personas hay por país
-- Ordene los resultados por País asc
SELECT
    count(*) as cantidad,
    country
from
    users
where
    country IN ('Mexico', 'Honduras', 'Costa Rica')
GROUP BY
    country
ORDER BY
    2 ASC;