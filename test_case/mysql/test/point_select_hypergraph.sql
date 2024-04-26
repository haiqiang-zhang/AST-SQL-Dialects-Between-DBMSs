
CREATE TABLE t1 ( pk INTEGER NOT NULL, a INTEGER, PRIMARY KEY ( pk ) );
INSERT INTO t1 VALUES (1,10), (2,20), (3,30), (4,40), (5,50), (6,60), (7,70), (8,80), (9,90), (10,100);
SET @v = 2;

DROP TABLE t1;

SET optimizer_switch=DEFAULT;
