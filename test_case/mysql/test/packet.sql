
-- Windows fails because it disconnects on too-large packets instead of just
-- swallowing them and returning an error
--source include/not_windows.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc
-- Test need MyISAM storage engine
--source include/have_myisam.inc

--
-- Check protocol handling
--

set @max_allowed_packet=@@global.max_allowed_packet;
set @net_buffer_length=@@global.net_buffer_length;


-- setting values below minimum threshold of 1024 will cause truncating
set global max_allowed_packet=100;
set global net_buffer_length=100;

-- is not yet in effect
SELECT length("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") as len;
select repeat('a',2000);

--
-- Connection 1 should get error for too big packets
--
connect (con1,localhost,root,,);
select @@net_buffer_length, @@max_allowed_packet;
SELECT length("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") as len;

--
-- Reset to default values and reconnect
--
set global max_allowed_packet=default;
set global net_buffer_length=default;
SELECT length("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa") as len;
select length(repeat('a',2000));

set global max_allowed_packet=@max_allowed_packet;
set global net_buffer_length=@net_buffer_length;

-- End of 4.1 tests

--echo --
--echo -- Bug #20376498: MAX_ALLOWED_PACKET ERROR DESTROYS
--echo --                ORIGINAL DATA


CREATE TABLE t1 (c11 INT NOT NULL, c12 LONGTEXT,
                 PRIMARY KEY (c11)) charset latin1;
CREATE TABLE t2 (c21 INT NOT NULL, c22 LONGTEXT,
                 PRIMARY KEY (c21)) charset latin1;
INSERT INTO t1 VALUES(100,'abcd');
INSERT INTO t2 VALUES(100,'xyz');
UPDATE t1
SET c12= REPEAT('ab', @max_allowed_packet);

UPDATE IGNORE t1
SET c12= REPEAT('ab', @max_allowed_packet);
UPDATE t1, t2
SET c12= REPEAT('ab', @max_allowed_packet),
    c22= 'ab';

UPDATE IGNORE t1, t2
SET c12= REPEAT('ab', @max_allowed_packet),
    c22= 'ab';
INSERT INTO t1
VALUES (101, REPEAT('ab', @max_allowed_packet));
INSERT INTO t1
SELECT 101, REPEAT('ab', @max_allowed_packet);

INSERT IGNORE INTO t1
SELECT 101, REPEAT('ab', @max_allowed_packet);
SET c11= 102,
    c12= REPEAT('ab', @max_allowed_packet);
SELECT 102, REPEAT('ab', @max_allowed_packet);

set names latin1;
DELETE FROM t1
WHERE c12 <=> REPEAT('ab', @max_allowed_packet);
DELETE FROM t1, t2
USING t1 INNER JOIN t2
WHERE t1.c11 = t2.c21 AND
      t2.c22 <=> REPEAT('ab', @max_allowed_packet);
set names utf8mb4;

DELETE IGNORE FROM t1, t2
USING t1 INNER JOIN t2
WHERE t1.c11 = t2.c21 AND
      t2.c22 <=> REPEAT('ab', @max_allowed_packet);

DELETE FROM t1;
DELETE FROM t2;
INSERT INTO t1 VALUES(100,'abcd');
INSERT INTO t2 VALUES(100,'xyz');

SET @@sql_mode= '';
SELECT @@sql_mode;

UPDATE t1
SET c12= REPEAT('ab', @max_allowed_packet);

SELECT c11, LENGTH(c12) FROM t1;

INSERT INTO t1
VALUES (101, REPEAT('ab', @max_allowed_packet));

SELECT c11, LENGTH(c12) FROM t1;

INSERT INTO t1
SELECT 102, REPEAT('ab', @max_allowed_packet);

SELECT c11, LENGTH(c12) FROM t1;

DELETE FROM t1
WHERE c12 <=> REPEAT('ab', @max_allowed_packet);

SELECT c11, LENGTH(c12) FROM t1;

SET @@sql_mode= default;
DROP TABLE t1, t2;