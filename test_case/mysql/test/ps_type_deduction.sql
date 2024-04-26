set optimizer_trace_max_mem_size=10000000,@@session.optimizer_trace="enabled=on";
let $show_trace=
select json_extract(trace,"$.steps[*].statement_parameters") from information_schema.optimizer_trace;

create table t1(a int);
insert into t1 values(1),(2);
create table t2(a int);

-- + (plus) : if one determined-type arg, ? is same.

prepare s from "select ?+11.1";

-- + : if no determined-type arg, ? is DOUBLE

prepare s from "select ?+?";

-- Give DOUBLE arg, like was guessed, => no repreparation
set @a=1e0;

-- INT arg, INT-to-DOUBLE may cause loss of precision, => reprepare
set @a=11;

set @a=11.1;

set @a=11e0;

set @a='11.1';

set @a=11;

-- STRING-to-INT: no repreparation, but a truncation warning for decimals
set @a='11.1';

-- STRING-to-DECIMAL/DOUBLE/DATE: no repreparation, but a truncation
-- warning if bad value
set @a='11.1garbage';

-- Roy says that due to outer context, this + should be decimal, as in
-- 11.1*(? + ?). Now it's not.

prepare s from "select 11.1*(?+?)";

-- Unary minus (-):
prepare s from 'select -(?)';
set @a='1.1';
set @a=2.2;

-- Crash with re-preparation + opt trace + TIME
prepare s from 'select cast(? as time), ?+1';
set @a="14:15:16",@b=3;
set @a="14:15:16",@b=3.1;

-- ABS:
prepare s from 'select ABS(?)';
set @a='-5.2';


-- Test "isolated parameter"

prepare s from 'select ?';

-- ? is DECIMAL due to 1.1
prepare s from 'select sum(1) over (order by 1.1 range ? preceding)';

-- Generally we reprepare if param's actual type differs from original
-- type;
set @a="ab";

set @a=1;

set @a="ab";

-- In WHERE:
prepare s from 'select 1 where ?';
set @a="ab";

set @s='abc';
set @d='2000-01-01';
set @t='23:59:59.999999';
set @dt='2000-01-01 23:59:59.999999';
set @y='2000';
set @j='{"pi":3.14159}';

-- CAST(? AS T): ? gets type of T
prepare s from 'select cast(? as unsigned)';
set @a=3.5;

-- CONVERT == CAST
prepare s from 'select convert(?, decimal(10))';

-- Predicates: AND, OR...
prepare s from 'select 1 where ? and ?';
set @a="ab";

-- Equality, BETWEEN, >=

prepare s from 'select ?=12, ?=?,
  1 BETWEEN ? AND 4.3, ? BETWEEN 1 AND 4.3, ? BETWEEN ? AND ?,
  ? >= 3, ? >= ?';

-- IFNULL

prepare s from 'select ifnull(?,?),ifnull(?,cast("2000" as date))';

-- IF

prepare s from 'select if(?,?,?),if(?,cast("2000" as date),?)';

-- COALESCE

prepare s from 'select coalesce(?,?,?),coalesce(?,cast("2000" as date),?)';

-- IN

prepare s from 'select ? in (?,?), ? in (2,?)';

-- NOT IN

prepare s from 'select ? not in (?,?), ? not in (2,?)';

-- CASE

-- As ? is compared with 3, it gets longlong.
-- When ? is compared with ?: varchar.
prepare s from '
select case ? when 3 then 1e0 else 2e0 end,
case 3 when ? then 6 else 12 end,
case ? when ? then 6 else 12 end';

-- As ? is in THEN, we use ELSE as model: double. And vice-versa.

prepare s from '
select case 3 when 3 then ? else 2e0 end,
case 3 when 3 then 1e0 else ? end,
case 3 when 3 then ? else ? end,
case ? when ? then ? else ? end';

-- All varchar.
prepare s from '
select case ? when ? then ? else ? end';

-- Other form of CASE: CASE <condition>
prepare s from '
select case when 3=2 then ? else 2e0 end,
case when ? then 6 else 12 end,
case when ? then ? else ? end';

-- Quantified subquery OP(subq)

prepare s from '
select ? in (select a from t1),
       3 in (select ? from t1)';
select ? >= ALL(select a from t1),
       ? = ALL (select a from t1),
       ? >= ANY (select a from t1),
       ? NOT IN (select a from t1)';

-- Test that how, when inferred type for parameter is VARCHAR, a BLOB
-- value is handled.

create table t3 (a mediumblob);
set @a=repeat("x",1000000);
set @b=repeat("y",1000000);
select length(@a),sha2(@a, 0);
select length(a), a=@a from t3;
select length(a), a=@b from t3;
select length(a), a from t3;
select length(a), a=@a from t3;
select length(a), a=@a, a=@b from t3;
select length(a), a=@a, a=@b from t3;
select length(a), a=@b from t4;
drop table t3,t4;
--            marked with the "custom" word.

--########### OPERATORS (e.g. a+b)

-- ~

prepare s from 'select ~ ?';

-- IS TRUE

prepare s from 'select ? IS TRUE';

-- IS FALSE

prepare s from 'select ? IS FALSE';

-- IS NOT TRUE

prepare s from 'select ? IS NOT TRUE';

-- IS NOT FALSE

prepare s from 'select ? IS NOT FALSE';

-- IS NULL

prepare s from 'select ? IS NULL';

-- IS NOT NULL

prepare s from 'select ? IS NOT NULL';

-- -

prepare s from 'select - ?';

-- !

prepare s from 'select ! ?';

-- NOT

prepare s from 'select NOT ?';

-- DIV

prepare s from 'select ? DIV ?';

-- AND

prepare s from 'select ? AND ?';

-- OR

prepare s from 'select ? OR ?';

-- XOR

prepare s from 'select ? XOR ?';

-- %

prepare s from 'select ? % ?';

-- MOD

prepare s from 'select ? MOD ?';

-- +

prepare s from 'select + ?';

-- -

prepare s from 'select - ?';

