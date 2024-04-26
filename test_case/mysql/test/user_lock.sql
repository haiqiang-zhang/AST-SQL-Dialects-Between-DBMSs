SELECT IS_USED_LOCK('test') IS NULL AS expect_1;
SELECT IS_FREE_LOCK('test') = 1 AS expect_1;
SELECT RELEASE_LOCK('test') IS NULL AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 0 AS expect_1;
SELECT GET_LOCK('test', 0) = 1 AS expect_1;
SELECT IS_USED_LOCK('test') = CONNECTION_ID() AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;

let $default_id= `SELECT CONNECTION_ID()`;


let $con1_id= `SELECT CONNECTION_ID()`;
SELECT IS_USED_LOCK('test') = @aux AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT GET_LOCK('test', 0) = 0 expect_1;
SELECT RELEASE_LOCK('test') = 0 AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 0 AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT RELEASE_LOCK('test') IS NULL;
SELECT GET_LOCK('test1',0);
SELECT GET_LOCK('test2',0);
SELECT IS_USED_LOCK('test1') = CONNECTION_ID()
   AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_LOCK('test1') = 1 AS expect_1;
SELECT IS_FREE_LOCK('test1') = 1 AS expect_1;
SELECT IS_FREE_LOCK('test2') = 0 AS expect_1;
SELECT RELEASE_LOCK('test2') = 1 AS expect_1;
SELECT GET_LOCK('test1',0);
SELECT GET_LOCK('test2',0);
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_FREE_LOCK('test1') AND IS_FREE_LOCK('test2') AS expect_1;
SELECT GET_LOCK('test1',0), GET_LOCK('test2',0);
SELECT IS_USED_LOCK('test1') = CONNECTION_ID()
   AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_USED_LOCK('test1') IS NULL AND IS_USED_LOCK('test2') IS NULL AS expect_1;
SELECT GET_LOCK('test1',0) FROM (SELECT 1 AS col1) AS my_tab
WHERE GET_LOCK('test2',0) = 1;
SELECT IS_USED_LOCK('test1') = CONNECTION_ID()
   AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_USED_LOCK('test1') IS NULL AND IS_USED_LOCK('test2') IS NULL AS expect_1;
SELECT GET_LOCK(col1,0) FROM (SELECT 'test1' AS col1 UNION SELECT 'test2') AS my_tab;
SELECT IS_USED_LOCK('test1') = CONNECTION_ID()
   AND IS_USED_LOCK('test2') = CONNECTION_ID() AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT IS_USED_LOCK('test1') IS NULL AND IS_USED_LOCK('test2') IS NULL AS expect_1;
SELECT GET_LOCK('test', 0);
SELECT GET_LOCK('test', 0);
SELECT GET_LOCK('test', 0);
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test') IS NULL AS expect_1;
SELECT GET_LOCK('test', 0), GET_LOCK('test', 0);
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT GET_LOCK('test', 0);
let $stmt= SELECT GET_LOCK('test', 7200);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state='User lock';
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT IS_USED_LOCK('test') <> CONNECTION_ID() AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
let $stmt= SELECT GET_LOCK('test', 7200), SLEEP(10);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state='User sleep';
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT IS_USED_LOCK('test') = CONNECTION_ID() AS expect_1;
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT GET_LOCK('test1', 0);
SELECT GET_LOCK('test1', 0);
let $con1_id= `SELECT CONNECTION_ID()`;
SELECT IS_FREE_LOCK('test1') = 0 AS expect_1;
let $wait_condition= SELECT COUNT(*) = 0 FROM information_schema.processlist
                     WHERE id = $con1_id;
SELECT IS_FREE_LOCK('test1') = 1 AS expect_1;
SELECT GET_LOCK('test1', 0);
SELECT GET_LOCK('test2', 0);
let $stmt= SELECT GET_LOCK('test1', 7200);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state='User lock';
SELECT GET_LOCK('test2', 7200);

SELECT RELEASE_LOCK('test1');
SELECT RELEASE_LOCK('test2') + RELEASE_LOCK('test1') = 2 AS expect_1;
CREATE TABLE t1 (id INT);
SELECT GET_LOCK('test1', 0);
SELECT GET_LOCK('test2', 0);
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT GET_LOCK('test1', 0);
SELECT GET_LOCK('test2', 0);
SELECT (RELEASE_LOCK('test1') = 1) AND (RELEASE_LOCK('test3') IS NULL)
   AND (RELEASE_LOCK('test2') = 1) AS expect_1;
DELETE FROM t1;
INSERT INTO t1 SET id = 1;
SELECT GET_LOCK('test1', 0);
INSERT INTO t1 SET id = 2;
SELECT GET_LOCK('test2', 0);
SELECT RELEASE_ALL_LOCKS() = 2 AS expect_1;
SELECT id FROM t1 ORDER BY id;
DELETE FROM t1;

