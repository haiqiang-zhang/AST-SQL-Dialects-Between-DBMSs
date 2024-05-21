set prefer_localhost_replica=0;
drop table if exists dist_01555;
drop table if exists data_01555;
create table data_01555 (key Int) Engine=Null();
-- masked flush only
--
SELECT 'masked flush only';
system stop distributed sends dist_01555;
-- masked
--
SELECT 'masked';
-- no masking
--
SELECT 'no masking';
drop table data_01555;