-- *

prepare s from 'select ? * ?';

-- /

prepare s from 'select ? / ?';

-- =

prepare s from 'select ? = ?';

-- :=


-- &

prepare s from 'select hex(? & ?)';
set @a=0x1234;
set @a='6';

-- |

prepare s from 'select ? | ?';
select '18446744073709551615' | 0;

-- ^

prepare s from 'select ? ^ ?';

-- /

prepare s from 'select ? / ?';

-- =

prepare s from 'select ? = ?';

-- <=>

prepare s from 'select ? <=> ?';

-- >

prepare s from 'select ? > ?';

-- >=

prepare s from 'select ? >= ?';

-- <

prepare s from 'select ? < ?';

-- <=

prepare s from 'select ? <= ?';

-- <>

prepare s from 'select ? <> ?';

-- !=

prepare s from 'select ? != ?';

-- <<

prepare s from 'select ? << ?';

-- >>

prepare s from 'select ? >> ?';

-- LIKE

prepare s from 'select ? LIKE ?';

-- NOT LIKE

prepare s from 'select ? NOT LIKE ?';

-- REGEXP

prepare s from 'select ? REGEXP ?';

-- RLIKE

prepare s from 'select ? RLIKE ?';

-- NOT REGEXP

prepare s from 'select ? NOT REGEXP ?';

-- MATCH

-- custom
CREATE TABLE articles (
          title VARCHAR(200),
          body TEXT,
          FULLTEXT (title,body)
        );
DROP TABLE articles;

-- SOUNDS LIKE

prepare s from 'select ? SOUNDS LIKE ?';

-- ABS

prepare s from 'select ABS(?)';

-- ACOS

prepare s from 'select ACOS(?)';

-- ADDDATE

prepare s from 'select ADDDATE(?,?)';

-- custom
prepare s from 'select ADDDATE(?, INTERVAL ? MONTH)';
set @a=1.1;

-- explicit type of date/datetime argument:
prepare s from 'select ADDDATE(?, INTERVAL 1 MONTH)';

-- ADDTIME

prepare s from 'select ADDTIME(?,?)';

-- AES_DECRYPT

prepare s from 'select AES_DECRYPT(?,?)';

-- AES_ENCRYPT

prepare s from 'select AES_ENCRYPT(?,?)';

-- ANY_VALUE

prepare s from 'select ANY_VALUE(?)';

-- ASCII

prepare s from 'select ASCII(?)';

-- ASIN

prepare s from 'select ASIN(?)';

-- ASYMMETRIC_DECRYPT


-- ASYMMETRIC_DERIVE


-- ASYMMETRIC_ENCRYPT


-- ASYMMETRIC_SIGN


-- ASYMMETRIC_VERIFY


-- ATAN

prepare s from 'select ATAN(?)';

-- ATAN2

prepare s from 'select ATAN2(?)';

-- AVG

prepare s from 'select AVG(?)';

-- BENCHMARK

prepare s from 'select BENCHMARK(?,?)';

-- BIN

prepare s from 'select BIN(?)';

-- BIN_TO_UUID

prepare s from 'select BIN_TO_UUID(?)';

-- BINARY

prepare s from 'select BINARY(?)';

-- BIT_AND

prepare s from 'select BIT_AND(?)';

-- BIT_COUNT

prepare s from 'select BIT_COUNT(?)';
set
@a=0b1111111111111111111111111111111111111111111111111111111111111111111111,
@b=0b1111111111111111111111111111111111111111111111111111111111111111111111;
set
@a=0b1111111111111111111111111111111111111111111111111111111111111111111111,
@b=31;
set
@a=31,
@b=31;
set
@a=0b1111111111111111111111111111111111111111111111111111111111111111111111,
@b=0b1111111111111111111111111111111111111111111111111111111111111111111111;

-- BIT_LENGTH

prepare s from 'select BIT_LENGTH(?)';

-- BIT_OR

prepare s from 'select BIT_OR(?)';

-- BIT_XOR

prepare s from 'select BIT_XOR(?)';

-- CAN_ACCESS_COLUMN # internal, cannot be called


-- CAN_ACCESS_DATABASE


-- CAN_ACCESS_TABLE


-- CAN_ACCESS_VIEW


-- CASE
-- done earlier above


-- CAST
-- done earlier above


-- CEIL

prepare s from 'select CEIL(?)';

-- CEILING

prepare s from 'select CEILING(?)';

-- CHAR

prepare s from 'select CHAR(?)';

-- CHAR_LENGTH

prepare s from 'select CHAR_LENGTH(?)';

-- CHARACTER_LENGTH

prepare s from 'select CHARACTER_LENGTH(?)';

-- CHARSET

prepare s from 'select CHARSET(?)';

-- COALESCE

prepare s from 'select COALESCE(?)';

-- COERCIBILITY

prepare s from 'select COERCIBILITY(?)';

-- COLLATION

prepare s from 'select COLLATION(?)';

-- COMPRESS

prepare s from 'select COMPRESS(?)';

-- CONCAT

prepare s from 'select CONCAT(?)';

-- CONCAT_WS

prepare s from 'select CONCAT_WS(?,?)';

-- CONNECTION_ID

prepare s from 'select CONNECTION_ID()';

-- CONV

prepare s from 'select CONV(?,?,?)';

-- CONVERT
-- cf CAST

-- CONVERT_TZ

prepare s from 'select CONVERT_TZ(?,?,?)';

-- COS

prepare s from 'select COS(?)';

-- COT

prepare s from 'select COT(?)';

-- COUNT

prepare s from 'select COUNT(?)';

-- COUNT(DISTINCT)

prepare s from 'select COUNT(DISTINCT ?,?,?,?,?)';

-- CRC32

prepare s from 'select CRC32(?)';

-- CREATE_ASYMMETRIC_PRIV_KEY


-- CREATE_ASYMMETRIC_PUB_KEY


-- CREATE_DH_PARAMETERS


-- CREATE_DIGEST


-- CUME_DIST # has no args