SELECT GET_LOCK('test', 0);
INSERT INTO t1 VALUES (1);
let $stmt= SELECT GET_LOCK('test', 7200);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state = 'User lock';
let $stmt1= RENAME TABLE t1 TO t2;
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'rename%' AND state = 'Waiting for table metadata lock';

SELECT RELEASE_LOCK('test');
SELECT COUNT(*) = 1 AS expect_1 FROM t1 WHERE id = 1;

SELECT GET_LOCK('test', 0);
let $stmt= SELECT GET_LOCK('test', 7200);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state = 'User lock';
SELECT COUNT(*) FROM t1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT RELEASE_LOCK('test');
DELETE FROM t1;
CREATE TRIGGER trig_t1_ins BEFORE INSERT ON t1 FOR EACH ROW
SET @aux = GET_LOCK(new.id,7200);
SELECT GET_LOCK(CAST(2 AS CHAR),0);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT RELEASE_LOCK(1) = 1 AS expect_1;
SELECT RELEASE_LOCK(2) = 1 AS expect_1;
SELECT RELEASE_LOCK(2) = 1 AS expect_1;
SELECT RELEASE_LOCK(3) = 1 AS expect_1;
SELECT RELEASE_ALL_LOCKS() = 0 AS expect_1;
SELECT COUNT(*) FROM t1;
DELETE FROM t1;
SELECT GET_LOCK(2,0);
let $stmt= INSERT INTO t1 VALUES(1),(2),(3);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'SET @aux%' AND state = 'User lock';

SELECT RELEASE_ALL_LOCKS();
SELECT COUNT(*) FROM t1;
SELECT RELEASE_ALL_LOCKS();
DELETE FROM t1;
DROP TRIGGER trig_t1_ins;
CREATE TRIGGER trig_t1_ins BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  SET @aux = GET_LOCK(2,1);
  IF @aux <> 1 THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'LOCK 2 not got. Abort.', MYSQL_ERRNO = 9999;
  END IF;
SELECT GET_LOCK(CAST(2 AS CHAR),0);
SELECT GET_LOCK(CAST(1 AS CHAR),0);
let $stmt= SELECT GET_LOCK(CAST(1 AS CHAR),7200);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state = 'User lock';
INSERT INTO t1 VALUES(1),(2),(3);
SELECT RELEASE_ALL_LOCKS();
SELECT COUNT(*) FROM t1;
SELECT RELEASE_ALL_LOCKS();
DELETE FROM t1;
SELECT GET_LOCK(CAST(2 AS CHAR),0);
INSERT INTO t1 VALUES(1),(2),(3);
SELECT @aux;
SELECT RELEASE_ALL_LOCKS();
SELECT COUNT(*) FROM t1;
SELECT RELEASE_ALL_LOCKS();
DROP TRIGGER trig_t1_ins;
CREATE TABLE t2 (col1 INT, col2 INT, PRIMARY KEY(col1));
DELETE FROM t1;
INSERT INTO t1 VALUES(1),(2),(1);
INSERT INTO t2 SELECT id, GET_LOCK(id,0) FROM t1;
SELECT RELEASE_ALL_LOCKS();
SELECT * FROM t2;
DELETE FROM t1;
DELETE FROM t2;
INSERT INTO t1 VALUES(1),(1),(2);
INSERT INTO t2 SELECT id, GET_LOCK(id,0) FROM t1;
SELECT RELEASE_ALL_LOCKS();
SELECT * FROM t2;

DROP TABLE t2;
SELECT GET_LOCK('test', 0) ORDER BY oscar;
SELECT RELEASE_ALL_LOCKS() = 0 AS expect_1;
DROP TABLE t1;
SELECT GET_LOCK('test', 0), RELEASE_LOCK('test');
SELECT IS_FREE_LOCK('test') = 1 AS expect_1;
SELECT GET_LOCK('test', 0), RELEASE_LOCK('test'), GET_LOCK('test', 0);
SELECT IS_FREE_LOCK('test') = 0 AS expect_1;
SELECT RELEASE_LOCK('test') = 1 AS expect_1;
SELECT GET_LOCK('test', 0), GET_LOCK('test1', 0), RELEASE_ALL_LOCKS(),
       GET_LOCK('test', 0);
SELECT RELEASE_ALL_LOCKS() = 1 AS expect_1;
CREATE TABLE t1 AS SELECT GET_LOCK('test', 0) AS g, RELEASE_LOCK('test') AS r,
RELEASE_ALL_LOCKS() AS ra, IS_USED_LOCK('test') AS isu,
                       IS_FREE_LOCK('test') AS isf;
