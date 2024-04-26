--   - stored procedures/functions;
--   - triggers;
--   - events;
--   - views;
--   - create a database with collation utf8_unicode_ci;
--   - create an object, which
--     - contains SP-var with explicit CHARSET-clause;
--     - contains SP-var without CHARSET-clause;
--     - contains text constant;
--     - has localized routine/parameter names;
--   - check:
--     - execute;
--     - SHOW CREATE output;
--     - SHOW output;
--     - SELECT FROM INFORMATION_SCHEMA output;
--   - alter database character set;
--   - change connection collation;
--   - check again;
--   - dump definition using mysqldump;
--   - drop object;
--   - restore object;
-- 

--##########################################################################
--
-- NOTE: this file contains text in utf8mb3 and KOI8-R encodings.
--
--##########################################################################

--##########################################################################

set names koi8r;

--
-- Preparation:
--

--   - Create database with fixed, pre-defined character set.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1|
--enable_warnings

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|

use mysqltest1|

CREATE TABLE t1(кол INT)|
INSERT INTO t1 VALUES(1)|

--   - Create views;

CREATE VIEW v1 AS
  SELECT 'тест' AS c1, кол AS c2
  FROM t1|

--echo

CREATE VIEW v2 AS SELECT _utf8mb3'я┌п╣я│я┌' as c1|

--echo

CREATE VIEW v3 AS SELECT _utf8mb3'я┌п╣я│я┌'|

--echo

--
-- First-round checks.
--

--source include/ddl_i18n.check_views.inc

--
-- Change running environment (alter database character set, change session
-- variables).
--

--echo
--echo

ALTER DATABASE mysqltest1 COLLATE cp866_general_ci|

--
-- Second-round checks:
--

--   - Change connection to flush cache;

--   - Switch environment variables and trigger loading views;

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

--disable_result_log
SELECT * FROM mysqltest1.v1|
SELECT * FROM mysqltest1.v2|
SELECT * FROM mysqltest1.v3|
--enable_result_log

use mysqltest1|

--   - Restore environment;

set names koi8r|

--   - Check!

--source include/ddl_i18n.check_views.inc

--
-- Check mysqldump.
--

--  - Dump mysqltest1;

--   - Clean mysqltest1;

DROP DATABASE mysqltest1|

--   - Restore mysqltest1;

--
-- Third-round checks.
--

--   - Change connection to flush cache;

--   - Switch environment variables and trigger loading views;

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

--disable_result_log
SELECT * FROM mysqltest1.v1|
SELECT * FROM mysqltest1.v2|
SELECT * FROM mysqltest1.v3|
--enable_result_log

use mysqltest1|

--   - Restore environment;

set names koi8r|

--   - Check!

--source include/ddl_i18n.check_views.inc

--
-- Cleanup.
--

--connection default
--echo
--echo ---> connection: default

--disconnect con2
--disconnect con3

use test|

DROP DATABASE mysqltest1|

--##########################################################################
--
-- * Stored procedures/functions.
--
--##########################################################################

--echo
--echo -------------------------------------------------------------------
--echo Stored procedures/functions
--echo -------------------------------------------------------------------
--echo

--
-- Preparation:
--

--   - Create database with fixed, pre-defined character set.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1|
DROP DATABASE IF EXISTS mysqltest2|
--enable_warnings

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|
CREATE DATABASE mysqltest2 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|

use mysqltest1|

--   - Create two stored routines -- with and without explicit
--     CHARSET-clause for SP-variable;
--

--echo

--     - Procedure p1

CREATE PROCEDURE p1(
  INOUT парам1 CHAR(10),
  OUT парам2 CHAR(10))
BEGIN
  DECLARE перем1 CHAR(10);

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION(парам1) AS c2,
    COLLATION(парам2) AS c3;

  SELECT
    COLLATION('текст') AS c4,
    COLLATION(_koi8r    'текст') AS c5,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c6,
    @@collation_connection AS c7,
    @@character_set_client AS c8;

  SET парам1 = 'a';
  SET парам2 = 'b';

