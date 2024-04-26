
--
-- test of new fulltext search features
--

--
-- two-level tree
--

--disable_warnings
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
  i int(10) unsigned not null auto_increment primary key,
  a varchar(255) not null,
  FULLTEXT KEY (a)
) ENGINE=MyISAM;

-- two-level entry, second-level tree with depth 2
--disable_query_log
let $1=260;
{
  eval insert t1 (a) values ('aaaxxx');
  dec $1;

-- two-level entry, second-level tree has only one page
let $1=255;
{
  eval insert t1 (a) values ('aaazzz');
  dec $1;

-- one-level entry (entries)
let $1=250;
{
  eval insert t1 (a) values ('aaayyy');
  dec $1;

-- converting to two-level
repair table t1 quick;

select count(*) from t1 where match a against ('aaaxxx');
select count(*) from t1 where match a against ('aaayyy');
select count(*) from t1 where match a against ('aaazzz');
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaayyy' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
select count(*) from t1 where match a against ('aaaxxx aaayyy aaazzz');
select count(*) from t1 where match a against ('aaaxxx aaayyy aaazzz' in boolean mode);

select count(*) from t1 where match a against ('aaax*' in boolean mode);
select count(*) from t1 where match a against ('aaay*' in boolean mode);
select count(*) from t1 where match a against ('aaa*' in boolean mode);

-- mi_write:

insert t1 (a) values ('aaaxxx'),('aaayyy');
insert t1 (a) values ('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz');
select count(*) from t1 where match a against ('aaaxxx');
select count(*) from t1 where match a against ('aaayyy');
select count(*) from t1 where match a against ('aaazzz');

-- mi_delete
insert t1 (a) values ('aaaxxx 000000');
select count(*) from t1 where match a against ('000000');
delete from t1 where match a against ('000000');
select count(*) from t1 where match a against ('000000');
select count(*) from t1 where match a against ('aaaxxx');
delete from t1 where match a against ('aaazzz');
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaayyy' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
select count(*) from t1 where a = 'aaaxxx';
select count(*) from t1 where a = 'aaayyy';
select count(*) from t1 where a = 'aaazzz';

-- update
insert t1 (a) values ('aaaxxx 000000');
select count(*) from t1 where match a against ('000000');
update t1 set a='aaazzz' where match a against ('000000');
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
update t1 set a='aaazzz' where a = 'aaaxxx';
update t1 set a='aaaxxx' where a = 'aaayyy';
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaayyy' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);

drop table t1;

CREATE TABLE t1 (
  i int(10) unsigned not null auto_increment primary key,
  a varchar(255) not null,
  FULLTEXT KEY (a)
) ENGINE=MyISAM;

--
-- now same as about but w/o repair table
-- 2-level tree created by mi_write
--

-- two-level entry, second-level tree with depth 2
--disable_query_log
let $1=260;
{
  eval insert t1 (a) values ('aaaxxx');
  dec $1;
let $1=255;
{
  eval insert t1 (a) values ('aaazzz');
  dec $1;
let $1=250;
{
  eval insert t1 (a) values ('aaayyy');
  dec $1;

select count(*) from t1 where match a against ('aaaxxx');
select count(*) from t1 where match a against ('aaayyy');
select count(*) from t1 where match a against ('aaazzz');
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaayyy' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
select count(*) from t1 where match a against ('aaaxxx aaayyy aaazzz');
select count(*) from t1 where match a against ('aaaxxx aaayyy aaazzz' in boolean mode);

select count(*) from t1 where match a against ('aaax*' in boolean mode);
select count(*) from t1 where match a against ('aaay*' in boolean mode);
select count(*) from t1 where match a against ('aaa*' in boolean mode);

-- mi_write:

insert t1 (a) values ('aaaxxx'),('aaayyy');
insert t1 (a) values ('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz');
select count(*) from t1 where match a against ('aaaxxx');
select count(*) from t1 where match a against ('aaayyy');
select count(*) from t1 where match a against ('aaazzz');

-- mi_delete
insert t1 (a) values ('aaaxxx 000000');
select count(*) from t1 where match a against ('000000');
delete from t1 where match a against ('000000');
select count(*) from t1 where match a against ('000000');
select count(*) from t1 where match a against ('aaaxxx');
delete from t1 where match a against ('aaazzz');
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaayyy' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
select count(*) from t1 where a = 'aaaxxx';
select count(*) from t1 where a = 'aaayyy';
select count(*) from t1 where a = 'aaazzz';

-- update
insert t1 (a) values ('aaaxxx 000000');
select count(*) from t1 where match a against ('000000');
update t1 set a='aaazzz' where match a against ('000000');
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
update t1 set a='aaazzz' where a = 'aaaxxx';
update t1 set a='aaaxxx' where a = 'aaayyy';
select count(*) from t1 where match a against ('aaaxxx' in boolean mode);
select count(*) from t1 where match a against ('aaayyy' in boolean mode);
select count(*) from t1 where match a against ('aaazzz' in boolean mode);
drop table t1;

--
-- BUG#11336
--
-- for uca collation isalnum and strnncollsp don't agree on whether
-- 0xC2A0 is a space (strnncollsp is right, isalnum is wrong).
--
-- they still don't, the bug was fixed by avoiding strnncollsp
--

set names utf8mb3;
create table t1(a text,fulltext(a)) collate=utf8_swedish_ci;
insert into t1 values('test test '),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test'),
('test'),('test'),('test'),('test'),('test'),('test'),('test'),('test');
delete from t1 limit 1;

--
-- BUG#16489: utf8mb3 + fulltext leads to corrupt index file.
--
truncate table t1;
insert into t1 values('ab c d');
update t1 set a='ab c d';
select * from t1 where match a against('ab c' in boolean mode);
drop table t1;
set names latin1;

-- End of 4.1 tests

--
-- BUG#19580 - FULLTEXT search produces wrong results on UTF-8 columns
--
SET NAMES utf8mb3;
CREATE TABLE t1(a VARCHAR(255), FULLTEXT(a)) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES('„MySQL“');
SELECT a FROM t1 WHERE MATCH a AGAINST('“MySQL„' IN BOOLEAN MODE);
DROP TABLE t1;
SET NAMES latin1;