-- CURDATE

prepare s from 'select CURDATE()';

-- CURRENT_DATE

prepare s from 'select CURRENT_DATE()';

-- CURRENT_ROLE

prepare s from 'select CURRENT_ROLE()';

-- CURRENT_TIME

prepare s from 'select CURRENT_TIME()';

-- CURRENT_TIMESTAMP

prepare s from 'select CURRENT_TIMESTAMP()';

-- CURRENT_USER

prepare s from 'select CURRENT_USER()';

-- CURTIME

prepare s from 'select CURTIME()';

-- DATABASE

prepare s from 'select DATABASE()';

-- DATE

prepare s from 'select DATE(?)';
set @a= timestamp "2001-01-02 10:11:12.345";
set @a=date "2001-01-02";

-- DATE_ADD # cf ADDDATE


-- DATE_FORMAT

prepare s from 'select DATE_FORMAT(?,?)';

-- DATE_SUB # cf SUBDATE


-- DATEDIFF

prepare s from 'select DATEDIFF(?,?)';

-- DAY

prepare s from 'select DAY(?)';

-- DAYNAME

prepare s from 'select DAYNAME(?)';

-- DAYOFMONTH

prepare s from 'select DAYOFMONTH(?)';

-- DAYOFWEEK

prepare s from 'select DAYOFWEEK(?)';

-- DAYOFYEAR

prepare s from 'select DAYOFYEAR(?)';

-- DECODE # removed from 8.0


-- DEFAULT # arg is column, doesn't accept '?'


-- DEGREES

prepare s from 'select DEGREES(?)';

-- DENSE_RANK


-- DES_DECRYPT # removed from 8.0


-- DES_ENCRYPT


-- ELT

prepare s from 'select ELT(?,?)';

-- ENCODE


-- ENCRYPT


-- EXP

prepare s from 'select EXP(?)';

-- EXPORT_SET

prepare s from 'select EXPORT_SET(?,?,?)';

-- EXTRACT

prepare s from 'select EXTRACT(YEAR FROM ?)';

-- ExtractValue

prepare s from 'select ExtractValue(?,?)';

-- FIELD

prepare s from 'select FIELD(?,?)';

-- FIND_IN_SET

prepare s from 'select FIND_IN_SET(?,?)';

-- FIRST_VALUE
-- custom

prepare s from 'select FIRST_VALUE(?) over () from t1';

-- FLOOR

prepare s from 'select FLOOR(?)';

-- FORMAT

prepare s from 'select FORMAT(?,?)';

-- FOUND_ROWS

prepare s from 'select FOUND_ROWS()';

-- FROM_BASE64

prepare s from 'select FROM_BASE64(?)';

-- FROM_DAYS

prepare s from 'select FROM_DAYS(?)';

-- FROM_UNIXTIME

prepare s from 'select FROM_UNIXTIME(?)';

-- GeomCollection
-- a.k.a. GeometryCollection

prepare s from 'select GeomCollection(?, ?, ?, ?, ?)';

-- GET_DD_COLUMN_PRIVILEGES # internal-only


-- GET_DD_CREATE_OPTIONS


-- GET_DD_INDEX_SUB_PART_LENGTH


-- GET_FORMAT

prepare s from 'select GET_FORMAT(DATE, ?)';

-- GET_LOCK

prepare s from 'select GET_LOCK(?,?)';

-- GREATEST

prepare s from 'select GREATEST(?,?,?,?,?)';

-- GROUPING
-- the argument must be a GROUP BY expression so doesn't support '?'

-- GROUP_CONCAT

prepare s from 'select GROUP_CONCAT(?)';

-- GTID_SUBSET

prepare s from 'select GTID_SUBSET(?,?)';

-- GTID_SUBTRACT

prepare s from 'select GTID_SUBTRACT(?,?)';

-- HEX

prepare s from 'select HEX(?)';

-- HOUR

prepare s from 'select HOUR(?)';
set @a= time "10:11:12.345";
set @a= timestamp "2001-01-02 10:11:12.345";

-- ICU_VERSION

prepare s from 'select ICU_VERSION()';

-- IF

prepare s from 'select IF(?,?,?)';

-- IFNULL

prepare s from 'select IFNULL(?,?)';

-- INET_ATON

prepare s from 'select INET_ATON(?)';

-- INET_NTOA

prepare s from 'select INET_NTOA(?)';

-- INET6_ATON

prepare s from 'select INET6_ATON(?)';

-- INET6_NTOA

prepare s from 'select INET6_NTOA(?)';
set @a= _binary 0xFDFE0000000000005A55CAFFFEFA9089;
set @a= 0xFDFE0000000000005A55CAFFFEFA9089;

-- INSERT

prepare s from 'select INSERT(?,?,?,?)';

-- INSTR

prepare s from 'select INSTR(?,?)';

-- INTERNAL_AUTO_INCREMENT


-- INTERNAL_AVG_ROW_LENGTH


-- INTERNAL_CHECK_TIME


-- INTERNAL_CHECKSUM


-- INTERNAL_DATA_FREE


-- INTERNAL_DATA_LENGTH


-- INTERNAL_DD_CHAR_LENGTH


-- INTERNAL_GET_COMMENT_OR_ERROR


-- INTERNAL_GET_VIEW_WARNING_OR_ERROR


-- INTERNAL_INDEX_COLUMN_CARDINALITY


-- INTERNAL_INDEX_LENGTH


-- INTERNAL_KEYS_DISABLED


-- INTERNAL_MAX_DATA_LENGTH


-- INTERNAL_TABLE_ROWS


-- INTERNAL_UPDATE_TIME


-- INTERVAL

prepare s from 'select INTERVAL(?,?)';

-- IS_FREE_LOCK

prepare s from 'select IS_FREE_LOCK(?)';

-- IS_IPV4

prepare s from 'select IS_IPV4(?)';

-- IS_IPV4_COMPAT

prepare s from 'select IS_IPV4_COMPAT(?)';

-- IS_IPV4_MAPPED

