drop table if exists t1;
CREATE TABLE t1 (
  a char(5) NOT NULL,
  b char(4) NOT NULL,
  KEY (a),
  KEY (b)
) charset utf8mb4;
INSERT INTO t1 VALUES ('A','B'),('b','A'),('C','c'),('D','E'),('a','a');
