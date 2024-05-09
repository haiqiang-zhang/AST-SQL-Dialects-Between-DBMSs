CREATE TABLE t1(
  col1_pk INTEGER PRIMARY KEY,
  col2 INTEGER
);
INSERT INTO t1 VALUES (0,0),(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7);
DROP TABLE t1;
CREATE TABLE t1(
  day_of_week enum('0','1','2','3','4','5','6'),
  bit1 bit(1),
  bit3 bit(3)
);
DROP TABLE t1;
