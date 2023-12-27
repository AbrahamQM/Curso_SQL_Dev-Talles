--https://github.com/Klerith/pg-curso-sql/tree/fin-seccion-3

select * from users;


-- Obtener el nombre y apellido por separado con substring(campo, posInicio, posFin-opcional) y position( caracteres IN campo) 
select
    name as full_name,
    SUBSTRING(name, 0, POSITION( ' '  in name)) as first_name,
    SUBSTRING(name, POSITION( ' '  in name) + 1, LENGTH(name)) as last_name,
    POSITION( ' '  in name) as posición_espacio
    from users;
    
--Lo mismo pero usando el trim en lugar de saltarnos la posición del espacio
select
    name as full_name,
    SUBSTRING(name, 0, POSITION( ' '  in name)) as first_name,
    TRIM(SUBSTRING(name, POSITION( ' '  in name))) as last_name,
    POSITION( ' '  in name) as posición_espacio
    from users;
    
    
--Tarea First y Last name insertar en dos nuevas columnas el nombre y apellido por separado:
--Hasta aquí, solo teníiamos la columna 'name' ->Hemos añadido las columnas first_name y last_name a mano desde Structure
--comprobamos los cambios en la tabla
select * from users; --los nuevos campos aparecen a NULL

--Solución
update
    users
set
    first_name = SUBSTRING(name, 0, POSITION(' ' in name)),
    last_name = TRIM(SUBSTRING(name, POSITION(' ' in name)));
