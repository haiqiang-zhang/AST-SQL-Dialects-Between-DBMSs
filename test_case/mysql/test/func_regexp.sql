--

--disable_warnings
drop table if exists t1;

set names latin1;


--
-- This test a bug in regexp on Alpha
--

create table t1 (xxx char(128));
insert into t1 (xxx) values('this is a test of some long text to see what happens');
select * from t1 where xxx regexp('is a test of some long text to');
select * from t1 where xxx regexp('is a test of some long text to ');
select * from t1 where xxx regexp('is a test of some long text to s');
select * from t1 where xxx regexp('is a test of some long text to se');
drop table t1;

create table t1 (xxx char(128));
insert into t1 (xxx) values('this is some text: to test - out.reg exp (22/45)');
select * from t1 where xxx REGEXP '^this is some text: to test - out\\.reg exp [[(][0-9]+[/\\][0-9]+[])][ ]*$';
drop table t1;

--
-- Check with different character sets and collations
--
--echo -- The Henry Spencer library used prior to ICU was inonsistent
--echo -- here. When the regular expression search is performed in a
--echo -- case-insensitive manner, both '[[:lower:]]' and '[[:upper:]]'
--echo -- will match.
select _latin1 0xFF regexp _latin1 '[[:lower:]]' COLLATE latin1_bin;
select _koi8r  0xFF regexp _koi8r  '[[:lower:]]' COLLATE koi8r_bin;
select _latin1 0xFF regexp _latin1 '[[:upper:]]' COLLATE latin1_bin;
select _koi8r  0xFF regexp _koi8r  '[[:upper:]]' COLLATE koi8r_bin;

select _latin1 0xF7 regexp _latin1 '[[:alpha:]]';
select _koi8r  0xF7 regexp _koi8r  '[[:alpha:]]';

select _latin1'a' regexp _latin1'A' collate latin1_general_ci;
select _latin1'a' regexp _latin1'A' collate latin1_bin;

--
-- regexp cleanup()
--
create table t1 (a varchar(40));
insert into t1 values ('C1'),('C2'),('R1'),('C3'),('R2'),('R3');
set @a="^C.*";
set @a="^R.*";
drop table t1;


--
-- Bug #31440: 'select 1 regex null' asserts debug server
--

SELECT 1 REGEXP NULL;


--
-- Bug #39021: SELECT REGEXP BINARY NULL never returns
--

--error ER_CHARACTER_SET_MISMATCH
SELECT '' REGEXP BINARY NULL;
SELECT NULL REGEXP BINARY NULL;
SELECT 'A' REGEXP BINARY NULL;
SELECT "ABC" REGEXP BINARY NULL;


--
-- Bug #37337: Function returns different results
--
CREATE TABLE t1(a INT, b CHAR(4));
INSERT INTO t1 VALUES (1, '6.1'), (1, '7.0'), (1, '8.0');
DROP TABLE t1;

--
-- Bug #54805 definitions in regex/my_regex.h conflict with /usr/include/regex.h
--
-- This test verifies that '\t' is recognized as space, but not as blank.
-- This is *not* according to the POSIX standard, but seems to have been MySQL
-- behaviour ever since regular expressions were introduced.
-- See: Bug #55427 REGEXP does not recognize '\t' as [:blank:]
--
SELECT ' '  REGEXP '[[:blank:]]';
SELECT '\t' REGEXP '[[:blank:]]';

SELECT ' '  REGEXP '[[:space:]]';
SELECT '\t' REGEXP '[[:space:]]';
SELECT '1' RLIKE RPAD('1', 10000, '(');

SELECT REGEXP_INSTR(e, 'pattern')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);

SELECT REGEXP_LIKE(e, 'pattern')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);

SELECT REGEXP_REPLACE(e, 'pattern', 'xyz')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);

SELECT REGEXP_SUBSTR(e, 'pattern')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);

CREATE FUNCTION r_instr(input_text VARCHAR(255)) RETURNS INT DETERMINISTIC
    RETURN REGEXP_INSTR(input_text, 'pattern');
SELECT r_instr('Find pattern');
SELECT r_instr(NULL);
SELECT r_instr('Find pattern');
DROP FUNCTION r_instr;

CREATE FUNCTION r_like(input_text VARCHAR(255)) RETURNS BOOLEAN DETERMINISTIC
    RETURN REGEXP_LIKE(input_text, 'pattern');
SELECT r_like('Find pattern');
SELECT r_like(NULL);
SELECT r_like('Find pattern');
DROP FUNCTION r_like;

CREATE FUNCTION r_replace(input_text VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
    RETURN REGEXP_REPLACE(input_text, 'pattern', 'xyz');
SELECT r_replace('Find pattern');
SELECT r_replace(NULL);
SELECT r_replace('Find pattern');
DROP FUNCTION r_replace;

CREATE FUNCTION r_substr(input_text VARCHAR(255))
RETURNS VARCHAR(255) DETERMINISTIC
    RETURN REGEXP_SUBSTR(input_text, 'pattern');
SELECT r_substr('Find pattern');
SELECT r_substr(NULL);
SELECT r_substr('Find pattern');
DROP FUNCTION r_substr;
