select @@collation_connection;
drop table if exists t1;
create table t1 (a varchar(10), key(a), fulltext (a)) engine=myisam;
insert into t1 values ("a"),("abc"),("abcd"),("hello"),("test");
select * from t1 where a like "abc%";
select * from t1 where a like "test%";
select * from t1 where a like "te_t";
select * from t1 where match a against ("te*" in boolean mode)+0;
drop table t1;
CREATE TABLE t1 (
  col1 varchar(255) NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1 collate latin1_german2_ci;
ALTER TABLE t1 ADD KEY ifword(col1);
DROP TABLE t1;
