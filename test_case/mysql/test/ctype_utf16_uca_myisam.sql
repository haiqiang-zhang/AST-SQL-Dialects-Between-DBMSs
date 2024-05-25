ALTER TABLE t ADD INDEX (c);
SELECT c FROM t WHERE c LIKE 'a%';
DROP TABLE t;
CREATE TABLE t1 (
 c1 text character set utf16 collate utf16_polish_ci NOT NULL
) ENGINE=MyISAM;
insert into t1 values (''),('a');
SELECT COUNT(*), c1 FROM t1 GROUP BY c1;
DROP TABLE IF EXISTS t1;
