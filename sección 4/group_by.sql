select
	count(*) as total_users,
    min(followers) as menor_no_seguidores, -- el valor de followers mínimo
    max(followers) as máximo_no_seguidores, --el valor de followers máximo
    avg(followers) as avg_followers, --promedio de followers con la función average
    SUM(followers) / count(followers) as avg_followers_manual, --promedio de followers con las funciónes sum y count
    ROUND(avg(followers)) as round_avg_followers --promedio de followers con la función average SIN DECIMALES(redondeado)
FROM
    users;
    
    
-- obtenemos quienes son los que tienen los valores mostrados en la query anterior
--los que tienen menor_no_seguidores que eran 4
--los que tienen máximo_no_seguidores que eran 4999
select
    first_name,
    last_name,
    followers
from
    users
WHERE
    followers = 4
    or followers = 4999;



--contabilizamos los reultados de la consulta anterior usando un GROUP BY
select
    COUNT(*) as cantidad,
    followers
from
    users
WHERE
    followers = 4
    or followers = 4999
GROUP BY
    followers;
    
    
--contabilizamos los elementos que tienen un rango de seguidores 4500-4999 GROUP BY & ORDER BY followers
select
    COUNT(*) as cantidad,
    followers
from
    users
WHERE
    followers between 4500
    and 4999
GROUP BY
    followers
order by
    followers DESC;


--Suponemos que queremos ordenar usuarios por paises ordenándolos alfabéticamente por país
select
    count(*),
    country
from
    users
group by
    country
order by
    country;