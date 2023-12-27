
select * from users;

--Suponemos que queremos ordenar usuarios por paises

--Suponemos que queremos ordenar usuarios por paises ordenándolos por cantidad en cada país
select
    count(*),
    country
from
    users
group by
    country
order by
    count(*) DESC;

-- ahora queremos solo los paises que tienen mas de 6 ordenado por cantidad
select
    count(*) as total,
    country
from
    users
group by
    country
HAVING
   count(*) > 6
ORDER BY
    count(*) DESC;