--     - Procedure p2

CREATE PROCEDURE p2(
  INOUT парам1 CHAR(10) CHARACTER SET utf8mb3,
  OUT парам2 CHAR(10) CHARACTER SET utf8mb3)
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION(парам1) AS c2,
    COLLATION(парам2) AS c3;

  SELECT
    COLLATION('текст') AS c4,
    COLLATION(_koi8r    'текст') AS c5,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c6,
    @@collation_connection AS c7,
    @@character_set_client AS c8;

  SET парам1 = 'a';
  SET парам2 = 'b';

--     - Procedure p3

CREATE PROCEDURE mysqltest2.p3(
  INOUT парам1 CHAR(10),
  OUT парам2 CHAR(10))
BEGIN
  DECLARE перем1 CHAR(10);

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION(парам1) AS c2,
    COLLATION(парам2) AS c3;

  SELECT
    COLLATION('текст') AS c4,
    COLLATION(_koi8r    'текст') AS c5,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c6,
    @@collation_connection AS c7,
    @@character_set_client AS c8;

  SET парам1 = 'a';
  SET парам2 = 'b';

--     - Procedure p4

CREATE PROCEDURE mysqltest2.p4(
  INOUT парам1 CHAR(10) CHARACTER SET utf8mb3,
  OUT парам2 CHAR(10) CHARACTER SET utf8mb3)
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION(парам1) AS c2,
    COLLATION(парам2) AS c3;

  SELECT
    COLLATION('текст') AS c4,
    COLLATION(_koi8r    'текст') AS c5,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c6,
    @@collation_connection AS c7,
    @@character_set_client AS c8;

  SET парам1 = 'a';
  SET парам2 = 'b';

--
-- First-round checks.
--

--source include/ddl_i18n.check_sp.inc

--
-- Change running environment (alter database character set, change session
-- variables).
--

--echo
--echo

ALTER DATABASE mysqltest1 COLLATE cp866_general_ci|
ALTER DATABASE mysqltest2 COLLATE cp866_general_ci|

--
-- Second-round checks:
--

--   - Change connection to flush SP-cache;

--   - Switch environment variables and trigger loading stored procedures;

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

CALL p1(@a, @b)|
CALL p2(@a, @b)|
CALL mysqltest2.p3(@a, @b)|
CALL mysqltest2.p4(@a, @b)|

--   - Restore environment;

set names koi8r|

--   - Check!

--source include/ddl_i18n.check_sp.inc

--
-- Check mysqldump.
--

--  - Dump mysqltest1, mysqltest2;

--   - Clean mysqltest1, mysqltest2;

DROP DATABASE mysqltest1|
DROP DATABASE mysqltest2|

--   - Restore mysqltest1;

--
-- Third-round checks.
--

--   - Change connection to flush SP-cache;

--   - Switch environment variables and trigger loading stored procedures;

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

CALL p1(@a, @b)|
CALL p2(@a, @b)|
CALL mysqltest2.p3(@a, @b)|
CALL mysqltest2.p4(@a, @b)|

--   - Restore environment;

set names koi8r|

--   - Check!

--source include/ddl_i18n.check_sp.inc

--
-- Cleanup.
--

--connection default
--echo
--echo ---> connection: default

--disconnect con2
--disconnect con3

use test|

DROP DATABASE mysqltest1|
DROP DATABASE mysqltest2|

--##########################################################################
--
-- * Triggers.
--
--##########################################################################

--echo
--echo -------------------------------------------------------------------
--echo Triggers
--echo -------------------------------------------------------------------
--echo

--
-- Preparation:
--

--   - Create database with fixed, pre-defined character set;
DROP DATABASE IF EXISTS mysqltest1|
DROP DATABASE IF EXISTS mysqltest2|
--enable_warnings

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|
CREATE DATABASE mysqltest2 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|

