SELECT * FROM c3 WHERE x=y AND y=z AND z='abc';
SELECT * FROM c3 WHERE x='abc' AND y='abc' AND z='abc';
CREATE TABLE A(id INTEGER PRIMARY KEY, label TEXT);
CREATE TABLE B(id INTEGER PRIMARY KEY, label TEXT, Aid INTEGER);
CREATE TABLE C(
    id INTEGER PRIMARY KEY,
    xx INTEGER NOT NULL,
    yy INTEGER,
    zz INTEGER
  );
CREATE UNIQUE INDEX x2 ON C(yy);
CREATE UNIQUE INDEX x4 ON C(yy, zz);
INSERT INTO A(id) VALUES(1);
INSERT INTO B(id) VALUES(2);
INSERT INTO C(id,xx,yy,zz) VALUES(99,50,1,2);
SELECT 1
    FROM A,
         (SELECT id,xx,yy,zz FROM C) subq,
         B
   WHERE A.id='1'
     AND A.id=subq.yy
     AND B.id=subq.zz;
SELECT 1
    FROM A,
         (SELECT id,xx,yy,zz FROM C) subq,
         B
   WHERE A.id=1
     AND A.id=subq.yy
     AND B.id=subq.zz;
SELECT 1
    FROM A,
         (SELECT id,yy,zz FROM C) subq,
         B
   WHERE A.id='1'
     AND A.id=subq.yy
     AND B.id=subq.zz;
CREATE TABLE x(a, b, c);
CREATE TABLE y(a, b);
INSERT INTO x VALUES (1, 0, 1);
INSERT INTO y VALUES (1, 2);
SELECT x.a FROM x JOIN y ON x.c = y.a WHERE x.b = 1 AND x.b = 1;
PRAGMA automatic_index=OFF;
CREATE TABLE t0(c0);
INSERT INTO t0 VALUES('0');
CREATE VIEW v0(c0) AS SELECT CAST(0 AS INT) FROM t0;
SELECT 200, * FROM t0, v0 WHERE 0 = t0.c0 AND t0.c0 = v0.c0;
SELECT 200, * FROM t0, v0 WHERE t0.c0 = 0 AND t0.c0 = v0.c0;
SELECT 200, * FROM t0, v0 WHERE 0 = t0.c0 AND v0.c0 = t0.c0;
SELECT 200, * FROM t0, v0 WHERE t0.c0 = 0 AND v0.c0 = t0.c0;
CREATE TABLE tableA(
    ID           int,
    RunYearMonth int
  );
INSERT INTO tableA VALUES(1,202003),(2,202003),(3,202003),(4,202004),
    (5,202004),(6,202004),(7,202004),(8,202004);
CREATE TABLE tableB (
    ID           int,
    RunYearMonth int
  );
INSERT INTO tableB VALUES(1,202004),(2,202004),(3,202004),(4,202004),
  (5,202004);
SELECT *
   FROM (
        SELECT *
        FROM tableA
        WHERE RunYearMonth = 202004
    ) AS A
    INNER JOIN (
        SELECT *
        FROM tableB
        WHERE RunYearMonth = 202004
    ) AS B
    ON A.ID = B.ID
    AND A.RunYearMonth = B.RunYearMonth;
CREATE INDEX i0 ON t1(NULL);