DROP TABLE t1;
SELECT GET_LOCK(NULL, 0);
SELECT GET_LOCK("", 0);
SELECT RELEASE_LOCK(NULL);
SELECT RELEASE_LOCK("");
SELECT IS_USED_LOCK(NULL);
SELECT IS_USED_LOCK("");
SELECT IS_FREE_LOCK(NULL);
SELECT IS_FREE_LOCK("");
SELECT GET_LOCK(REPEAT('a', 64), 0) = 1 AS expect_1;
SELECT IS_USED_LOCK(REPEAT('a', 64)) = CONNECTION_ID() AS expect_1;
SELECT IS_FREE_LOCK(REPEAT('a', 64)) = 0 AS expect_1;
SELECT RELEASE_LOCK(REPEAT('a', 64)) = 1 AS expect_1;
SELECT GET_LOCK(REPEAT('a', 65), 0);
SELECT IS_USED_LOCK(REPEAT('a', 65));
SELECT IS_FREE_LOCK(REPEAT('a', 65));
SELECT RELEASE_LOCK(REPEAT('a', 65));
SELECT GET_LOCK('A', 0);
SELECT GET_LOCK('a', 0);
SELECT IS_USED_LOCK('a') = CONNECTION_ID();
SELECT IS_FREE_LOCK('a');
SELECT RELEASE_LOCK('a');
SELECT GET_LOCK(_cp1251 0xf2e5f1f2, 0);
SELECT GET_LOCK(_utf8mb3 0xd182d0b5d181d182, 0);
SELECT IS_USED_LOCK(_koi8r 0xd4c5d3d4) = CONNECTION_ID();
SELECT IS_FREE_LOCK(_utf8mb3 0xd182d0b5d181d182);
SELECT RELEASE_LOCK(_utf8mb3 0xd182d0b5d181d182);
SELECT GET_LOCK('test');
SELECT GET_LOCK('test', 0, 1);
SELECT RELEASE_LOCK();
SELECT RELEASE_LOCK('test', 1);
SELECT RELEASE_ALL_LOCKS('test');
SELECT IS_USED_LOCK();
SELECT IS_USED_LOCK('test', 'test2');
SELECT IS_FREE_LOCK();
SELECT IS_FREE_LOCK('test', 'test2');
SELECT GET_LOCK("test", 0);
SELECT GET_LOCK("test", NULL) = 0 AS expect_1;
SELECT RELEASE_LOCK("test");
SELECT GET_LOCK('test', 0);
let $stmt= SELECT GET_LOCK('test', -1);
let $wait_condition= SELECT COUNT(*) > 0 FROM information_schema.processlist
                     WHERE info LIKE 'select%' AND state = 'User lock';
SELECT RELEASE_LOCK('test');
SELECT RELEASE_LOCK('test');


-- This sub test was in history placed in func_misc.test.
--
-- Bug#16501: IS_USED_LOCK does not appear to work
--

connection default;
CREATE TABLE t1 (conn CHAR(7), connection_id INT);
INSERT INTO t1 VALUES ('default', CONNECTION_ID());

SELECT GET_LOCK('bug16501',600);
INSERT INTO t1 VALUES ('con1', CONNECTION_ID());
SELECT IS_USED_LOCK('bug16501') = connection_id
FROM t1
WHERE conn = 'default';
let $stmt= SELECT GET_LOCK('bug16501',600);
SELECT IS_USED_LOCK('bug16501') = CONNECTION_ID();
SELECT RELEASE_LOCK('bug16501');
SELECT IS_USED_LOCK('bug16501') = connection_id
FROM t1
WHERE conn = 'con1';
SELECT IS_USED_LOCK('bug16501') = CONNECTION_ID();
SELECT RELEASE_LOCK('bug16501');
SELECT IS_USED_LOCK('bug16501');
SELECT RELEASE_ALL_LOCKS();
DROP TABLE t1;

SET @@session.div_precision_increment=0;
select * from(SELECT MIN(GET_LOCK(0,0) / 1 ^ 0)) as a;
select * from(SELECT MAX(RELEASE_LOCK(0) / 1 ^ 0)) as a;
select * from(SELECT MAX(RELEASE_ALL_LOCKS() / 1 ^ 0)) as a;
SET @@session.div_precision_increment=default;
SELECT GET_LOCK('1234567890123456789012345678901234567890123456789012345678901234',1);
SELECT GET_LOCK('12345678901234567890123456789012345678901234567890123456789012345',1);
SELECT GET_LOCK('',1);
SELECT GET_LOCK(NULL,1);
SET @a=0x414243FAFA;
SELECT GET_LOCK(@a,1);
SET @a=0x414243;
SELECT GET_LOCK(@a,1);
SELECT RELEASE_ALL_LOCKS();