use mysqltest1|

--   - Create tables for triggers;

CREATE TABLE t1(c INT)|
CREATE TABLE mysqltest2.t1(c INT)|

--   - Create log tables;

CREATE TABLE log(msg VARCHAR(255))|
CREATE TABLE mysqltest2.log(msg VARCHAR(255))|


--   - Create triggers -- with and without explicit CHARSET-clause for
--     SP-variable;
--

--echo

--     - Trigger trg1

CREATE TRIGGER trg1 BEFORE INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE перем1 CHAR(10);

  INSERT INTO log VALUES(COLLATION(перем1));
  INSERT INTO log VALUES(COLLATION('текст'));
  INSERT INTO log VALUES(COLLATION(_koi8r    'текст'));
  INSERT INTO log VALUES(COLLATION(_utf8mb3 'я┌п╣п╨я│я┌'));
  INSERT INTO log VALUES(@@collation_connection);
  INSERT INTO log VALUES(@@character_set_client);

  SET @a1 = 'текст';
  SET @a1 = _koi8r    'текст';
  SET @a2 = _utf8mb3 'я┌п╣п╨я│я┌';

--     - Trigger trg2

CREATE TRIGGER trg2 AFTER INSERT ON t1 FOR EACH ROW
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  INSERT INTO log VALUES(COLLATION(перем1));
  INSERT INTO log VALUES(COLLATION('текст'));
  INSERT INTO log VALUES(COLLATION(_koi8r    'текст'));
  INSERT INTO log VALUES(COLLATION(_utf8mb3 'я┌п╣п╨я│я┌'));
  INSERT INTO log VALUES(@@collation_connection);
  INSERT INTO log VALUES(@@character_set_client);

  SET @b1 = 'текст';
  SET @b1 = _koi8r    'текст';
  SET @b2 = _utf8mb3 'я┌п╣п╨я│я┌';

--     - Trigger trg3

CREATE TRIGGER mysqltest2.trg3 BEFORE INSERT ON mysqltest2.t1 FOR EACH ROW
BEGIN
  DECLARE перем1 CHAR(10);

  INSERT INTO log VALUES(COLLATION(перем1));
  INSERT INTO log VALUES(COLLATION('текст'));
  INSERT INTO log VALUES(COLLATION(_koi8r    'текст'));
  INSERT INTO log VALUES(COLLATION(_utf8mb3 'я┌п╣п╨я│я┌'));
  INSERT INTO log VALUES(@@collation_connection);
  INSERT INTO log VALUES(@@character_set_client);

  SET @a1 = 'текст';
  SET @a1 = _koi8r    'текст';
  SET @a2 = _utf8mb3 'я┌п╣п╨я│я┌';

--     - Trigger trg4

CREATE TRIGGER mysqltest2.trg4 AFTER INSERT ON mysqltest2.t1 FOR EACH ROW
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  INSERT INTO log VALUES(COLLATION(перем1));
  INSERT INTO log VALUES(COLLATION('текст'));
  INSERT INTO log VALUES(COLLATION(_koi8r    'текст'));
  INSERT INTO log VALUES(COLLATION(_utf8mb3 'я┌п╣п╨я│я┌'));
  INSERT INTO log VALUES(@@collation_connection);
  INSERT INTO log VALUES(@@character_set_client);

  SET @b1 = 'текст';
  SET @b1 = _koi8r    'текст';
  SET @b2 = _utf8mb3 'я┌п╣п╨я│я┌';

--
-- First-round checks.
--

--source include/ddl_i18n.check_triggers.inc

--
-- Change running environment (alter database character set, change session
-- variables).
--

--echo
--echo

ALTER DATABASE mysqltest1 COLLATE cp866_general_ci|
ALTER DATABASE mysqltest2 COLLATE cp866_general_ci|

--
-- Second-round checks:
--

--  - Flush table cache;

ALTER TABLE t1 ADD COLUMN fake INT|
ALTER TABLE t1 DROP COLUMN fake|

