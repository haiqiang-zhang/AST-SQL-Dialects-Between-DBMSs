DROP TABLE IF EXISTS t1;
CREATE TABLE t1(data LONGBLOB);
INSERT INTO t1 SELECT CONCAT(REPEAT('1', 1024*1024 - 27), 
                             "\'\r dummydb dummyhost");
DROP TABLE t1;
