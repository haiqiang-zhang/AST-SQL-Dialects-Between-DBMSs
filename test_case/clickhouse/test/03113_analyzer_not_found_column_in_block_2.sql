drop table if exists t;
create table t  (ID String) Engine= Memory();
insert into t values('a'),('b'),('c');
-- inconsistencies for distributed queries.
set optimize_if_transform_strings_to_enum=0;
set allow_experimental_analyzer=1;
drop table if exists t;