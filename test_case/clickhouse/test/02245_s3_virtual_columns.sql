-- Tag no-fasttest: Depends on AWS

-- { echo }
drop table if exists test_02245;
insert into test_02245 select 1 settings s3_truncate_on_insert=1;
select * from test_02245;
select _path from test_02245;
drop table if exists test_02245_2;
insert into test_02245_2 select 1, 2 settings s3_truncate_on_insert=1;
select * from test_02245_2;
select _path from test_02245_2;