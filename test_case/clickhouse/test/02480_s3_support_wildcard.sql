-- Tag no-fasttest: Depends on AWS

-- { echo }
drop table if exists test_02480_support_wildcard_write;
drop table if exists test_02480_support_wildcard_write2;
set s3_truncate_on_insert=1;
insert into test_02480_support_wildcard_write values (1, 'a'), (22, 'b'), (333, 'c');
set s3_truncate_on_insert=1;
insert into test_02480_support_wildcard_write2 values (4, 'd'), (55, 'f'), (666, 'g');
drop table test_02480_support_wildcard_write;
drop table test_02480_support_wildcard_write2;