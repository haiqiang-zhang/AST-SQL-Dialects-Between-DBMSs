DROP TABLE IF EXISTS TESTTABLE;
CREATE TABLE TESTTABLE (
  _id UInt64,  pt String, attr_list Array(String)
) ENGINE = MergeTree() PARTITION BY (pt) ORDER BY tuple();
INSERT INTO TESTTABLE values (0,'0',['1']), (1,'1',['1']);
SET max_threads = 1;
SET max_bytes_before_external_sort = 0;
