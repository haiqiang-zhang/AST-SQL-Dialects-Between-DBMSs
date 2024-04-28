CREATE TABLE a (i TINYINT);
INSERT INTO a VALUES (42);
PREPARE s3 AS SELECT * FROM a WHERE i=$1;
EXECUTE s3(10000);
EXECUTE s3(42);
EXECUTE s3(84);
DEALLOCATE s3;
SELECT * FROM a WHERE i=$1;
SELECT * FROM a WHERE i=CAST($1 AS VARCHAR);
PREPARE s1 AS SELECT to_years($1), CAST(list_value($1) AS BIGINT[]);;
EXECUTE s1(1);;
