SELECT * FROM t1, t2 LEFT JOIN t3 ON q=x WHERE p=2 AND a=q;
CREATE TABLE parent1(parent1key, child1key, Child2key, child3key);
CREATE TABLE child1 ( child1key NVARCHAR, value NVARCHAR );
CREATE UNIQUE INDEX PKIDXChild1 ON child1 ( child1key );
CREATE TABLE child2 ( child2key NVARCHAR, value NVARCHAR );
INSERT INTO parent1(parent1key,child1key,child2key)
       VALUES ( 1, 'C1.1', 'C2.1' );
INSERT INTO child1 ( child1key, value ) VALUES ( 'C1.1', 'Value for C1.1' );
INSERT INTO child2 ( child2key, value ) VALUES ( 'C2.1', 'Value for C2.1' );
INSERT INTO parent1 ( parent1key, child1key, child2key )
       VALUES ( 2, 'C1.2', 'C2.2' );
INSERT INTO child2 ( child2key, value ) VALUES ( 'C2.2', 'Value for C2.2' );
INSERT INTO parent1 ( parent1key, child1key, child2key )
       VALUES ( 3, 'C1.3', 'C2.3' );
INSERT INTO child1 ( child1key, value ) VALUES ( 'C1.3', 'Value for C1.3' );
INSERT INTO child2 ( child2key, value ) VALUES ( 'C2.3', 'Value for C2.3' );
SELECT parent1.parent1key, child1.value, child2.value
    FROM parent1
    LEFT OUTER JOIN child1 ON child1.child1key = parent1.child1key
    INNER JOIN child2 ON child2.child2key = parent1.child2key;
CREATE TABLE tA(apk integer primary key, ax);
CREATE TABLE tB(bpk integer primary key, bx);
CREATE TABLE tC(cpk integer primary key, cx);
CREATE TABLE tD(dpk integer primary key, dx);
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND bpk=ax;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND bpk=ax;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON cx=dpk
     WHERE cpk=bx AND bpk=ax;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON cx=dpk
     WHERE cpk=bx AND bpk=ax;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON cx=dpk
     WHERE bx=cpk AND bpk=ax;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON cx=dpk
     WHERE bx=cpk AND bpk=ax;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON cx=dpk
     WHERE bx=cpk AND ax=bpk;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON cx=dpk
     WHERE bx=cpk AND ax=bpk;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE bx=cpk AND ax=bpk;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE bx=cpk AND ax=bpk;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND ax=bpk;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND ax=bpk;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND apk=bx;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND apk=bx;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND apk=bx;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND apk=bx;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE apk=cx AND bpk=ax;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE apk=cx AND bpk=ax;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=ax AND bpk=cx;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=ax AND bpk=cx;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE bpk=cx AND apk=bx;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE bpk=cx AND apk=bx;
SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND apk=cx;
EXPLAIN QUERY PLAN 
    SELECT * FROM tA, tB, tC LEFT JOIN tD ON dpk=cx
     WHERE cpk=bx AND apk=cx;
CREATE TABLE t301(a INTEGER PRIMARY KEY,b,c);
CREATE INDEX t301c ON t301(c);
INSERT INTO t301 VALUES(1,2,3);
INSERT INTO t301 VALUES(2,2,3);
CREATE TABLE t302(x, y);
INSERT INTO t302 VALUES(4,5);
ANALYZE;
SELECT * FROM t301 WHERE c=3 AND a IS NULL;
SELECT * FROM t301 WHERE c=3 AND a IS NOT NULL;
CREATE TABLE aaa (id INTEGER PRIMARY KEY, type INTEGER,
                    fk INTEGER DEFAULT NULL, parent INTEGER,
                    position INTEGER, title LONGVARCHAR,
                    keyword_id INTEGER, folder_type TEXT,
                    dateAdded INTEGER, lastModified INTEGER);
CREATE INDEX aaa_111 ON aaa (fk, type);
CREATE INDEX aaa_222 ON aaa (parent, position);
CREATE INDEX aaa_333 ON aaa (fk, lastModified);
CREATE TABLE bbb (id INTEGER PRIMARY KEY, type INTEGER,
                    fk INTEGER DEFAULT NULL, parent INTEGER,
                    position INTEGER, title LONGVARCHAR,
                    keyword_id INTEGER, folder_type TEXT,
                    dateAdded INTEGER, lastModified INTEGER);
CREATE INDEX bbb_111 ON bbb (fk, type);
CREATE INDEX bbb_222 ON bbb (parent, position);
CREATE INDEX bbb_333 ON bbb (fk, lastModified);
CREATE TABLE t71(x1 INTEGER PRIMARY KEY, y1);
CREATE TABLE t72(x2 INTEGER PRIMARY KEY, y2);
CREATE TABLE t73(x3, y3);
CREATE TABLE t74(x4, y4);
INSERT INTO t71 VALUES(123,234);
INSERT INTO t72 VALUES(234,345);
INSERT INTO t73 VALUES(123,234);
INSERT INTO t74 VALUES(234,345);
INSERT INTO t74 VALUES(234,678);
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 WHERE y2 IS NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 WHERE y2 IS NOT NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 AND y2 IS NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 AND y2 IS NOT NULL;
SELECT x3 FROM t73 LEFT JOIN t72 ON x2=y3;
SELECT DISTINCT x3 FROM t73 LEFT JOIN t72 ON x2=y3;
SELECT x3 FROM t73 LEFT JOIN t74 ON x4=y3;
SELECT DISTINCT x3 FROM t73 LEFT JOIN t74 ON x4=y3;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 WHERE y2 IS NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 WHERE y2 IS NOT NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 AND y2 IS NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 AND y2 IS NOT NULL;
SELECT x3 FROM t73 LEFT JOIN t72 ON x2=y3;
SELECT DISTINCT x3 FROM t73 LEFT JOIN t72 ON x2=y3;
SELECT x3 FROM t73 LEFT JOIN t74 ON x4=y3;
SELECT DISTINCT x3 FROM t73 LEFT JOIN t74 ON x4=y3;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 WHERE y2 IS NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 WHERE y2 IS NOT NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 AND y2 IS NULL;
SELECT x1 FROM t71 LEFT JOIN t72 ON x2=y1 AND y2 IS NOT NULL;
SELECT x3 FROM t73 LEFT JOIN t72 ON x2=y3;
SELECT DISTINCT x3 FROM t73 LEFT JOIN t72 ON x2=y3;
SELECT x3 FROM t73 LEFT JOIN t74 ON x4=y3;
SELECT DISTINCT x3 FROM t73 LEFT JOIN t74 ON x4=y3;
INSERT INTO t2 VALUES(3,4);