prepare s from 'select IS_IPV4_MAPPED(?)';

-- IS_IPV6

prepare s from 'select IS_IPV6(?)';

-- IS_USED_LOCK

prepare s from 'select IS_USED_LOCK(?)';

-- IS_UUID

prepare s from 'select IS_UUID(?)';

-- ISNULL

prepare s from 'select ISNULL(?)';

-- JSON_ARRAY

prepare s from 'select JSON_ARRAY()';

-- JSON_ARRAY_APPEND

prepare s from 'select JSON_ARRAY_APPEND(?,?,?)';

-- JSON_ARRAY_INSERT

prepare s from 'select JSON_ARRAY_INSERT(?,?,?)';

-- JSON_ARRAYAGG

prepare s from 'select JSON_ARRAYAGG(?)';

-- JSON_CONTAINS

prepare s from 'select JSON_CONTAINS(?,?)';

-- JSON_CONTAINS_PATH

prepare s from 'select JSON_CONTAINS_PATH(?,?,?)';

-- JSON_DEPTH

prepare s from 'select JSON_DEPTH(?)';

-- JSON_EXTRACT

prepare s from 'select JSON_EXTRACT(?,?)';

-- JSON_INSERT

prepare s from 'select JSON_INSERT(?,?,?)';

-- JSON_KEYS

prepare s from 'select JSON_KEYS(?)';

-- JSON_LENGTH

prepare s from 'select JSON_LENGTH(?)';

-- JSON_MERGE (deprecated 8.0.3)


-- JSON_MERGE_PATCH

prepare s from 'select JSON_MERGE_PATCH(?,?)';

-- JSON_MERGE_PRESERVE

prepare s from 'select JSON_MERGE_PRESERVE(?,?)';

-- JSON_OBJECT

prepare s from 'select JSON_OBJECT()';

-- JSON_OBJECTAGG

prepare s from 'select JSON_OBJECTAGG(?,?)';

-- JSON_PRETTY

prepare s from 'select JSON_PRETTY(?)';

-- JSON_QUOTE

prepare s from 'select JSON_QUOTE(?)';

-- JSON_REMOVE

prepare s from 'select JSON_REMOVE(?,?)';

-- JSON_REPLACE

prepare s from 'select JSON_REPLACE(?,?,?)';

-- JSON_SEARCH

prepare s from 'select JSON_SEARCH(?,?,?)';

-- JSON_SET

prepare s from 'select JSON_SET(?,?,?)';

-- JSON_STORAGE_FREE

prepare s from 'select JSON_STORAGE_FREE(?)';

-- JSON_STORAGE_SIZE

prepare s from 'select JSON_STORAGE_SIZE(?)';

-- JSON_TABLE
--custom

prepare s from
'SELECT *
     FROM
       JSON_TABLE(
         ?,
         "$[*]"
         COLUMNS(
           rowid FOR ORDINALITY,
           ac VARCHAR(100) PATH "$.a" DEFAULT ''111'' ON EMPTY DEFAULT ''999'' ON ERROR,
           aj JSON PATH "$.a" DEFAULT ''{"x": 333}'' ON EMPTY,
           bx INT EXISTS PATH "$.b"
         )
       ) AS tt';

set @a=
'[{"a":"3"},{"a":2},{"b":1},{"a":0},{"a":[1,2]}]';

set @a=
cast('[{"a":"3"},{"a":2},{"b":1},{"a":0},{"a":[1,2]}]' as json);

-- Other members of clauses refuse '?':
--error ER_PARSE_ERROR
prepare s from
'SELECT *
     FROM
       JSON_TABLE(
         ?,
         ?
         COLUMNS(
           rowid FOR ORDINALITY,
           ac VARCHAR(100) PATH "$.a" DEFAULT ''999'' ON ERROR DEFAULT ''111'' ON EMPTY,
           aj JSON PATH "$.a" DEFAULT ''{"x": 333}'' ON EMPTY,
           bx INT EXISTS PATH "$.b"
         )
       ) AS tt';

-- JSON_TYPE

prepare s from 'select JSON_TYPE(?)';

-- JSON_UNQUOTE

prepare s from 'select JSON_UNQUOTE(?)';

-- JSON_VALID

prepare s from 'select JSON_VALID(?)';

-- LAG

-- custom
prepare s from 'select LAG(?,?,?) over () from t1';

-- LAST_DAY

prepare s from 'select LAST_DAY(?)';

-- LAST_INSERT_ID

prepare s from 'select LAST_INSERT_ID()';

-- LAST_VALUE

-- custom
prepare s from 'select LAST_VALUE(?) over () from t1';

-- LCASE

prepare s from 'select LCASE(?)';

-- LEAD

-- custom
prepare s from 'select LEAD(?,?,?) over () from t1';

-- LEAST

prepare s from 'select LEAST(?,?,?,?,?)';

-- LEFT

prepare s from 'select LEFT(?,?)';

-- LENGTH

prepare s from 'select LENGTH(?)';

-- LineString

prepare s from 'select LineString(?, ?, ?, ?, ?)';

-- LN

prepare s from 'select LN(?)';

-- LOAD_FILE

prepare s from 'select LOAD_FILE(?)';

-- LOCALTIME

prepare s from 'select LOCALTIME()';

-- LOCALTIMESTAMP

prepare s from 'select LOCALTIMESTAMP()';

-- LOCATE

prepare s from 'select LOCATE(?,?)';

-- LOG

prepare s from 'select LOG(?)';

-- LOG10

prepare s from 'select LOG10(?)';

-- LOG2

prepare s from 'select LOG2(?)';

-- LOWER

prepare s from 'select LOWER(?)';

-- LPAD

prepare s from 'select LPAD(?,?,?)';

-- LTRIM

prepare s from 'select LTRIM(?)';

-- MAKE_SET

prepare s from 'select MAKE_SET(?,?)';

-- MAKEDATE

prepare s from 'select MAKEDATE(?,?)';

-- MAKETIME

prepare s from 'select MAKETIME(?,?,?)';

