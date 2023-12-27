select
    id,
    name
from
    users;
    
-- en mayúsculas
select
    id,
    upper(name) as may ú sculas,
    name as original
from
    users;
    
-- minúsculas
select
    id,
    lower(name) as min ú sculas,
    name as original
from
    users;
    
-- con longitud
select
    id,
    name,
    LENGTH(name) as longitud_de_nombre
from
    users;
    
-- Con constantes
select
    id,
    name,
    (888  + 10) as operaciónConstantes,
    9999 as numeroConstante, 
    'Texto constante' as textoConstante
from
    users;

--concatenación
select
    id,
    name,
    CONCAT(id, '_^^_',  name) as concatenación_Concat,
    id || '_||_' || name as concatenación_Con_Barras
from
    users;
