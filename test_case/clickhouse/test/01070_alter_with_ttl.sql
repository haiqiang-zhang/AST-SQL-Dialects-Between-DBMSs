show create table alter_ttl;
drop table alter_ttl;
create table alter_ttl(d Date, s String) engine = MergeTree order by d ttl d + interval 1 month;
alter table alter_ttl modify column s String ttl d + interval 1 day;
show create table alter_ttl;
drop table alter_ttl;
