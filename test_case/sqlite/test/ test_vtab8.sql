CREATE TABLE t2244(a, b);
INSERT INTO t2244 VALUES('AA', 'BB');
INSERT INTO t2244 VALUES('CC', 'DD');
CREATE TABLE t2250(a, b);
INSERT INTO t2250 VALUES(10, 20);
select max(rowid) from t2250;
CREATE TABLE t2260a_real(a, b);
CREATE TABLE t2260b_real(a, b);
CREATE INDEX i2260 ON t2260a_real(a);
CREATE INDEX i2260x ON t2260b_real(a);
