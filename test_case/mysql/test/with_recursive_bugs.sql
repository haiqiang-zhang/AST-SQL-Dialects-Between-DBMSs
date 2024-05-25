CREATE TABLE t1(c1 DATETIME, c2 INT, KEY(c1));
DROP TABLE t1;
CREATE TABLE A (
  col_date date DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_blob_key blob,
  col_varchar varchar(1) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_blob blob,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_datetime_key (col_datetime_key),
  KEY col_time_key (col_time_key),
  KEY col_varchar_key (col_varchar_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_date_key (col_date_key)
) DEFAULT CHARSET=latin1;
CREATE TABLE AA (
  col_varchar varchar(1) DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_time time DEFAULT NULL,
  col_int_key int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_blob blob,
  col_blob_key blob,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key),
  KEY col_date_key (col_date_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_time_key (col_time_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255))
) DEFAULT CHARSET=latin1;
CREATE TABLE BB (
  col_date date DEFAULT NULL,
  col_blob_key blob,
  col_time time DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_blob blob,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_key int(11) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_varchar_key (col_varchar_key),
  KEY col_int_key (col_int_key),
  KEY col_time_key (col_time_key),
  KEY col_datetime_key (col_datetime_key),
  KEY col_date_key (col_date_key)
) AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
CREATE TABLE D (
  col_varchar_key varchar(1) DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_int int(11) DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_blob blob,
  col_int_key int(11) DEFAULT NULL,
  col_blob_key blob,
  col_varchar varchar(1) DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pk),
  KEY col_varchar_key (col_varchar_key),
  KEY col_date_key (col_date_key),
  KEY col_int_key (col_int_key),
  KEY col_blob_key (col_blob_key(255)),
  KEY col_datetime_key (col_datetime_key),
  KEY col_time_key (col_time_key)
) DEFAULT CHARSET=latin1;
DROP TABLE IF EXISTS A, AA, BB, D;
create table t1(a int);
insert into t1 values(1),(2);
drop table t1;
CREATE TABLE D (col_int INT);
CREATE TABLE C (
  col_int2 INT,
  pk INT NOT NULL,
  col_int INT,
  PRIMARY KEY (pk)
);
INSERT INTO C VALUES
(7,1,3),(7,2,3),(5,3,4),(1,4,6),(5,5,2),
(5,6,9),(4,7,9),(7,8,3),(3,9,0),(5,10,3);
CREATE TABLE BB (
  pk INT NOT NULL,
  col_int INT,
  PRIMARY KEY (pk)
);
INSERT INTO BB VALUES (1,0),(2,6),(3,2),(4,5),(5,0);
DROP TABLE BB,C,D;
SELECT *
FROM
(VALUES ROW(1),ROW(1)) AS dt(a)
WHERE
EXISTS(
  WITH RECURSIVE qn AS (SELECT a*0 AS b UNION ALL SELECT b+1 FROM qn WHERE b=0)
  SELECT * FROM qn WHERE b=a
  );
SELECT *
FROM
(VALUES ROW(1),ROW(1)) AS dt(a)
WHERE
NOT EXISTS(
  WITH RECURSIVE qn AS (SELECT a*0 AS b UNION ALL SELECT b+1 FROM qn WHERE b=0)
  SELECT * FROM qn WHERE b=a
  );
CREATE TABLE t1 (a INTEGER);
DROP TABLE t1;
