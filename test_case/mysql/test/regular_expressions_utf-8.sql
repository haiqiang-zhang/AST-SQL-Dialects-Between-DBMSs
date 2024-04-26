
CREATE TABLE t1 (
  subject char(10),
  pattern char(10)
);
SELECT regexp_instr( 'abc', 'a' );
SELECT regexp_instr( 'abc', 'b' );
SELECT regexp_instr( 'abc', 'c' );
SELECT regexp_instr( 'abc', 'd' );
SELECT regexp_instr( NULL, 'a' );
SELECT regexp_instr( 'a', NULL );
SELECT regexp_instr( NULL, NULL );
SET NAMES binary;
SELECT hex( concat(regexp_instr( 'a', 'a' )) );
SET NAMES DEFAULT;
SELECT regexp_instr( 1, 'a' );
SELECT regexp_instr( 1.1, 'a' );
SELECT regexp_instr( 'a', 1 );
SELECT regexp_instr( 'a', 1.1 );

SELECT regexp_instr( subject, pattern ) FROM t1;
SELECT regexp_instr( 'a', '[[:invalid_bracket_expression:]]' );
SELECT regexp_instr( 'abcabcabc', 'a+', 1 );
SELECT regexp_instr( 'abcabcabc', 'a+', 2 );
SELECT regexp_instr( 'abcabcabc', 'b+', 1 );
SELECT regexp_instr( 'abcabcabc', 'b+', 2 );
SELECT regexp_instr( 'abcabcabc', 'b+', 3 );
SELECT regexp_instr( 'a', 'a+', 3 );
SELECT regexp_instr( 'abcabcabc', 'a+', 1, 2 );
SELECT regexp_instr( 'abcabcabc', 'a+', 1, 3 );
SELECT regexp_instr( 'abcabcabc', 'a+', 1, 4 );
SELECT regexp_instr( 'abcabcabc', 'a+', 4, 2 );
SELECT regexp_instr( 'a', 'a+', 1, 1, 2 );
SELECT regexp_instr( 'a', 'a+', 1, 1, -1 );
SELECT regexp_instr( 'a', 'a+', 1, 1, NULL );
SELECT regexp_instr( 'abcabcabc', 'a+', 1, 1, 0 );
SELECT regexp_instr( 'abcabcabc', 'a+', 1, 1, 1 );
SELECT regexp_instr( 'aaabcabcabc', 'a+', 1, 1, 1 );
SELECT regexp_instr( 'aaabcabcabc', 'A+', 1, 1, 1, 'c' );
SELECT regexp_instr( 'aaabcabcabc', 'A+', 1, 1, 1, 'i' );
SELECT regexp_instr( 'aaabcabcabc', 'A+', 1, 1, 1, 'ci' );
SELECT regexp_instr( 'aaabcabcabc', 'A+', 1, 1, 1, 'cic' );
SELECT regexp_instr( 'a', 'a+', 1, 1, 1, 'x' );
SELECT regexp_instr( 'a', 'a+', 1, 1, 1, NULL );
SELECT regexp_like( 'abc', 'a' );
SELECT regexp_like( 'abc', 'b' );
SELECT regexp_like( 'abc', 'c' );
SELECT regexp_like( 'abc', 'd' );
SELECT regexp_like( 'a', 'a.*' );
SELECT regexp_like( 'ab', 'a.*' );
SELECT regexp_like( NULL, 'a' );
SELECT regexp_like( 'a', NULL );
SELECT regexp_like( NULL, NULL );
SET NAMES binary;
SELECT hex( concat(regexp_like( 'a', 'a' )) );
SET NAMES DEFAULT;
SELECT regexp_like( 'abc', 'A', 'i' );
SELECT regexp_like( 'abc', 'A', 'c' );
SELECT regexp_like( 'a', 'a+', 'x' );
SELECT regexp_like( 'a', 'a+', 'cmnux' );
SELECT regexp_like( 'a', 'a+', NULL );
SELECT regexp_like( 1, 'a' );
SELECT regexp_like( 1.1, 'a' );
SELECT regexp_like( 'a', 1 );
SELECT regexp_like( 'a', 1.1 );
SELECT regexp_like('a', '[[:invalid_bracket_expression:]]');
SELECT regexp_replace( 'aaa', 'a', 'X' );
SELECT regexp_replace( 'abc', 'b', 'X' );
SELECT regexp_replace( NULL, 'a', 'X' );
SELECT regexp_replace( 'aaa', NULL, 'X' );
SELECT regexp_replace( 'aaa', 'a', NULL );
SELECT concat( regexp_replace( 'aaa', 'a', 'X' ), 'x' );
SELECT regexp_replace( 'aaa', 'a', 'X', 0 );
SELECT regexp_replace( 'aaa', 'a', 'X', 1 );
SELECT regexp_replace( 'a', 'a+', 'b', 3 );
SELECT regexp_replace( 'aaabbccbbddaa', 'b+', 'X', 0, 1 );
SELECT regexp_replace( 'aaabbccbbddaa', 'b+', 'X', 1, 1 );
SELECT regexp_replace( 'aaabbccbbddaa', 'b+', 'X', 1, 2 );
SELECT regexp_replace( 'aaabbccbbddaa', '(b+)', '<$1>', 1, 2 );
SELECT regexp_replace( 'aaabbccbbddaa', 'x+', 'x', 1, 0 );
SELECT regexp_replace( 'aaabbccbbddaa', 'b+', 'x', 1, 0 );
SELECT regexp_replace( 'aaab', 'b', 'x', 1, 2 );
SELECT regexp_replace( 'aaabccc', 'b', 'x', 1, 2 );