ALTER TABLE mysqltest2.t1 ADD COLUMN fake INT|
ALTER TABLE mysqltest2.t1 DROP COLUMN fake|

--   - Switch environment variables and initiate loading of triggers
--     (connect using NULL database);

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

INSERT INTO mysqltest1.t1 VALUES(0)|
INSERT INTO mysqltest2.t1 VALUES(0)|

DELETE FROM mysqltest1.log|
DELETE FROM mysqltest2.log|

--   - Restore environment;

set names koi8r|

use mysqltest1|

--   - Check!

--source include/ddl_i18n.check_triggers.inc

--
-- Check mysqldump.
--

--  - Dump mysqltest1, mysqltest2;

--   - Clean mysqltest1, mysqltest2;

DROP DATABASE mysqltest1|
DROP DATABASE mysqltest2|

--   - Restore mysqltest1;

--
-- Third-round checks.
--

--   - Flush table cache;

ALTER TABLE mysqltest1.t1 ADD COLUMN fake INT|
ALTER TABLE mysqltest1.t1 DROP COLUMN fake|

ALTER TABLE mysqltest2.t1 ADD COLUMN fake INT|
ALTER TABLE mysqltest2.t1 DROP COLUMN fake|

--   - Switch environment variables and initiate loading of triggers
--     (connect using NULL database);

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

INSERT INTO mysqltest1.t1 VALUES(0)|
INSERT INTO mysqltest2.t1 VALUES(0)|

DELETE FROM mysqltest1.log|
DELETE FROM mysqltest2.log|

--   - Restore environment;

set names koi8r|

use mysqltest1|

--   - Check!

--source include/ddl_i18n.check_triggers.inc

--
-- Cleanup.
--

--connection default
--echo
--echo ---> connection: default

--disconnect con2
--disconnect con3

use test|

DROP DATABASE mysqltest1|
DROP DATABASE mysqltest2|

--##########################################################################
--
-- * Events
--
-- We don't have EXECUTE EVENT so far, so this test is limited. It checks that
-- event with non-latin1 symbols can be created, dumped, restored and SHOW
-- statements work properly.
--
--##########################################################################

--echo
--echo -------------------------------------------------------------------
--echo Events
--echo -------------------------------------------------------------------
--echo

--
-- Preparation:
--

--   - Create database with fixed, pre-defined character set.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1|
DROP DATABASE IF EXISTS mysqltest2|
--enable_warnings

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|
CREATE DATABASE mysqltest2 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|

use mysqltest1|

--   - Create two stored routines -- with and without explicit
--     CHARSET-clause for SP-variable;
--

--echo

--     - Event ev1

CREATE EVENT ev1 ON SCHEDULE AT '2030-01-01 00:00:00' DO
BEGIN
  DECLARE перем1 CHAR(10);

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION('текст') AS c2,
    COLLATION(_koi8r    'текст') AS c3,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c4,
    @@collation_connection AS c5,
    @@character_set_client AS c6;

--     - Event ev2

CREATE EVENT ev2 ON SCHEDULE AT '2030-01-01 00:00:00' DO
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION('текст') AS c2,
    COLLATION(_koi8r    'текст') AS c3,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c4,
    @@collation_connection AS c5,
    @@character_set_client AS c6;

--     - Event ev3

CREATE EVENT mysqltest2.ev3 ON SCHEDULE AT '2030-01-01 00:00:00' DO
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION('текст') AS c2,
    COLLATION(_koi8r    'текст') AS c3,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c4,
    @@collation_connection AS c5,
    @@character_set_client AS c6;

--     - Event ev4

CREATE EVENT mysqltest2.ev4 ON SCHEDULE AT '2030-01-01 00:00:00' DO
BEGIN
  DECLARE перем1 CHAR(10) CHARACTER SET utf8mb3;

  SELECT
    COLLATION(перем1) AS c1,
    COLLATION('текст') AS c2,
    COLLATION(_koi8r    'текст') AS c3,
    COLLATION(_utf8mb3 'я┌п╣п╨я│я┌') AS c4,
    @@collation_connection AS c5,
    @@character_set_client AS c6;


