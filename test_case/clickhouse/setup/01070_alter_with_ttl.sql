drop table if exists alter_ttl;
SET allow_suspicious_ttl_expressions = 1;
create table alter_ttl(i Int) engine = MergeTree order by i ttl toDate('2020-05-05');
alter table alter_ttl add column s String;
alter table alter_ttl modify column s String ttl toDate('2020-01-01');
