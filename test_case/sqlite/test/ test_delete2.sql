BEGIN;
INSERT INTO q(s,id) VALUES('hello','id.1');
INSERT INTO q(s,id) VALUES('goodbye','id.2');
INSERT INTO q(s,id) VALUES('again','id.3');
SELECT * FROM q;
SELECT * FROM q WHERE id='id.1';
PRAGMA integrity_check;
PRAGMA integrity_check;
DELETE FROM q WHERE rowid=1;
PRAGMA integrity_check;
SELECT * FROM q;
DELETE FROM q WHERE rowid=1;
PRAGMA integrity_check;
SELECT * FROM q;
CREATE TABLE t1(a, b);
CREATE TABLE t2(c, d);
INSERT INTO t1 VALUES(1, 2);
INSERT INTO t2 VALUES(3, 4);
INSERT INTO t2 VALUES(5, 6);
