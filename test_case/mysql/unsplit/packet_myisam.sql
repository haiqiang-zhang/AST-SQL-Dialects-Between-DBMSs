CREATE TABLE t3 (c31 INT NOT NULL, c32 LONGTEXT,
                 PRIMARY KEY (c31)) charset latin1 ENGINE=MYISAM;
CREATE TABLE t4 (c41 INT NOT NULL, c42 LONGTEXT,
                 PRIMARY KEY (c41)) charset latin1 ENGINE=MYISAM;
INSERT INTO t3 VALUES(100,'a');
INSERT INTO t3 VALUES(111,'abcd');
INSERT INTO t3 VALUES(122,'b');
INSERT INTO t4
SELECT c31, CONCAT(c32,
                   REPEAT('a', @max_allowed_packet-1))
FROM t3;
SELECT c41, LENGTH(c42) FROM t4;
UPDATE t3
SET c32= CONCAT(c32,
                REPEAT('a', @max_allowed_packet-1));
DROP TABLE t3, t4;
