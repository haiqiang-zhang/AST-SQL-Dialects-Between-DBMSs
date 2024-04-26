DROP DATABASE IF EXISTS test_bug30869674;

SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE DATABASE test_bug30869674;
USE test_bug30869674;
CREATE TABLE t1(id int, name varchar(255), description varchar(255), count int, primary key(id)) ENGINE=myisam;
INSERT INTO t1 VALUES (1, "test1", "description1", 1), (2, "test2", "description2", 2), (3, "test3", "description3", 3);

SELECT * FROM test_bug30869674.t1;

UPDATE t1 SET name="testing test2" WHERE id=2;

let $MYSQLD_DATADIR= `select @@datadir`;

-- echo Optimize table should return the correct number of Records and Linkdata
OPTIMIZE TABLE t1;

-- Check that the contents are correct.
SELECT * FROM test_bug30869674.t1;
DROP DATABASE test_bug30869674;