-- SOURCE_POS_WAIT

prepare s from 'select SOURCE_POS_WAIT(?,?)';

-- MAX

prepare s from 'select MAX(?)';

-- MBRContains

prepare s from 'select MBRContains(?,?)';

-- MBRCoveredBy

prepare s from 'select MBRCoveredBy(?,?)';

-- MBRCovers

prepare s from 'select MBRCovers(?,?)';

-- MBRDisjoint

prepare s from 'select MBRDisjoint(?,?)';

-- MBREquals

prepare s from 'select MBREquals(?,?)';

-- MBRIntersects

prepare s from 'select MBRIntersects(?,?)';

-- MBROverlaps

prepare s from 'select MBROverlaps(?,?)';

-- MBRTouches

prepare s from 'select MBRTouches(?,?)';

-- MBRWithin

prepare s from 'select MBRWithin(?,?)';

-- MD5

prepare s from 'select MD5(?)';

-- MICROSECOND

prepare s from 'select MICROSECOND(?)';

-- MID

prepare s from 'select MID(?,?)';

-- MIN

prepare s from 'select MIN(?)';

-- MINUTE

prepare s from 'select MINUTE(?)';

-- MOD

prepare s from 'select MOD(?,?)';

-- MONTH

prepare s from 'select MONTH(?)';

-- MONTHNAME

prepare s from 'select MONTHNAME(?)';

-- MultiLineString

prepare s from 'select MultiLineString(?, ?, ?, ?, ?)';

-- MultiPoint

prepare s from 'select MultiPoint(?, ?, ?, ?, ?)';

-- MultiPolygon

prepare s from 'select MultiPolygon(?, ?, ?, ?, ?)';

-- NAME_CONST # doesn't accept '?'

-- NOW

prepare s from 'select NOW()';

-- NTH_VALUE

-- custom
prepare s from 'select NTH_VALUE(?,?) over () from t1';

-- NTILE

-- custom
prepare s from 'select NTILE(?) over () from t1';

-- NULLIF

prepare s from 'select NULLIF(?,?)';

-- OCT

prepare s from 'select OCT(?)';

-- OCTET_LENGTH

prepare s from 'select OCTET_LENGTH(?)';

-- ORD

prepare s from 'select ORD(?)';

-- PASSWORD # removed in 8.0.11


-- PERCENT_RANK


-- PERIOD_ADD

prepare s from 'select PERIOD_ADD(?,?)';

-- PERIOD_DIFF

prepare s from 'select PERIOD_DIFF(?,?)';

-- PI

prepare s from 'select PI()';

-- Point

prepare s from 'select Point(?,?)';

-- Polygon

prepare s from 'select Polygon(?, ?, ?, ?, ?)';

-- POSITION cf LOCATE


-- POW

prepare s from 'select POW(?,?)';

-- POWER

prepare s from 'select POWER(?,?)';

-- QUARTER

prepare s from 'select QUARTER(?)';

-- QUOTE

prepare s from 'select QUOTE(?)';

-- RADIANS

prepare s from 'select RADIANS(?)';

-- RAND

prepare s from 'select RAND()';

-- RANDOM_BYTES

prepare s from 'select RANDOM_BYTES(?)';

-- RANK


-- REGEXP_INSTR

prepare s from 'select REGEXP_INSTR(?,?)';

-- REGEXP_LIKE

prepare s from 'select REGEXP_LIKE(?,?)';

-- REGEXP_REPLACE

prepare s from 'select REGEXP_REPLACE(?,?,?)';

-- REGEXP_SUBSTR

prepare s from 'select REGEXP_SUBSTR(?,?)';

-- RELEASE_ALL_LOCKS

prepare s from 'select RELEASE_ALL_LOCKS()';

-- RELEASE_LOCK

prepare s from 'select RELEASE_LOCK(?)';

-- REPEAT

prepare s from 'select REPEAT(?,?)';

-- REPLACE

prepare s from 'select REPLACE(?,?,?)';

-- REVERSE

prepare s from 'select REVERSE(?)';

-- RIGHT

prepare s from 'select RIGHT(?,?)';

-- ROLES_GRAPHML

prepare s from 'select ROLES_GRAPHML()';

-- ROUND

prepare s from 'select ROUND(?)';

-- ROW_COUNT

prepare s from 'select ROW_COUNT()';

-- ROW_NUMBER


-- RPAD

prepare s from 'select RPAD(?,?,?)';

-- RTRIM

prepare s from 'select RTRIM(?)';

-- SCHEMA

prepare s from 'select SCHEMA()';

-- SEC_TO_TIME

prepare s from 'select SEC_TO_TIME(?)';

-- SECOND

prepare s from 'select SECOND(?)';

-- SESSION_USER

prepare s from 'select SESSION_USER()';

-- SHA1

prepare s from 'select SHA1(?)';

-- SHA2

prepare s from 'select SHA2(?,?)';

-- SIGN

prepare s from 'select SIGN(?)';

-- SIN

prepare s from 'select SIN(?)';

-- SLEEP

prepare s from 'select SLEEP(?)';

-- SOUNDEX

prepare s from 'select SOUNDEX(?)';

-- SPACE

prepare s from 'select SPACE(?)';

-- SQRT

prepare s from 'select SQRT(?)';

-- ST_Area

prepare s from 'select ST_Area(?)';

-- ST_AsBinary

prepare s from 'select ST_AsBinary(?)';

-- ST_AsGeoJSON

prepare s from 'select ST_AsGeoJSON(?)';

-- ST_AsText

prepare s from 'select ST_AsText(?)';

-- ST_Buffer

prepare s from 'select ST_Buffer(?,?)';

-- ST_Buffer_Strategy

prepare s from 'select ST_Buffer_Strategy(?)';

-- ST_Centroid

prepare s from 'select ST_Centroid(?)';

-- ST_Contains

prepare s from 'select ST_Contains(?,?)';

-- ST_ConvexHull

prepare s from 'select ST_ConvexHull(?)';

-- ST_Crosses