SELECT regexp_replace( 'abc', 'b', 'X' );
SELECT regexp_replace( 'abcbdb', 'b', 'X' );

SELECT regexp_replace( 'abcbdb', 'b', 'X', 3 );
SELECT regexp_replace( 'aaabcbdb', 'b', 'X', 1 );
SELECT regexp_replace( 'aaabcbdb', 'b', 'X', 2 );
SELECT regexp_replace( 'aaabcbdb', 'b', 'X', 3 );
SELECT regexp_replace( 'a', '[[:invalid_bracket_expression:]]', '$1' );
SELECT regexp_replace( 'aaa', 'a', 'X', 2 );
SELECT regexp_replace( 'aaa', 'a', 'XX', 2 );
SELECT regexp_substr( 'a' );
SELECT regexp_substr( 'a', 'b', 'c', 'd', 'e', 'f' );
SELECT regexp_substr( 'ab ac ad', '.d' );
SELECT regexp_substr( 'ab ac ad', '.D' );
SELECT concat( regexp_substr( 'aaa', 'a+' ), 'x' );
SELECT regexp_substr( 'ab ac ad', 'a.', 0 );
SELECT regexp_substr( 'ab ac ad', 'A.', 3 );
SELECT regexp_substr( 'ab ac ad', 'A.', 3, 1 );
SELECT regexp_substr( 'ab ac ad', 'A.', 3, 2 );
SELECT regexp_substr( 'ab ac ad', 'A.', 3, 3 );
SELECT regexp_substr( 'ab ac ad', 'A.', 3, 3 ) IS NULL;
SELECT regexp_substr( 'ab ac ad', 'A.', 1, 1, 'c' );
SELECT regexp_substr( 'ab\nac\nad', 'A.', 1, 1, 'i' );
SELECT regexp_substr( 'ab\nac\nad', 'A.', 1, 1, 'im' );
SELECT regexp_substr('a', '[[:invalid_bracket_expression:]]');

SET sql_mode = '';
CREATE TABLE t2 ( g GEOMETRY NOT NULL );
INSERT INTO t2 VALUES ( POINT(1,2) );
SELECT concat( regexp_like(g, g), 'x' ) FROM t2;
SET sql_mode = DEFAULT;
DROP TABLE t2;

DROP TABLE t1;
SELECT regexp_instr( '', '((((((((){80}){}){11}){11}){11}){80}){11}){4}' );

