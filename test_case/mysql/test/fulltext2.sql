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
insert t1 (a) values ('aaaxxx'),('aaayyy');
insert t1 (a) values ('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz');
select count(*) from t1 where match a against ('aaaxxx');
select count(*) from t1 where match a against ('aaayyy');
select count(*) from t1 where match a against ('aaazzz');
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
insert t1 (a) values ('aaaxxx'),('aaayyy');
insert t1 (a) values ('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz'),('aaazzz');
select count(*) from t1 where match a against ('aaaxxx');
select count(*) from t1 where match a against ('aaayyy');
select count(*) from t1 where match a against ('aaazzz');
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
create table t1(a text,fulltext(a)) collate=utf8_swedish_ci;
insert into t1 values('test testÃÂÃÂ '),('test'),('test'),('test'),
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
insert into t1 values('abÃÂÃÂ c d');
update t1 set a='ab c d';
select * from t1 where match a against('abÃÂÃÂ c' in boolean mode);
drop table t1;
CREATE TABLE t1(a VARCHAR(255), FULLTEXT(a)) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES('ÃÂ¢ÃÂÃÂMySQLÃÂ¢ÃÂÃÂ');
SELECT a FROM t1 WHERE MATCH a AGAINST('ÃÂ¢ÃÂÃÂMySQLÃÂ¢ÃÂÃÂ' IN BOOLEAN MODE);
DROP TABLE t1;
