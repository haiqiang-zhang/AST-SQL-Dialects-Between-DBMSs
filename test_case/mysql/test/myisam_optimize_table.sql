DROP DATABASE IF EXISTS test_bug30869674;
CREATE DATABASE test_bug30869674;
CREATE TABLE t1(id int, name varchar(255), description varchar(255), count int, primary key(id)) ENGINE=myisam;
INSERT INTO t1 VALUES (1, "test1", "description1", 1), (2, "test2", "description2", 2), (3, "test3", "description3", 3);
UPDATE t1 SET name="testing test2" WHERE id=2;
DROP DATABASE test_bug30869674;