prepare s from 'select ST_Crosses(?,?)';

-- ST_Difference

prepare s from 'select ST_Difference(?,?)';

-- ST_Dimension

prepare s from 'select ST_Dimension(?)';

-- ST_Disjoint

prepare s from 'select ST_Disjoint(?,?)';

-- ST_Distance

prepare s from 'select ST_Distance(?,?)';

-- ST_Distance_Sphere

prepare s from 'select ST_Distance_Sphere(?,?)';

-- ST_EndPoint

prepare s from 'select ST_EndPoint(?)';

-- ST_Envelope

prepare s from 'select ST_Envelope(?)';

-- ST_Equals

prepare s from 'select ST_Equals(?,?)';

-- ST_ExteriorRing

prepare s from 'select ST_ExteriorRing(?)';

-- ST_GeoHash

prepare s from 'select ST_GeoHash(?,?)';

-- ST_GeomCollFromText

prepare s from 'select ST_GeomCollFromText(?)';

-- ST_GeomCollFromWKB

prepare s from 'select ST_GeomCollFromWKB(?)';

-- ST_GeometryN

prepare s from 'select ST_GeometryN(?,?)';

-- ST_GeometryType

prepare s from 'select ST_GeometryType(?)';

-- ST_GeomFromGeoJSON

prepare s from 'select ST_GeomFromGeoJSON(?)';

-- ST_GeomFromText

prepare s from 'select ST_GeomFromText(?)';

-- ST_GeomFromWKB

prepare s from 'select ST_GeomFromWKB(?)';

-- ST_InteriorRingN

prepare s from 'select ST_InteriorRingN(?,?)';

-- ST_Intersection

prepare s from 'select ST_Intersection(?,?)';

-- ST_Intersects

prepare s from 'select ST_Intersects(?,?)';

-- ST_IsClosed

prepare s from 'select ST_IsClosed(?)';

-- ST_IsEmpty

prepare s from 'select ST_IsEmpty(?)';

-- ST_IsSimple

prepare s from 'select ST_IsSimple(?)';

-- ST_IsValid

prepare s from 'select ST_IsValid(?)';

-- ST_LatFromGeoHash

prepare s from 'select ST_LatFromGeoHash(?)';

-- ST_Latitude

prepare s from 'select ST_Latitude(?)';

-- ST_Length

prepare s from 'select ST_Length(?)';

-- ST_LineFromText

prepare s from 'select ST_LineFromText(?)';

-- ST_LineFromWKB

prepare s from 'select ST_LineFromWKB(?)';

-- ST_LongFromGeoHash

prepare s from 'select ST_LongFromGeoHash(?)';

-- ST_Longitude

prepare s from 'select ST_Longitude(?)';

-- ST_MakeEnvelope

prepare s from 'select ST_MakeEnvelope(?,?)';

-- ST_MLineFromText

prepare s from 'select ST_MLineFromText(?)';

-- ST_MLineFromWKB

prepare s from 'select ST_MLineFromWKB(?)';

-- ST_MPointFromText

prepare s from 'select ST_MPointFromText(?)';

-- ST_MPointFromWKB

prepare s from 'select ST_MPointFromWKB(?)';

-- ST_MPolyFromText

prepare s from 'select ST_MPolyFromText(?)';

-- ST_MPolyFromWKB

prepare s from 'select ST_MPolyFromWKB(?)';

-- ST_NumGeometries

prepare s from 'select ST_NumGeometries(?)';

-- ST_NumInteriorRing

prepare s from 'select ST_NumInteriorRing(?)';

-- ST_NumPoints

prepare s from 'select ST_NumPoints(?)';

-- ST_Overlaps

prepare s from 'select ST_Overlaps(?,?)';

-- ST_PointFromGeoHash

prepare s from 'select ST_PointFromGeoHash(?,?)';

-- ST_PointFromText

prepare s from 'select ST_PointFromText(?)';

-- ST_PointFromWKB

prepare s from 'select ST_PointFromWKB(?)';

-- ST_PointN

prepare s from 'select ST_PointN(?,?)';

-- ST_PolyFromText

prepare s from 'select ST_PolyFromText(?)';

-- ST_PolyFromWKB

prepare s from 'select ST_PolyFromWKB(?)';

-- ST_Simplify

prepare s from 'select ST_Simplify(?,?)';

-- ST_SRID

prepare s from 'select ST_SRID(?)';

-- ST_StartPoint

prepare s from 'select ST_StartPoint(?)';

-- ST_SwapXY

prepare s from 'select ST_SwapXY(?)';

-- ST_SymDifference

prepare s from 'select ST_SymDifference(?,?)';

-- ST_Touches

prepare s from 'select ST_Touches(?,?)';

-- ST_Union

prepare s from 'select ST_Union(?,?)';

-- ST_Validate

prepare s from 'select ST_Validate(?)';

-- ST_Within

prepare s from 'select ST_Within(?,?)';

-- ST_X

prepare s from 'select ST_X(?)';

-- ST_Y

prepare s from 'select ST_Y(?)';

-- STATEMENT_DIGEST

prepare s from 'select STATEMENT_DIGEST(?)';

-- STATEMENT_DIGEST_TEXT

prepare s from 'select STATEMENT_DIGEST_TEXT(?)';

-- STD

prepare s from 'select STD(?)';

-- STDDEV

prepare s from 'select STDDEV(?)';

-- STDDEV_POP

prepare s from 'select STDDEV_POP(?)';

-- STDDEV_SAMP

prepare s from 'select STDDEV_SAMP(?)';

-- STR_TO_DATE

prepare s from 'select STR_TO_DATE(?,?)';

-- STRCMP

prepare s from 'select STRCMP(?,?)';

-- SUBDATE

prepare s from 'select SUBDATE(?,?)';

-- explicit type of date/datetime argument:
prepare s from 'select SUBDATE(?, INTERVAL 1 MONTH)';

-- SUBSTR

prepare s from 'select SUBSTR(?,?)';

-- SUBSTRING

