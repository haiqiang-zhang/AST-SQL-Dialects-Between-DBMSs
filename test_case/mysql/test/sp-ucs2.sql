
--
-- BUG#17615: problem with character set
--
--disable_warnings
drop function if exists bug17615|
--enable_warnings

create table t3 (a varchar(256) unicode)|

create function bug17615() returns varchar(256) unicode
begin
  declare tmp_res varchar(256) unicode;
  set tmp_res= 'foo string';

insert into t3 values(bug17615())|
select * from t3|

drop function bug17615|
drop table t3|


--
-- Testing COLLATE clause in
-- - IN parameter
-- - RETURNS
-- - DELCARE
--

CREATE FUNCTION f(f1 VARCHAR(64) CHARACTER SET ucs2 COLLATE ucs2_unicode_ci)
  RETURNS VARCHAR(64) CHARACTER SET ucs2 COLLATE ucs2_danish_ci
BEGIN
  DECLARE f2 VARCHAR(64) CHARACTER SET ucs2 COLLATE ucs2_swedish_ci;
  SET f1= concat(collation(f1), ' ', collation(f2), ' ', collation(f3));
SELECT f('a')|
SELECT collation(f('a'))|
DROP FUNCTION f|

--
-- Testing keywords UNICODE + BINARY
--
CREATE FUNCTION f()
  RETURNS VARCHAR(64) UNICODE BINARY
BEGIN
  RETURN '';
DROP FUNCTION f;

CREATE FUNCTION f()
  RETURNS VARCHAR(64) BINARY UNICODE
BEGIN
  RETURN '';
DROP FUNCTION f;


--
-- Testing keywords ASCII + BINARY
--
CREATE FUNCTION f()
  RETURNS VARCHAR(64) ASCII BINARY
BEGIN
  RETURN '';
DROP FUNCTION f;

CREATE FUNCTION f()
  RETURNS VARCHAR(64) BINARY ASCII
BEGIN
  RETURN '';
DROP FUNCTION f;

--
-- Testing COLLATE in OUT parameter
--

CREATE PROCEDURE p1(IN  f1 VARCHAR(64) CHARACTER SET ucs2 COLLATE ucs2_czech_ci,
                    OUT f2 VARCHAR(64) CHARACTER SET ucs2 COLLATE ucs2_polish_ci)
BEGIN
  SET f2= f1;
  SET f2= concat(collation(f1), ' ', collation(f2));


CREATE FUNCTION f1()
  RETURNS VARCHAR(64) CHARACTER SET ucs2
BEGIN
  DECLARE f1 VARCHAR(64) CHARACTER SET ucs2;
  SET f1='str';


SELECT f1()|
DROP PROCEDURE p1|
DROP FUNCTION f1|


--
-- COLLATE with no CHARACTER SET in IN param
--
--error ER_NOT_SUPPORTED_YET
CREATE FUNCTION f(f1 VARCHAR(64) COLLATE ucs2_unicode_ci)
  RETURNS VARCHAR(64) CHARACTER SET ucs2
BEGIN
  RETURN 'str';


--
-- COLLATE with no CHARACTER SET in RETURNS
--
--error ER_NOT_SUPPORTED_YET
CREATE FUNCTION f(f1 VARCHAR(64) CHARACTER SET ucs2)
  RETURNS VARCHAR(64) COLLATE ucs2_unicode_ci
BEGIN
  RETURN 'str';


--
-- COLLATE with no CHARACTER SET in DECLARE
--
--error ER_NOT_SUPPORTED_YET
CREATE FUNCTION f(f1 VARCHAR(64) CHARACTER SET ucs2)
  RETURNS VARCHAR(64) CHARACTER SET ucs2
BEGIN
  DECLARE f2 VARCHAR(64) COLLATE ucs2_unicode_ci;

--
-- Bug#48766 SHOW CREATE FUNCTION returns extra data in return clause
--
SET NAMES utf8mb3;
DROP FUNCTION IF EXISTS bug48766;
CREATE FUNCTION bug48766 ()
  RETURNS ENUM( 'w' ) CHARACTER SET ucs2
  RETURN 0;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_NAME='bug48766';
DROP FUNCTION bug48766;
CREATE FUNCTION bug48766 ()
  RETURNS ENUM('а','б','в','г') CHARACTER SET ucs2
  RETURN 0;
SELECT DTD_IDENTIFIER FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_NAME='bug48766';

DROP FUNCTION bug48766;
