select id, name from users;


-- en mayúsculas
select id, upper(name) as mayúsculas, name as original from users;

-- minúsculas
select id, lower(name) as minúsculas, name as original from users;