if (`SELECT icu_major_version() > 50`)
{

SET GLOBAL regexp_stack_limit = 239;
SELECT regexp_instr( '', '(((((((){120}){11}){11}){11}){80}){11}){4}' );

SET GLOBAL regexp_stack_limit = 32;
SELECT regexp_instr( '', '((((((){11}){11}){11}){160}){11}){160}' );
SELECT regexp_instr( '', '(((((){150}){11}){160}){11}){160}' );
SELECT regexp_instr( '', '((((){255}){255}){255}){255}' );

SET GLOBAL regexp_stack_limit = DEFAULT;

SET GLOBAL regexp_time_limit = 1000;
SELECT regexp_instr( 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC', '(A+)+B' );

SET GLOBAL regexp_time_limit = DEFAULT;

}

--enable_result_log
--enable_query_log

--echo -- ... to here. The reason is that we're testing the stack limit feature,
--echo -- which is not present (or working) in ICU 5.0 or earlier. We don't need
--echo -- the query or result/error log to test the feature, though. The above
--echo -- tests still fail unless the proper error is thrown.


--echo --
--echo -- Character set conversion.
--echo --

SET NAMES latin1;
SELECT regexp_instr( _latin1 x'61F662', _latin1 x'F6' );
SELECT regexp_instr( _latin1 x'61F662', _utf8mb4'ö' );
SELECT regexp_instr( concat('a', _utf8mb4 x'F09F8DA3'), _utf8mb4 x'F09F8DA3' );

SELECT regexp_instr( _utf8mb4'aöb', _utf8mb4'ö' );
SET NAMES utf8mb3;
SELECT regexp_instr( 'aöb', 'ö' );
SET NAMES DEFAULT;
SET NAMES utf8mb3;
SELECT regexp_instr( 'אב רק', /*k*/'^[^ב]' );

CREATE TABLE t1( a INT, subject CHAR(10) );
CREATE TABLE t2( pattern CHAR(10) );

insert into t1 values (0, 'apa');
insert into t2 values ('apa');

CREATE DEFINER=root@localhost PROCEDURE p1()
BEGIN
  UPDATE t1, t2
  SET a = 1
  WHERE regexp_like(t1.subject, t2.pattern);

DROP PROCEDURE p1;
DROP TABLE t1, t2;

CREATE TABLE t1 ( a INT );
DROP TABLE t1;

SET @subject = 'a';
SET @pattern = 'a+';
SET @subject = 1;
SET @pattern = 1;

CREATE TABLE t1 ( a CHAR(10) );
INSERT INTO t1 VALUES ( 'abc' ), ( 'bcd' ), ( 'cde' );

SELECT regexp_like( a, 'a' ) FROM t1;

DROP TABLE t1;

CREATE TABLE t1 ( a CHAR ( 10 ), b CHAR ( 10 ) );

INSERT INTO t1 VALUES( NULL, 'abc' );
INSERT INTO t1 VALUES( 'def', NULL );

SELECT a, b, regexp_like( a, b ) FROM t1;

DROP TABLE t1;
CREATE TABLE t1 (
  c CHAR(10) CHARSET latin1 COLLATE latin1_bin,
  c_ci CHAR(10) CHARSET latin1 COLLATE latin1_general_ci,
  c_cs CHAR(10) CHARSET latin1 COLLATE latin1_general_cs
);

INSERT INTO t1
VALUES ( 'a', 'a', 'a' ), ( 'A', 'A', 'A' ), ( 'b', 'b', 'b' );
SELECT c, c_ci REGEXP 'A', c_cs REGEXP 'A' FROM t1;

DROP TABLE t1;

SELECT regexp_like( _utf8mb4 'ss' COLLATE utf8mb4_german2_ci,
                    _utf8mb4 'ß'  COLLATE utf8mb4_german2_ci );

SELECT regexp_like( _utf8mb4 'ß'  COLLATE utf8mb4_german2_ci,
                    _utf8mb4 'ss' );

SELECT regexp_like( _utf8mb4 'ß'  COLLATE utf8mb4_de_pb_0900_as_cs,
                    _utf8mb4 'ss' );
SET NAMES latin1;
SELECT regexp_like( 'a', 'A' COLLATE latin1_general_ci );
SELECT 'a' REGEXP 'A' COLLATE latin1_general_ci;
SELECT regexp_like( 'a', 'A' COLLATE latin1_general_cs );
SELECT 'a' REGEXP 'A' COLLATE latin1_general_cs;
SELECT regexp_like( 'a\nb\nc', '^b$' );
SELECT regexp_like( 'a\nb\nc', '(?m)^b$' );
SELECT regexp_like( 'a\nb\nc', '.*' );

SELECT regexp_like( _utf16 'a' , 'a' );
SELECT regexp_like( _utf16le 'a' , 'a' );
SELECT regexp_like( 'aaa', 'a+', 1 );
SELECT regexp_substr( 'aaa', 'a+', 1, 1, 1 );
SELECT regexp_substr( 'aaa', 'a+', 1, 1, 1 );
SELECT regexp_substr( 'aaa', '+' );
CREATE TABLE t1 (
  a CHAR(3) CHARACTER SET utf16le,
  b CHAR(3) CHARACTER SET utf16le
);

INSERT INTO t1 VALUES ( NULL, 'abc' );
INSERT INTO t1 VALUES ( 'def', NULL );
INSERT INTO t1 VALUES ( NULL, NULL );

SELECT a regexp b FROM t1;

DROP TABLE t1;
CREATE TABLE t1
(
  a REAL,
  b INT,
  c CHAR(100),
  d DECIMAL
);

INSERT INTO t1 VALUES ( regexp_instr('a', 'a'),
                        regexp_instr('a', 'a'),
                        regexp_instr('a', 'a'),
                        regexp_instr('a', 'a') );
SELECT * FROM t1;
DELETE FROM t1;

INSERT INTO t1 VALUES ( regexp_like('a', 'a'),
                        regexp_like('a', 'a'),
                        regexp_like('a', 'a'),
                        regexp_like('a', 'a') );
SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1 ( a ) VALUES ( regexp_replace('a', 'a', 'a') );
INSERT INTO t1 ( b ) VALUES ( regexp_replace('a', 'a', 'a') );
INSERT INTO t1 ( c ) VALUES ( regexp_replace('a', 'a', 'a') );
INSERT INTO t1 ( d ) VALUES ( regexp_replace('a', 'a', 'a') );

SELECT * FROM t1;
DELETE FROM t1;
INSERT INTO t1 ( a ) VALUES ( regexp_substr('a', 'a') );
INSERT INTO t1 ( b ) VALUES ( regexp_substr('a', 'a') );
INSERT INTO t1 ( c ) VALUES ( regexp_substr('a', 'a') );
INSERT INTO t1 ( d ) VALUES ( regexp_substr('a', 'a') );
SELECT * FROM t1;

DROP TABLE t1;
SELECT cast( regexp_replace('a', 'a', 'a') AS SIGNED INTEGER );
SELECT cast( regexp_substr ('a', 'a')      AS SIGNED INTEGER );
SELECT cast( regexp_instr  ('a', 'a'     ) AS DATETIME );
SELECT cast( regexp_like   ('a', 'a'     ) AS DATETIME );
SELECT cast( regexp_replace('a', 'a', 'a') AS DATETIME );
SELECT cast( regexp_substr ('a', 'a'     ) AS DATETIME );

SELECT cast( regexp_instr  ('a', 'a'     ) AS TIME );
SELECT cast( regexp_like   ('a', 'a'     ) AS TIME );
SELECT cast( regexp_replace('a', 'a', 'a') AS TIME );
SELECT cast( regexp_substr ('a', 'a'     ) AS TIME );


SET GLOBAL net_buffer_length = 1024;
SET GLOBAL max_allowed_packet = @@global.net_buffer_length;
SELECT @@global.max_allowed_packet;
SET @buf_sz_utf16 = @@global.max_allowed_packet / length( _utf16'x' );
SELECT @buf_sz_utf16;
SELECT length(regexp_replace( repeat('a', @buf_sz_utf16), 'a', 'b' ));
SELECT length(regexp_replace( repeat('a', @buf_sz_utf16 + 1), 'a', 'b' ));
SELECT length(regexp_replace( repeat('a', @buf_sz_utf16), 'a', 'bb' ));

SET GLOBAL net_buffer_length = DEFAULT;
SET GLOBAL max_allowed_packet = DEFAULT;
SELECT regexp_like( 'a', '[[:<:]]a' );
SELECT regexp_like( 'a', '   **' );
SELECT regexp_like( 'a', ' \n  **' );
SELECT regexp_like( 'a', '  +++' );
SELECT regexp_like( 'a', '\\' );
SELECT regexp_like('a','(?{})');
SELECT regexp_like('a','(');
SELECT regexp_like('a','a{}');
SELECT regexp_like('a','a{2,1}');
SELECT regexp_like('a','\\1');
SELECT regexp_substr( 'ab','(?<=a+)b' );
SELECT regexp_like( 'a', 'a[' );
SELECT regexp_substr( 'ab','[b-a]' );
CREATE TABLE t1 ( a TEXT );
INSERT INTO t1 VALUES ( repeat( 'a', 16384 ) );
SELECT char_length ( regexp_replace( a, 'a', 'b' ) ) FROM t1;
SET GLOBAL  regexp_time_limit = 10000;
SELECT regexp_like ( regexp_replace( a, 'a', 'b' ), 'b{16384}' ) FROM t1;
SET GLOBAL  regexp_time_limit = DEFAULT;
DROP TABLE t1;
SET GLOBAL regexp_time_limit = 1000000;
let $conn1_id= `SELECT CONNECTION_ID()`;
SET GLOBAL regexp_time_limit = DEFAULT;

SELECT regexp_instr ( 'a', 'a', NULL );
SELECT regexp_instr ( 'a', 'a', 1, NULL );
SELECT regexp_instr ( 'a', 'a', 1, 0, NULL );
SELECT regexp_instr ( 'a', 'a', 1, 0, 0, NULL );

SELECT regexp_like ( 'a', 'a', NULL );

SELECT regexp_replace ( 'a', 'a', 'a', NULL );
SELECT regexp_replace ( 'a', 'a', 'a', 1, NULL );
SELECT regexp_replace ( 'a', 'a', 'a', 1, 0, NULL );

SELECT regexp_substr ( 'a', 'a', NULL );
SELECT regexp_substr ( 'a', 'a', 1, NULL );
SELECT regexp_substr ( 'a', 'a', 1, 0, NULL );

SELECT regexp_like( reverse(''), 123 );
SELECT regexp_like( soundex(@v1), 'abc' );
SELECT regexp_like( left('', ''), 'abc' );
SELECT regexp_like( repeat(@v1, 'abc'), 'abc' );
SELECT regexp_replace( 'abc' , 'abc', '$abc' );

SET @s := "SELECT regexp_like( '', '', ? / '' )";

CREATE TABLE t1 ( match_parameter CHAR(1) );
INSERT INTO t1 VALUES ( 'i' ), ( 'c' ), ( 'i' ), ( 'c' );
SELECT match_parameter, regexp_like ( 'a', 'A', match_parameter ) FROM t1;
DROP TABLE t1;
SELECT regexp_replace( ' F' , '^ ', '[,$' );
SELECT regexp_instr( 'abc', '(?-' );

select regexp_instr(char('313:50:35.199734'using utf16le),
                    cast(uuid() as char character set utf16le));

CREATE TABLE t1 ( a VARCHAR(10) );
INSERT INTO t1 VALUES ('a a a'), ('b b b'), ('c c c');
SELECT regexp_replace(a, '^([[:alpha:]]+)[[:space:]].*$', '$1') FROM t1;
DROP TABLE t1;

CREATE TABLE t1 ( a CHAR(3) );
INSERT INTO t1 VALUES ( regexp_replace ('a', 'a', 'x') );
SELECT * FROM t1;
UPDATE t1 SET a = regexp_replace ( 'b', 'b', 'y' );
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 ( a CHAR(3) );
INSERT INTO t1 VALUES ( regexp_substr ('a', 'a', 1) );
SELECT * FROM t1;
UPDATE t1 SET a = regexp_substr ('b', 'b', 1);
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 AS SELECT
  regexp_instr( 'a', 'a' ) AS a,
  regexp_like( 'a', 'a' ) AS b,
  regexp_replace( 'abc', 'b', 'x' ) AS c,
  regexp_substr( 'a', 'a' ) AS d,
  regexp_substr( repeat('a', 512), 'a' ) AS e,
  regexp_substr( repeat('a', 513), 'a' ) AS f;
SELECT * FROM t1;
DROP TABLE t1;
SET NAMES DEFAULT;

SELECT regexp_instr( '🍣🍣a', '🍣', 2 );
SELECT regexp_instr( '🍣🍣a', 'a', 3 );
SELECT regexp_instr( '🍣🍣a', 'a', 4 );

SELECT regexp_substr( 'a🍣b', '.', 1 );
SELECT regexp_substr( 'a🍣b', '.', 2 );
SELECT regexp_substr( 'a🍣b', '.', 3 );
SELECT regexp_substr( 'a🍣b', '.', 4 );

SELECT regexp_substr( 'a🍣🍣b', '.', 1 );
SELECT regexp_substr( 'a🍣🍣b', '.', 2 );
SELECT regexp_substr( 'a🍣🍣b', '.', 3 );
SELECT regexp_substr( 'a🍣🍣b', '.', 4 );
SELECT regexp_substr( 'a🍣🍣b', '.', 5 );

SELECT regexp_replace( '🍣🍣🍣', '.', 'a', 2 );
SELECT regexp_replace( '🍣🍣🍣', '.', 'a', 2, 2 );

SELECT hex(regexp_replace( convert( 'abcd' using utf8mb4 ), 'c', ''));
SELECT hex(regexp_replace( convert( 'abcd' using utf16 ), 'c', ''));
SELECT hex(regexp_substr( convert( 'abcd' using utf8mb4 ), 'abc'));
SELECT hex(regexp_substr( convert( 'abcd' using utf16 ), 'abc'));
CREATE TABLE t1 (
  a CHAR(10) CHARACTER SET utf16le,
  b CHAR(10) CHARACTER SET utf16
);

INSERT INTO t1 VALUES (
  regexp_substr( convert('abcd' using utf16le), 'abc' ),
  regexp_substr( convert('abcd' using utf16), 'abc' ));

INSERT INTO t1 VALUES (
  regexp_substr( 'abcd', 'abc' ),
  regexp_substr( 'abcd', 'abc' ));

SELECT * FROM t1;

DROP TABLE t1;
SELECT regexp_like('1', x'01');
SELECT regexp_like(x'01', '1');
SELECT regexp_replace('01', '01', x'02');
SELECT regexp_replace('01', x'01', '02');
SELECT regexp_replace('01', x'01', x'02');
SELECT regexp_replace(x'01', '01', '02');
SELECT regexp_replace(x'01', '01', x'02');
SELECT regexp_replace(x'01', x'01', '02');
CREATE TABLE t1(a CHAR(1));
CREATE TABLE t2(a BLOB);
CREATE TABLE t3(a TEXT);

INSERT INTO t1 VALUES('1');
INSERT INTO t2 VALUES('1');
INSERT INTO t3 VALUES('1');
SELECT regexp_like(a, x'01') FROM t1;
SELECT regexp_like(a, x'01') FROM t2;
SELECT regexp_like(a, x'01') FROM t3;
SELECT regexp_like(x'01', a) FROM t1;
SELECT regexp_like(x'01', a) FROM t2;
SELECT regexp_like(x'01', a) FROM t3;

DROP TABLE t1, t2, t3;
SELECT regexp_instr(1, 'a');
SELECT regexp_instr('a', 1);
SELECT regexp_instr(NULL, 'a');
SELECT regexp_instr('a', NULL);

SELECT regexp_like(1, 'a');
SELECT regexp_like('a', 1);
SELECT regexp_like(NULL, 'a');
SELECT regexp_like('a', NULL);

SELECT regexp_replace(1, 1, 'a');
SELECT regexp_replace(1, 'a', 1);
SELECT regexp_replace(1, 'a', 'a');
SELECT regexp_replace('a', 1, 1);
SELECT regexp_replace('a', 1, 'a');
SELECT regexp_replace('a', 'a', 1);

SELECT regexp_replace(NULL, NULL, 'a');
SELECT regexp_replace(NULL, 'a', NULL);
SELECT regexp_replace(NULL, 'a', 'a');
SELECT regexp_replace('a', NULL, NULL);
SELECT regexp_replace('a', NULL, 'a');
SELECT regexp_replace('a', 'a', NULL);

SELECT regexp_substr(1, 'a');
SELECT regexp_substr('a', 1);

SELECT regexp_substr(NULL, 'a');
SELECT regexp_substr('a', NULL);

SELECT hex(regexp_replace(x'01', x'01', x'02'));

SELECT hex(regexp_substr(x'FFFF', x'FFFF'));

CREATE TABLE t1 AS SELECT regexp_substr(x'01', x'01');
DROP TABLE t1;

CREATE TABLE t1 AS SELECT regexp_replace(x'01', x'01', x'02');
DROP TABLE t1;

SET SQL_MODE='';

SET NAMES latin1;
SET NAMES DEFAULT;

SET SQL_MODE=DEFAULT;
select ( _utf32', ,*') regexp 13946;
select regexp_instr( ( _utf32', ,*'), 13946);
select regexp_replace( ( _utf32', ,*'), 13946, 42);
select regexp_substr( ( _utf32', ,*'), 13946);

-- For the metacharacter '\N' queries below:
-- System ICU will say 1
-- Bundled ICU will say
-- ERROR 4078 (HY000): Missing data file in regular expression library.
-- This is caused by a missing data file: icudt65l/unames.icu
-- This data is builtin to libicudata.so for system ICU.
-- To support it for bundled ICU, we need to install the data file,
-- and point ICU to its location.

-- \N{UNICODE CHARACTER NAME}

SELECT 'a' regexp '\\N{latin small letter a}';
select 'ǅ' regexp '\\N{Latin Capital Letter D with Small Letter Z with Caron}';

-- \p{UNICODE PROPERTY NAME}
-- \P{UNICODE PROPERTY NAME}

SELECT 'a' regexp '\\p{alphabetic}';
SELECT 'a' regexp '\\P{alphabetic}';

SELECT '👌🏾' regexp '\\p{Emoji}\\p{Emoji_modifier}';

SELECT 'a' regexp '\\p{Lowercase_letter}';
SELECT 'a' regexp '\\p{Uppercase_letter}';

SELECT 'A' regexp '\\p{Lowercase_letter}';
SELECT 'A' regexp '\\p{Uppercase_letter}';

SELECT 'a' collate utf8mb4_0900_as_cs regexp '\\p{Lowercase_letter}';
SELECT 'A' collate utf8mb4_0900_as_cs regexp '\\p{Lowercase_letter}';

SELECT 'a' collate utf8mb4_0900_as_cs regexp '\\p{Uppercase_letter}';
SELECT 'A' collate utf8mb4_0900_as_cs regexp '\\p{Uppercase_letter}';

CREATE TABLE t1 (
  col_datetime DATETIME DEFAULT NULL,
  col_date DATE DEFAULT NULL
);

INSERT INTO t1 VALUES ('1981-09-28 23:58:32','2016-04-27');

CREATE TABLE t2 (
  col_varchar_key VARCHAR(1) DEFAULT NULL,
  col_int INT DEFAULT NULL,
  col_varchar VARCHAR(1) DEFAULT NULL
);

INSERT INTO t2 VALUES (NULL,42,'a');
UPDATE t1 SET col_datetime = 8
WHERE (col_date) IN
( SELECT
  REGEXP_INSTR( col_varchar_key, '[a-z]+' , 385025119 , 1, 'm' )
  FROM t2
);
UPDATE t1 SET col_datetime = 8
WHERE (col_date) IN
( SELECT
  REGEXP_INSTR( col_varchar_key, '[a-z]+' , 385025119 , 1, col_int )
  FROM t2
);
UPDATE t1 SET col_datetime = 8
WHERE (col_date) IN
( SELECT
  REGEXP_INSTR( col_varchar_key, '[a-z]+' , 385025119 , 1, col_varchar )
  FROM t2
);

DROP TABLE t1, t2;
