CREATE TABLE a (i TINYINT);
PREPARE p1 AS SELECT * FROM a;
EXECUTE p1;
EXECUTE p1;
DROP TABLE a;
EXECUTE p1;
DEALLOCATE p1;
