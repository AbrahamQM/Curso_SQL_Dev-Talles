select * from users;


--Obtenemos todos los distintos paises DISTINT se puese usar también indicando entre paréntesis el campo
select
    DISTINCT country as paises_distintos --DISTINCT(country) as paises_distintos
from
    users;