prepare s from 'select SUBSTRING(?,?)';

-- SUBSTRING_INDEX

prepare s from 'select SUBSTRING_INDEX(?,?,?)';

-- SUBTIME

prepare s from 'select SUBTIME(?,?)';

-- SUM

prepare s from 'select SUM(?)';

-- SYSDATE

prepare s from 'select SYSDATE()';

-- SYSTEM_USER

prepare s from 'select SYSTEM_USER()';

-- TAN

prepare s from 'select TAN(?)';

-- TIME

prepare s from 'select TIME(?)';

-- TIME_FORMAT

prepare s from 'select TIME_FORMAT(?,?)';

-- TIME_TO_SEC

prepare s from 'select TIME_TO_SEC(?)';

-- TIMEDIFF

prepare s from 'select TIMEDIFF(?,?)';
set @a= time "01:02:00";
set @a= timestamp "2001-01-02 01:02:00";

-- TIMESTAMP

prepare s from 'select TIMESTAMP(?)';

-- TIMESTAMPADD
-- custom

prepare s from 'select TIMESTAMPADD(HOUR,?,?)';

-- TIMESTAMPDIFF
-- custom

prepare s from 'select TIMESTAMPDIFF(HOUR,?,?)';

-- TO_BASE64

prepare s from 'select TO_BASE64(?)';

-- TO_DAYS

prepare s from 'select TO_DAYS(?)';
set @a= date "2001-01-02";
set @a= timestamp "2001-01-02 10:11:12.345";

-- TO_SECONDS

prepare s from 'select TO_SECONDS(?)';

-- TRIM

prepare s from 'select TRIM(?)';

-- TRUNCATE

prepare s from 'select TRUNCATE(?,?)';

-- UCASE

prepare s from 'select UCASE(?)';

-- UNCOMPRESS

prepare s from 'select UNCOMPRESS(?)';

-- UNCOMPRESSED_LENGTH

prepare s from 'select UNCOMPRESSED_LENGTH(?)';

-- UNHEX

prepare s from 'select UNHEX(?)';

-- UNIX_TIMESTAMP

prepare s from 'select UNIX_TIMESTAMP()';

-- UpdateXML

prepare s from 'select UpdateXML(?,?,?)';

-- UPPER

prepare s from 'select UPPER(?)';

-- USER

prepare s from 'select USER()';

-- UTC_DATE

prepare s from 'select UTC_DATE()';

-- UTC_TIME

prepare s from 'select UTC_TIME()';

-- UTC_TIMESTAMP

prepare s from 'select UTC_TIMESTAMP()';

-- UUID

prepare s from 'select UUID()';

-- UUID_SHORT

prepare s from 'select UUID_SHORT()';

-- UUID_TO_BIN

prepare s from 'select UUID_TO_BIN(?)';

-- VALIDATE_PASSWORD_STRENGTH

prepare s from 'select VALIDATE_PASSWORD_STRENGTH(?)';

-- VALUES
-- custom
CREATE TABLE t3(a INT, b INT);
DROP TABLE t3;

-- VAR_POP

prepare s from 'select VAR_POP(?)';

-- VAR_SAMP

prepare s from 'select VAR_SAMP(?)';

-- VARIANCE

prepare s from 'select VARIANCE(?)';

-- VERSION

prepare s from 'select VERSION()';

-- WAIT_FOR_EXECUTED_GTID_SET

prepare s from 'select WAIT_FOR_EXECUTED_GTID_SET(?)';

-- WEEK

prepare s from 'select WEEK(?)';

-- WEEKDAY

prepare s from 'select WEEKDAY(?)';

-- WEEKOFYEAR

prepare s from 'select WEEKOFYEAR(?)';

-- WEIGHT_STRING

prepare s from 'select WEIGHT_STRING(?)';

-- YEAR

prepare s from 'select YEAR(?)';

-- YEARWEEK

prepare s from 'select YEARWEEK(?)';

CREATE FUNCTION f(a INTEGER) RETURNS INTEGER DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a INTEGER UNSIGNED) RETURNS INTEGER UNSIGNED DETERMINISTIC
  RETURN a + 1;

DROP FUNCTION f;

CREATE FUNCTION f(a BIGINT) RETURNS BIGINT DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a MEDIUMINT) RETURNS MEDIUMINT DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a SMALLINT) RETURNS SMALLINT DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a TINYINT) RETURNS TINYINT DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a DECIMAL(38,12)) RETURNS DECIMAL(38,12) DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a FLOAT) RETURNS FLOAT DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a DOUBLE) RETURNS DOUBLE DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a DATE) RETURNS DATE DETERMINISTIC
  RETURN a;

DROP FUNCTION f;

CREATE FUNCTION f(a TIME(6)) RETURNS TIME(6) DETERMINISTIC
  RETURN a;

DROP FUNCTION f;

CREATE FUNCTION f(a DATETIME(6)) RETURNS DATETIME(6) DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a TIMESTAMP(6)) RETURNS TIMESTAMP(6) DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a YEAR) RETURNS YEAR DETERMINISTIC
  RETURN a;

DROP FUNCTION f;

CREATE FUNCTION f(a CHAR(8)) RETURNS CHAR(8) DETERMINISTIC
  RETURN a;

DROP FUNCTION f;

CREATE FUNCTION f(a VARCHAR(255)) RETURNS VARCHAR(255) DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a BINARY(8)) RETURNS BINARY(8) DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a VARBINARY(255)) RETURNS VARBINARY(255) DETERMINISTIC
  RETURN - a;

DROP FUNCTION f;

CREATE FUNCTION f(a BIT(64)) RETURNS BIT(64) DETERMINISTIC
  RETURN a;

DROP FUNCTION f;

CREATE FUNCTION f2(a INTEGER, b INTEGER) RETURNS INTEGER DETERMINISTIC
  RETURN a + b;

CREATE FUNCTION f3(a INTEGER, b INTEGER, c VARCHAR(100)) RETURNS INTEGER
                                                         DETERMINISTIC
  RETURN a + b + CAST(c AS SIGNED);

