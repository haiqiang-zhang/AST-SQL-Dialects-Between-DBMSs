SET max_threads = 2;
SET optimize_read_in_order = 1;
DROP TABLE IF EXISTS TESTTABLE4;
CREATE TABLE TESTTABLE4 (_id UInt64, pt String, l String ) 
ENGINE = MergeTree() PARTITION BY (pt) ORDER BY (_id);
INSERT INTO TESTTABLE4 VALUES (0,'1','1'), (1,'0','1');