SELECT a, length(a), a='', a=' ', a='  ' FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  popisek varchar(30) collate cp1250_general_ci NOT NULL default '',
 PRIMARY KEY  (`popisek`)
);
INSERT INTO t1 VALUES ('2005-01-1');
SELECT * FROM t1 WHERE popisek = '2005-01-1';
SELECT * FROM t1 WHERE popisek LIKE '2005-01-1';
drop table t1;
CREATE TABLE t1
(
 id  INT AUTO_INCREMENT PRIMARY KEY,
 str VARCHAR(32)  CHARACTER SET cp1250 COLLATE cp1250_czech_cs NOT NULL default '',
 UNIQUE KEY (str)
);
INSERT INTO t1 VALUES (NULL, 'a');
INSERT INTO t1 VALUES (NULL, 'aa');
INSERT INTO t1 VALUES (NULL, 'aaa');
INSERT INTO t1 VALUES (NULL, 'aaaa');
INSERT INTO t1 VALUES (NULL, 'aaaaa');
INSERT INTO t1 VALUES (NULL, 'aaaaaa');
INSERT INTO t1 VALUES (NULL, 'aaaaaaa');
select * from t1 where str like 'aa%';
drop table t1;
create table t1 (a varchar(15) collate cp1250_czech_cs NOT NULL, primary key(a));
drop table t1;
