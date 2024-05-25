drop table if exists t;
create table t (x Bool) engine=Memory();
insert into t settings bool_true_representation='ÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂ°' values ('ÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂ°');
drop table t;
