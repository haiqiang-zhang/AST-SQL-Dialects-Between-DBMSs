
CREATE TABLE t1(
  col1_pk INTEGER PRIMARY KEY,
  col2 INTEGER
);

INSERT INTO t1 VALUES (0,0),(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7);

-- Make the table even smaller to be able to test COND_FILTER_INEQUALITY
TRUNCATE TABLE t1;
INSERT INTO t1 VALUES (0,0),(1,1);

DROP TABLE t1;

CREATE TABLE t1(
  day_of_week enum('0','1','2','3','4','5','6'),
  bit1 bit(1),
  bit3 bit(3)
);

INSERT INTO t1 VALUES (1+RAND()*7, RAND()*2, RAND()*8),
                      (1+RAND()*7, RAND()*2, RAND()*8);

let $iteration= 0;
let $i= 2;
{
  eval INSERT INTO t1 SELECT 1+RAND()*7, RAND()*2, RAND()*8 FROM t1;
  let $i=$i*2;
  inc $iteration;

DROP TABLE t1;
