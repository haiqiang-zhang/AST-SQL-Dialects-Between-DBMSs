select * from limit_by order by id, val limit 2, 2 by id;
select * from limit_by order by id, val limit 2 offset 1 by id;
select * from limit_by order by id, val limit 1, 2 by id limit 3;
select * from limit_by order by id, val limit 1, 2 by id limit 3 offset 1;
drop table limit_by;
