

CREATE TABLE pxtest1 (foobar VARCHAR(10));

INSERT INTO pxtest1 VALUES ('aaa');


BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE pxtest1 SET foobar = 'bbb' WHERE foobar = 'aaa';
SELECT * FROM pxtest1;
PREPARE TRANSACTION 'foo1';

SELECT * FROM pxtest1;

SELECT gid FROM pg_prepared_xacts;

ROLLBACK PREPARED 'foo1';

SELECT * FROM pxtest1;

SELECT gid FROM pg_prepared_xacts;


BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO pxtest1 VALUES ('ddd');
SELECT * FROM pxtest1;
PREPARE TRANSACTION 'foo2';

SELECT * FROM pxtest1;

COMMIT PREPARED 'foo2';

SELECT * FROM pxtest1;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE pxtest1 SET foobar = 'eee' WHERE foobar = 'ddd';
SELECT * FROM pxtest1;
PREPARE TRANSACTION 'foo3';

SELECT gid FROM pg_prepared_xacts;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
INSERT INTO pxtest1 VALUES ('fff');

PREPARE TRANSACTION 'foo3';

SELECT * FROM pxtest1;

ROLLBACK PREPARED 'foo3';

SELECT * FROM pxtest1;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE pxtest1 SET foobar = 'eee' WHERE foobar = 'ddd';
SELECT * FROM pxtest1;
PREPARE TRANSACTION 'foo4';

SELECT gid FROM pg_prepared_xacts;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM pxtest1;

INSERT INTO pxtest1 VALUES ('fff');
PREPARE TRANSACTION 'foo5';

SELECT gid FROM pg_prepared_xacts;

ROLLBACK PREPARED 'foo4';

SELECT gid FROM pg_prepared_xacts;

DROP TABLE pxtest1;

BEGIN;
SELECT pg_advisory_lock(1);
SELECT pg_advisory_xact_lock_shared(1);
PREPARE TRANSACTION 'foo6';  

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  CREATE TABLE pxtest2 (a int);
  INSERT INTO pxtest2 VALUES (1);
  SAVEPOINT a;
    INSERT INTO pxtest2 VALUES (2);
  ROLLBACK TO a;
  SAVEPOINT b;
  INSERT INTO pxtest2 VALUES (3);
PREPARE TRANSACTION 'regress-one';

CREATE TABLE pxtest3(fff int);

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
  DROP TABLE pxtest3;
  CREATE TABLE pxtest4 (a int);
  INSERT INTO pxtest4 VALUES (1);
  INSERT INTO pxtest4 VALUES (2);
  DECLARE foo CURSOR FOR SELECT * FROM pxtest4;
  FETCH 1 FROM foo;
PREPARE TRANSACTION 'regress-two';

FETCH 1 FROM foo;

SELECT * FROM pxtest2;

SELECT gid FROM pg_prepared_xacts;

begin;
lock table pxtest3 in access share mode nowait;
rollback;


SELECT gid FROM pg_prepared_xacts;

begin;
lock table pxtest3 in access share mode nowait;
rollback;

COMMIT PREPARED 'regress-one';
SELECT * FROM pxtest2;

SELECT gid FROM pg_prepared_xacts;

COMMIT PREPARED 'regress-two';
SELECT * FROM pxtest3;

SELECT gid FROM pg_prepared_xacts;

DROP TABLE pxtest2;
DROP TABLE pxtest3;  
DROP TABLE pxtest4;
