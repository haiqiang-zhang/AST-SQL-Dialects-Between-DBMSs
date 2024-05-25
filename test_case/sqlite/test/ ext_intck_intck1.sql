WITH wrapper(c1, c2, c3) AS (
    SELECT a, b, c FROM x1
  )
  SELECT * FROM wrapper WHERE c1='letters';
WITH wrapper(c1, c2, c3) AS (
    SELECT a, b, c FROM x1
  )
  SELECT * FROM wrapper WHERE c2='1234';
WITH wrapper(c1, c2, c3) AS (
    SELECT a, b, c FROM x1
  )
  SELECT * FROM wrapper WHERE c3='1234';
CREATE TABLE z1(a, b);
CREATE INDEX z1ab ON z1(a+b COLLATE nocase);
SELECT * FROM z1 INDEXED BY z1ab;
CREATE TABLE t1(i INTEGER PRIMARY KEY, b, c);
CREATE INDEX i1 ON t1(b);
ANALYZE;
INSERT INTO sqlite_stat1 VALUES('t1', 'i1', '10000 10000');
ANALYZE sqlite_schema;
CREATE INDEX x1a ON x1(a COLLATE nocase);
INSERT INTO x1 VALUES(1, 2, 'three');
INSERT INTO x1 VALUES(4, 5, 'six');
INSERT INTO x1 VALUES(7, 8, 'nine');
CREATE TABLE www(x, y, z);
CREATE INDEX w1 ON www( (x+1), z );
INSERT INTO www VALUES(1, 1, 1), (2, 2, 2);
PRAGMA writable_schema = 1;
UPDATE sqlite_schema SET sql = 'CREATE INDEX i1' WHERE name='i1';
UPDATE sqlite_schema SET sql = 'CREATE INDEX i1(y' WHERE name='i1';
UPDATE sqlite_schema 
  SET sql = 'CREATE INDEX i1(y) hello world' 
  WHERE name='i1';
UPDATE sqlite_schema 
  SET sql = 'CREATE INDEX i1(y, x) WHERE 1     ' 
  WHERE name='i1';
UPDATE sqlite_schema 
  SET sql = 'CREATE INDEX i1(  ,  ) WHERE 1     ' 
  WHERE name='i1';
UPDATE sqlite_schema 
  SET sql = 'CREATE INDEX i1([y'
  WHERE name='i1';
CREATE INDEX i2 ON x1(  "1"
	 );
