SELECT * FROM users;

-- contar los registros de la tabla con count()
select
    count(*) as total_users
from
    users;

--obtener además, el valor de followers mínimo y máximo, promedio de followers, 
select
	count(*) as total_users,
    min(followers) as menor_no_seguidores, -- el valor de followers mínimo
    max(followers) as máximo_no_seguidores, --el valor de followers máximo
    avg(followers) as avg_followers, --promedio de followers con la función average
    SUM(followers) / count(followers) as avg_followers_manual, --promedio de followers con las funciónes sum y count
    ROUND(avg(followers)) as round_avg_followers --promedio de followers con la función average SIN DECIMALES(redondeado)
FROM
    users;
--

