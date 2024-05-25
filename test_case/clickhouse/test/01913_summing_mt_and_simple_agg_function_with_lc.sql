select k, city from smta;
insert into smta(k, city) values (1, 'y');
optimize table smta;
select k, city from smta;
drop table if exists smta;