DROP FUNCTION f2;
DROP FUNCTION f3;

DROP TABLE t1,t2;

CREATE TABLE t1
(i1 TINYINT,
 i2 SMALLINT,
 i3 MEDIUMINT,
 i4 INTEGER,
 i8 BIGINT,
 dc1 DECIMAL(6,0),
 dc2 DECIMAL(16,10)
);

INSERT INTO t1 VALUES(1, 1, 1, 1, 1, 1, 1.1111111111);

SET @i1_max=127;
SET @i2_max=32767;
SET @i3_max=8388607;
SET @i4_max=2147483647;
SET @i8_max=9223372036854775807;
SET @dc1_max=999999;
SET @dc2_max=999999.9999999999;
SET @dc1_ext=1.1234;
SET @dc2_ext=1.12345678901234;

DROP TABLE t1;

-- Check reprepare count for INSERT and UPDATE operations

CREATE TABLE t1
(pk INTEGER,
 i1 TINYINT,
 i2 SMALLINT,
 i3 MEDIUMINT,
 i4 INTEGER,
 i8 BIGINT,
 i1u TINYINT UNSIGNED,
 i2u SMALLINT UNSIGNED,
 i3u MEDIUMINT UNSIGNED,
 i4u INTEGER UNSIGNED,
 i8u BIGINT UNSIGNED,
 dc DECIMAL(16,10),
 f4 FLOAT,
 f8 DOUBLE,
 vc VARCHAR(10),
 fc CHAR(10),
 vb VARBINARY(10),
 fb BINARY(10),
 d DATE,
 t TIME(6),
 dt DATETIME(6),
 ts TIMESTAMP(6)
);
 SET i1=?, i2=?, i3=?, i4=?, i8=?, i1u=?, i2u=?, i3u=?, i4u=?, i8u=?,
     dc=?, f4=?, f8=?, vc=?, fc=?, vb=?, fb=?, d=?, t=?, dt=?, ts=?
 WHERE pk=1";
 ON DUPLICATE KEY
 UPDATE i1=?, i2=?, i3=?, i4=?, i8=?, i1u=?, i2u=?, i3u=?, i4u=?, i8u=?,
     dc=?, f4=?, f8=?, vc=?, fc=?, vb=?, fb=?, d=?, t=?, dt=?, ts=?";

SET @i8=1;
SET @i8u=CAST(1 AS UNSIGNED);
SET @dc=3.14159;
SET @f8=3.14159E2;
SET @vc='abcxyz';
SET @vb=CONVERT(@vc USING BINARY);
SET @d='2018-01-01';
SET @t='01:01:01.999999';
SET @dt='2018-01-01 01:01:01.999999';
                 @dc, @f8, @f8, @vc, @vc, @vb, @vb, @d, @t, @dt, @dt;
                 @dc, @f8, @f8, @vc, @vc, @vb, @vb, @d, @t, @dt, @dt;
                  @dc, @f8, @f8, @vc, @vc, @vb, @vb, @d, @t, @dt, @dt,
                  @i8, @i8, @i8, @i8, @i8, @i8u, @i8u, @i8u, @i8u, @i8u,
                  @dc, @f8, @f8, @vc, @vc, @vb, @vb, @d, @t, @dt, @dt;

DROP TABLE t1;

SET @i8=555;
SET @dc=3.14159;
SET @r8=2.71828e0;
SET @vc1='abc';
SET @vc2='xyz';

-- Check type propagation for some context-aware operators

FLUSH STATUS;

-- No context, so assume type is DOUBLE

PREPARE s1 FROM "SELECT ? + ?";

-- Context is integer, so assume parameters are integer

PREPARE s1 FROM "SELECT 666 + (? + ?)";

-- Same, but with a unary operator:

PREPARE s1 FROM "SELECT -(?)";

-- GREATEST and LEAST

-- No context, so assume type is VARCHAR

PREPARE s1 FROM "SELECT GREATEST(?, ?), LEAST(?, ?)";

-- Context is INTEGER and DOUBLE

PREPARE s1 FROM "SELECT 666 + GREATEST(?, ?), 3.14e0 + LEAST(?, ?)";

-- COALESCE

-- No context, so assume type is VARCHAR

PREPARE s1 FROM "SELECT COALESCE(?, ?)";

-- Context is INTEGER

PREPARE s1 FROM "SELECT 666 + COALESCE(?, ?)";

-- CASE

-- No context, so assume type is VARCHAR

PREPARE s1 FROM "SELECT CASE ? WHEN 1 THEN ? ELSE ? END";

-- Context is INTEGER

PREPARE s1 FROM "SELECT 666 + CASE ? WHEN 1 THEN ? ELSE ? END";

-- IFNULL

-- No context, so assume type is VARCHAR

PREPARE s1 FROM "SELECT IFNULL(?, ?)";

-- Context is INTEGER

PREPARE s1 FROM "SELECT 666 + IFNULL(?, ?)";

-- NULLIF

-- No context, so assume type is VARCHAR

PREPARE s1 FROM "SELECT NULLIF(?, ?)";

-- Context is INTEGER

PREPARE s1 FROM "SELECT 666 + NULLIF(?, ?)";

-- IF

-- No context, so assume type is VARCHAR

PREPARE s1 FROM "SELECT IF(?, ?, ?)";

-- Context is INTEGER

PREPARE s1 FROM "SELECT 666 + IF(?, ?, ?)";

CREATE TABLE t1 (a int);
CREATE TABLE t2 (a int);
SET @var1 = 'a';
SET @var2 = 'b';

DROP TABLE t1, t2;
set @iv=5;
set @ic='55';

CREATE TABLE t1 (
  col1 VARCHAR(100) NOT NULL COLLATE latin1_swedish_ci,
  col2 VARCHAR(200) NOT NULL COLLATE utf8mb4_general_ci
);
DROP TABLE t1;

CREATE TABLE t(c VARCHAR(32));

INSERT INTO t VALUES('xyz');
DROP TABLE t;
