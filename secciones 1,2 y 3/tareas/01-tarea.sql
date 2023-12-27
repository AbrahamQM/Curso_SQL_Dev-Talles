

-- 1. Ver todos los registros
select * from users;

-- 2. Ver el registro cuyo id sea igual a 10
select * from users where id = 10;

-- 3. Quiero todos los registros que cuyo primer nombre sea Jim (engañosa)
select * from users WHERE name like 'Jim %';

-- 4. Todos los registros cuyo segundo nombre es Alexander
select * from users WHERE name like '% Alexander';

-- 5. Cambiar el nombre del registro con id = 1, por tu nombre Ej:'Fernando Herrera'
update users set name = 'Abraham Quintana' where id = 1 ;
select * from users WHERE name like 'Abra%';

-- 6. Borrar el último registro de la tabla
delete from
    users
where
    id = (
        select
            count(*)
        from
            users
    );
-- como lo hizo el profe
delete from
    users
where
    id = (select max(id) from users);
    