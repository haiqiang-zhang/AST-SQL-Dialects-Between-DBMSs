create table t (i int primary key);;
create table u (i int references t);;
drop table u;
drop table t;
create table target_tbl (target_col int primary key);;
create table source_tbl(source_col int references target_tbl(target_col));;
select constraint_name
from information_schema.table_constraints
where constraint_type like '%KEY'
order by 1;
select constraint_name
from information_schema.key_column_usage
order by 1;
select constraint_name, unique_constraint_name
from information_schema.referential_constraints;;
select constraint_name
from information_schema.table_constraints
where constraint_type like '%KEY'
order by 1;
select constraint_name
from information_schema.key_column_usage
order by 1;
select constraint_name, unique_constraint_name
from information_schema.referential_constraints;;
