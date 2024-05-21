truncate table file_delim;
insert into file_delim select 1, 2;
select * from file_delim;
select * from url_delim;
drop table file_delim;
drop table url_delim;