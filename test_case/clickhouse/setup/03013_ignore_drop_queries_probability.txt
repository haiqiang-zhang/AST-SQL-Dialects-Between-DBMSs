create table test_memory (number UInt64) engine=Memory;
insert into test_memory select 42;
drop table test_memory settings ignore_drop_queries_probability=1;