--
-- First-round checks.
--

--source include/ddl_i18n.check_events.inc

--
-- Change running environment (alter database character set, change session
-- variables).
--

--echo
--echo

ALTER DATABASE mysqltest1 COLLATE cp866_general_ci|
ALTER DATABASE mysqltest2 COLLATE cp866_general_ci|

--
-- Second-round checks:
--

--   - Change connection to flush cache;

--   - Switch environment variables and trigger loading stored procedures;

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

--disable_result_log
SHOW CREATE EVENT ev1|
SHOW CREATE EVENT ev2|
SHOW CREATE EVENT mysqltest2.ev3|
SHOW CREATE EVENT mysqltest2.ev4|
--enable_result_log

--   - Restore environment;

set names koi8r|

--   - Check!

--source include/ddl_i18n.check_events.inc

--
-- Check mysqldump.
--

--  - Dump mysqltest1, mysqltest2;

--   - Clean mysqltest1, mysqltest2;

DROP DATABASE mysqltest1|
DROP DATABASE mysqltest2|

--   - Restore mysqltest1;

--
-- Third-round checks.
--

--   - Change connection to flush cache;

--   - Switch environment variables and trigger loading stored procedures;

SET @@character_set_client= cp1251|
SET @@character_set_results= cp1251|
SET @@collation_connection= cp1251_general_ci|

--disable_result_log
SHOW CREATE EVENT ev1|
SHOW CREATE EVENT ev2|
SHOW CREATE EVENT mysqltest2.ev3|
SHOW CREATE EVENT mysqltest2.ev4|
--enable_result_log

--   - Restore environment;

set names koi8r|

--   - Check!

--source include/ddl_i18n.check_events.inc

--##########################################################################
--
-- * DDL statements inside stored routine.
--
-- Here we check that DDL statements use actual database collation even if they
-- are called from stored routine.
--
--##########################################################################

--echo
--echo -------------------------------------------------------------------
--echo DDL statements within stored routine.
--echo -------------------------------------------------------------------
--echo

--
-- Preparation:
--

--   - Create database with fixed, pre-defined character set.

--disable_warnings
DROP DATABASE IF EXISTS mysqltest1|
DROP DATABASE IF EXISTS mysqltest2|
--enable_warnings

CREATE DATABASE mysqltest1 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|
CREATE DATABASE mysqltest2 DEFAULT CHARACTER SET utf8mb3 DEFAULT COLLATE utf8mb3_unicode_ci|

use mysqltest1|

--   - Create procedures;

CREATE PROCEDURE p1()
BEGIN
  CREATE TABLE t1(col1 VARCHAR(10));

CREATE PROCEDURE mysqltest2.p2()
BEGIN
  CREATE TABLE t2(col1 VARCHAR(10));

--
-- First-round checks.
--

CALL p1()|

--echo

SHOW CREATE TABLE t1|

--echo
--echo

CALL mysqltest2.p2()|

--echo

SHOW CREATE TABLE mysqltest2.t2|

--
-- Alter database.
--

--echo

ALTER DATABASE mysqltest1 COLLATE cp1251_general_cs|
ALTER DATABASE mysqltest2 COLLATE cp1251_general_cs|

DROP TABLE t1|
DROP TABLE mysqltest2.t2|

--echo

--
-- Second-round checks.
--

CALL p1()|

--echo

SHOW CREATE TABLE t1|

--echo
--echo

CALL mysqltest2.p2()|

--echo

SHOW CREATE TABLE mysqltest2.t2|

--##########################################################################
--
-- That's it.
--
--##########################################################################

--
-- Cleanup.
--
delimiter ;
USE test;
DROP DATABASE mysqltest1;
DROP DATABASE mysqltest2;
