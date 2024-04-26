
--
-- Bug 9148: Denial of service
--
--error 1049
use lpt1;
use com1;
use prn;

--
-- Bug #12325: Can't create table named 'nu'
--
create table nu (a int);
drop table nu;

--
-- Bug #27811: The variable 'join_tab' is being used without being defined
--
CREATE TABLE t1 (a int, b int);
DROP TABLE t1;

--
-- Bug #33813: Schema names are case-sensitive in DROP FUNCTION
--

CREATE DATABASE `TESTDB`;

USE `TESTDB`;

CREATE FUNCTION test_fn() RETURNS INTEGER
BEGIN
DECLARE rId bigint;
END
//

CREATE FUNCTION test_fn2() RETURNS INTEGER
BEGIN
DECLARE rId bigint;
END
//

DELIMITER ;

DROP FUNCTION `TESTDB`.`test_fn`;
DROP FUNCTION `testdb`.`test_fn2`;

USE test;
DROP DATABASE `TESTDB`;
drop procedure if exists proc_1;
--

create procedure proc_1() install plugin my_plug soname '\\root\\some_plugin.dll';
drop procedure proc_1;
SELECT VARIABLE_NAME FROM performance_schema.global_variables
  WHERE VARIABLE_NAME = 'socket';
