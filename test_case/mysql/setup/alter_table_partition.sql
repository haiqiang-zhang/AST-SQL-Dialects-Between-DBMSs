CREATE TABLE t1 (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  purchased DATE, KEY(id))
PARTITION BY RANGE( YEAR(purchased) ) (
PARTITION p0 VALUES LESS THAN (1990),
PARTITION p1 VALUES LESS THAN (1995),
PARTITION p2 VALUES LESS THAN (2000),
PARTITION p3 VALUES LESS THAN (2005));
INSERT INTO t1 VALUES (1, 'desk organiser', '2003-10-15'), (2, 'CD player', '1993-11-05');
CREATE TABLE t (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  purchased DATE, KEY(id));
CREATE TABLE t2 ( id INT NOT NULL AUTO_INCREMENT, name VARCHAR(50), purchased DATE, KEY(id)) PARTITION BY HASH( YEAR(purchased) ) PARTITIONS 4;
INSERT INTO t2 SELECT * FROM t1;
ALTER TABLE t1 ALGORITHM = COPY, LOCK = SHARED, ADD PARTITION (PARTITION p4 VALUES LESS THAN (2010));
ALTER TABLE t1 ALGORITHM = COPY, LOCK = SHARED, DROP PARTITION p4;
ALTER TABLE t1 ALGORITHM = COPY, LOCK = EXCLUSIVE, ADD PARTITION (PARTITION p4 VALUES LESS THAN (2010));
ALTER TABLE t1 ALGORITHM = COPY, LOCK = EXCLUSIVE, DROP PARTITION p4;