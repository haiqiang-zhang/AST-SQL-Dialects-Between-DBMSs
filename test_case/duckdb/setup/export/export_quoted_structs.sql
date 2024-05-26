BEGIN TRANSACTION;
create table a (s STRUCT("end" VARCHAR));
insert into a values ({"end":'hello'});
