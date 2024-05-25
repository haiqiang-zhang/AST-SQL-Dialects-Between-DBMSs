desc table defaulted;
drop table defaulted;
create table defaulted (col1 UInt32, col2 default col1 + 1, col3 materialized col1 + 2, col4 alias col1 + 3) engine=Memory;
desc table defaulted;
insert into defaulted (col1) values (10);
select * from defaulted;
select col3, col4 from defaulted;
drop table defaulted;
set allow_deprecated_syntax_for_merge_tree=1;
