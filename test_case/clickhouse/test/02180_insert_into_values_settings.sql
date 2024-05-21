drop table if exists t;
create table t (x Bool) engine=Memory();
insert into t settings bool_true_representation='Ð´Ð°' values ('Ð´Ð°');
drop table t;