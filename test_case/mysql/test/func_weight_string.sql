drop table if exists t1;

set names latin1;

--
-- If it's BLOB or BINARY or VARBINARY, then output = input.
--
select hex(weight_string(0x010203));

--
-- "AS CHAR ( int )" causes padding on the right. The pad
-- character is always space, that is, 0x20 or 0x0020.
-- The padding occurs before the conversion to a weight.
-- The value of "int" is the number of characters, not the number of bytes.
--
select hex(weight_string('aa' as char(3)));

--
-- The minimum value of 'int' is 1.
--
--error 1064
select hex(weight_string('a' as char(-1)));
select hex(weight_string('a' as char(0)));
select hex(weight_string('a' as char(1)));

--
-- If 'int' is smaller than the length of 'string',
-- truncation will occur with no warning.
--
select hex(weight_string('ab' as char(1)));

--
-- If "AS CHAR ( int )" is omitted, there is no padding and no truncation.
--
select hex(weight_string('ab'));

--
-- "AS BINARY ( int )" is like CHAR(int) but causes padding of 0x00
-- so one doesn't have to use "CAST(string AS BINARY(int))".
--
select hex(weight_string('aa' as binary(3)));
select hex(weight_string(cast('aa' as binary(3))));

--
-- If the result length is less than or equal to the
-- maximum possible length for the VARBINARY data type,
-- then the result data type is VARBINARY. Otherwise
-- the result data type is BLOB.
--
create table t1 charset latin1 select weight_string('test') as w;
drop table t1;
create table t1 charset latin1 select weight_string(repeat('t',66000)) as w;
drop table t1;

--
-- If input is NULL, then output is NULL.
--
select weight_string(NULL);

--    
-- WEIGHT_STRING and REVERSE will not be a new reserved word.
--
select 1 as weight_string, 2 as reverse;

--
-- Check that collation derivation is copied from the argument
--
select coercibility(weight_string('test'));
select coercibility(weight_string('test' collate latin1_swedish_ci));

--
-- Bug#33663 Character sets: weight_string function,
-- varchar column, wrong result
--
create table t1 (s1 varchar(5)) charset latin1;
insert into t1 values ('a'),(null);
select hex(weight_string(s1)) from t1 order by s1;
drop table t1;
SET GLOBAL max_allowed_packet=1024;

SELECT HEX(WEIGHT_STRING('ab' AS CHAR(1000000)));
SELECT HEX(WEIGHT_STRING('ab' AS BINARY(1000000)));

SET GLOBAL max_allowed_packet=default;
SET NAMES utf8mb3;
SET collation_connection=utf16_unicode_ci;
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET latin2 COLLATE latin2_czech_cs);
INSERT INTO t1 VALUES ('abcd');
INSERT INTO t1 VALUES ('dcba');
CREATE VIEW v1 AS SELECT WEIGHT_STRING(_latin1 'ab') AS b;
CREATE VIEW v5 AS SELECT WEIGHT_STRING(a AS BINARY(2)) AS b FROM t1;
CREATE VIEW v6 AS SELECT WEIGHT_STRING(a AS BINARY(6)) AS b FROM t1;
DROP VIEW v1;
DROP VIEW v5;
DROP VIEW v6;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10)) charset latin1;
INSERT INTO t1 VALUES ('abcd');
INSERT INTO t1 VALUES ('dcba');
CREATE VIEW v1 AS SELECT WEIGHT_STRING(_latin1 'ab') AS b;
CREATE VIEW v2 AS SELECT WEIGHT_STRING(a) AS b FROM t1;
CREATE VIEW v3 AS SELECT WEIGHT_STRING(a AS CHAR(2)) AS b FROM t1;
CREATE VIEW v4 AS SELECT WEIGHT_STRING(a AS CHAR(6)) AS b FROM t1;
CREATE VIEW v5 AS SELECT WEIGHT_STRING(a AS BINARY(2)) AS b FROM t1;
CREATE VIEW v6 AS SELECT WEIGHT_STRING(a AS BINARY(6)) AS b FROM t1;
SELECT HEX(b) FROM v1;
SELECT HEX(WEIGHT_STRING(_latin1 'ab'));
SELECT HEX(b) FROM v2;
SELECT HEX(b) FROM v3;
SELECT HEX(b) FROM v4;
SELECT HEX(b) FROM v5;
SELECT HEX(WEIGHT_STRING(a AS BINARY(2))) FROM t1;
SELECT HEX(b) FROM v6;
SELECT HEX(WEIGHT_STRING(a AS BINARY(6))) FROM t1;
DROP VIEW v1;
DROP VIEW v2;
DROP VIEW v3;
DROP VIEW v4;
DROP VIEW v5;
DROP VIEW v6;
DROP TABLE t1;
SELECT HEX(WEIGHT_STRING(JSON_UNQUOTE(JSON_SET('{}','$',''))));

CREATE TABLE t1 ( ch VARCHAR(1) COLLATE latin2_czech_cs );
INSERT INTO t1 VALUES (0x4F);
SELECT DISTINCT HEX(WEIGHT_STRING(ch)) FROM t1;
DROP TABLE t1;

-- Other tests in this file use latin1
SET NAMES DEFAULT;

SET NAMES latin1;
