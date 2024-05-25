SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS table1;
DROP TABLE IF EXISTS table2;
CREATE TABLE table1(a String, b Date) ENGINE MergeTree order by a;
CREATE TABLE table2(c String, a String, d Date) ENGINE MergeTree order by c;
INSERT INTO table1 VALUES ('a', '2018-01-01') ('b', '2018-01-01') ('c', '2018-01-01');
INSERT INTO table2 VALUES ('D', 'd', '2018-01-01') ('B', 'b', '2018-01-01') ('C', 'c', '2018-01-01');
DROP TABLE table1;
DROP TABLE table2;
