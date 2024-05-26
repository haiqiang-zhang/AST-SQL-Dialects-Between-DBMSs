select format(1.5555,0),format(123.5555,1),format(1234.5555,2),format(12345.55555,3),format(123456.5555,4),format(1234567.5555,5),format("12345.2399",2);
select inet_ntoa(inet_aton("255.255.255.255.255.255.255.255"));
select inet_aton("255.255.255.255.255"),inet_aton("255.255.1.255"),inet_aton("0.1.255");
select hex(inet_aton('127'));
select length(uuid()), charset(uuid()), length(unhex(replace(uuid(),_utf8mb3'-',_utf8mb3'')));
select @b - @a;
select length(format('nan', 2)) > 0;
select concat("$",format(2500,2));
create table t1 ( a timestamp );
insert into t1 values ( '2004-01-06 12:34' );
select a from t1 where left(a+0,6) in ( left(20040106,6) );
select a from t1 where left(a+0,6) = ( left(20040106,6) );
select a from t1 where right(a+0,6) in ( right(20040106123400,6) );
select a from t1 where right(a+0,6) = ( right(20040106123400,6) );
select a from t1 where mid(a+0,6,3) in ( mid(20040106123400,6,3) );
select a from t1 where mid(a+0,6,3) = ( mid(20040106123400,6,3) );
drop table t1;
select export_set(3, _latin1'foo', _utf8mb3'bar', ',', 4);
create table t1 as select uuid(), length(uuid());
drop table t1;
SELECT @sleep_time_per_result_row * @row_count - @max_acceptable_delay >
               @sleep_time_per_result_row AS must_be_1,
               @row_count - 1 >= 3 AS must_be_also_1,
               @sleep_time_per_result_row, @row_count, @max_acceptable_delay;
DROP TEMPORARY TABLE IF EXISTS t_history;
DROP TABLE IF EXISTS t1;
CREATE TEMPORARY TABLE t_history (attempt SMALLINT,
start_ts DATETIME, end_ts DATETIME,
start_cached INTEGER, end_cached INTEGER);
CREATE TABLE t1 (f1 BIGINT);
INSERT INTO t1 VALUES (1);
SELECT @aux1 AS "Expect 1";
SELECT * FROM t_history;
DROP TABLE t1;
DROP TEMPORARY TABLE t_history;
create table t1 select INET_ATON('255.255.0.1') as `a`;
drop table t1;
drop table if exists table_26093;
drop function if exists func_26093_a;
drop function if exists func_26093_b;
create table table_26093(a int);
insert into table_26093 values
(1), (2), (3), (4), (5),
(6), (7), (8), (9), (10);
select avg(a) from table_26093;
select benchmark(100, (select avg(a) from table_26093));
select @invoked;
select @invoked;
drop table table_26093;
SELECT NAME_CONST('test', NULL);
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3);
SELECT NAME_CONST('flag',1)    * MAX(a) FROM t1;
SELECT NAME_CONST('flag',1.5)  * MAX(a) FROM t1;
SELECT NAME_CONST('flag',-1)   * MAX(a) FROM t1;
SELECT NAME_CONST('flag',-1.5) * MAX(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (5), (2);
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (), (), ();
DROP TABLE t1;
create table t1 (a int not null);
insert into t1 values (-1), (-2);
select min(a) from t1 group by inet_ntoa(a);
drop table t1;
select @@session.time_zone into @save_tz;
select uuid() into @my_uuid;
select mid(@my_uuid,15,1);
select 24 * 60 * 60 * 1000 * 1000 * 10 into @my_uuid_one_day;
select floor(conv(@my_uuidate,16,10)/@my_uuid_one_day) into @my_uuid_date;
select 141427 + datediff(curdate(),'1970-01-01') into @my_uuid_synthetic;
select @my_uuid_date - @my_uuid_synthetic;
CREATE TABLE t1 (a DATE);
SELECT * FROM t1 WHERE a = NAME_CONST('reportDate',
  _binary'2009-01-09' COLLATE 'binary');
DROP TABLE t1;
select NAME_CONST('_id',1234) as id;
select connection_id() > 0;
CREATE TABLE t1 (a INT, b LONGBLOB);
INSERT INTO t1 VALUES (1, '2'), (2, '3'), (3, '2');
SELECT DISTINCT LEAST(a, (SELECT b FROM t1 LIMIT 1)) FROM t1 UNION SELECT 1;
SELECT DISTINCT GREATEST(a, (SELECT b FROM t1 LIMIT 1)) FROM t1 UNION SELECT 1;
DROP TABLE t1;
SELECT INET_NTOA(0);
SELECT '1' IN ('1', INET_NTOA(0));
CREATE TABLE t1 (a SET('a'), b INT);
INSERT INTO t1 VALUES ('', 0);
SELECT COALESCE(a) = COALESCE(b) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b LONGBLOB);
INSERT INTO t1 VALUES (1, '2'), (2, '3'), (3, '2');
DROP TABLE t1;
SELECT '1' IN ('1', INET_NTOA(0));
CREATE TABLE t1 (a INT);
DROP TABLE t1;
SELECT INET6_ATON(NULL) IS NULL;
SELECT HEX(INET6_ATON('::ABCD:1.2.3.4'));
SELECT LENGTH(INET6_ATON('0.0.0.0'));
SELECT INET6_NTOA(NULL);
SELECT HEX(INET6_ATON(INET_NTOA(INET_ATON('1.2.3.4')))) AS x;
SELECT IS_IPV4(NULL);
SELECT IS_IPV6(NULL);
SELECT IS_IPV4_MAPPED(INET6_ATON('1.2.3.4')),
       IS_IPV4_COMPAT(INET6_ATON('1.2.3.4'));
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
CREATE TABLE t1(ip INT UNSIGNED);
CREATE TABLE t2(ip VARBINARY(16));
INSERT INTO t1 VALUES
  (INET_ATON('1.2.3.4')), (INET_ATON('255.255.255.255'));
INSERT INTO t2 SELECT INET6_ATON(INET_NTOA(ip)) FROM t1;
SELECT INET6_NTOA(ip), HEX(ip), LENGTH(ip) FROM t2;
DELETE FROM t2;
INSERT INTO t2 VALUES
  (INET6_ATON('1.2.3.4')), (INET6_ATON('255.255.255.255')),
  (INET6_ATON('::1.2.3.4')), (INET6_ATON('::ffff:255.255.255.255')),
  (INET6_ATON('::')), (INET6_ATON('::1')),
  (INET6_ATON('1020:3040:5060:7080:90A0:B0C0:D0E0:F010'));
DELETE FROM t2;
DELETE FROM t2;
DROP TABLE t1;
DROP TABLE t2;
SELECT IS_IPV4_MAPPED(MIN(AES_ENCRYPT(1,2)));
SELECT IS_IPV4_COMPAT(MIN(AES_ENCRYPT(1,2)));
select format('f','')<=replace(1,1,mid(0xd9,2,1));
CREATE TABLE t1 (
pk INTEGER PRIMARY KEY,
col_time TIME DEFAULT NULL,
col_varchar VARCHAR(1) DEFAULT NULL,
KEY (col_varchar)
);
INSERT INTO t1 VALUES(5, '11:03:56', 'I');
PREPARE st FROM
"SELECT * FROM t1
 WHERE pk = 5 AND (col_time, col_varchar) IN ((23, 'Y'), (92, 'W'))";
DEALLOCATE PREPARE st;
DROP TABLE t1;
