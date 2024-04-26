drop table if exists t1;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
select 1.1 IN (1.0, 1.2);
select 1.1 IN (1.0, 1.2, 1.1, 1.4, 0.5);
select 1.1 IN (1.0, 1.2, NULL, 1.4, 0.5);
select 0.5 IN (1.0, 1.2, NULL, 1.4, 0.5);
select 1 IN (1.11, 1.2, 1.1, 1.4, 1, 0.5);
select 1 IN (1.11, 1.2, 1.1, 1.4, NULL, 0.5);

--
-- case function test
--
select case 1.0 when 0.1 then "a" when 1.0 then "b" else "c" END;
select case 0.1 when 0.1 then "a" when 1.0 then "b" else "c" END;
select case 1 when 0.1 then "a" when 1.0 then "b" else "c" END;
select case 1.0 when 0.1 then "a" when 1 then "b" else "c" END;
select case 1.001 when 0.1 then "a" when 1 then "b" else "c" END;

--
-- non constant IN test
--
create table t1 (a decimal(6,3));
insert into t1 values (1.0), (NULL), (0.1);
select * from t1;
select 0.1 in (1.0, 1.2, 1.1, a, 1.4, 0.5) from t1;
drop table t1;

--
-- if function test
--
create table t1 select if(1, 1.1, 1.2), if(0, 1.1, 1.2), if(0.1, 1.1, 1.2), if(0, 1, 1.1), if(0, NULL, 1.2), if(1, 0.22e1, 1.1), if(1E0, 1.1, 1.2);
select * from t1;
drop table t1;

--
-- NULLIF
--
create table t1 select nullif(1.1, 1.1), nullif(1.1, 1.2), nullif(1.1, 0.11e1), nullif(1.0, 1), nullif(1, 1.0), nullif(1, 1.1);
select * from t1;
drop table t1;

--
-- saving in decimal field with overflow
--

create table t1 (a decimal(4,2));
insert into t1 value (10000), (1.1e10), ("11111"), (100000.1);
insert into t1 value (-10000), (-1.1e10), ("-11111"), (-100000.1);
select a from t1;
drop table t1;
create table t1 (a decimal(4,2) unsigned);
insert into t1 value (10000), (1.1e10), ("11111"), (100000.1);
insert into t1 value (-10000), (-1.1e10), ("-11111"), (-100000.1);
select a from t1;
drop table t1;


--
-- saving in field with overflow from decimal
--
create table t1 (a bigint);
insert into t1 values (18446744073709551615.0);
insert into t1 values (9223372036854775808.0);
insert into t1 values (-18446744073709551615.0);
select * from t1;
drop table t1;
create table t1 (a bigint unsigned);
insert into t1 values (18446744073709551615.0);
insert into t1 values (9223372036854775808.0);
insert into t1 values (9999999999999999999999999.000);
insert into t1 values (-1.0);
select * from t1;
drop table t1;
create table t1 (a tinyint);
insert into t1 values (18446744073709551615.0);
insert into t1 values (9223372036854775808.0);
select * from t1;
drop table t1;

--
-- test that functions create decimal fields
--
create table t1 select round(15.4,-1), truncate(-5678.123451,-3), abs(-1.1), -(-1.1);
drop table t1;

--
-- Trydy's tests
--
set session sql_mode='traditional';
select 1e10/0e0;
create table wl1612 (col1 int, col2 decimal(38,10), col3 numeric(38,10));
insert into wl1612 values(1,12345678901234567890.1234567890,12345678901234567890.1234567890);
select * from wl1612;
insert into wl1612 values(2,01234567890123456789.0123456789,01234567890123456789.0123456789);
select * from wl1612 where col1=2;
insert into wl1612 values(3,1234567890123456789012345678.0123456789,1234567890123456789012345678.0123456789);
select * from wl1612 where col1=3;

select col1/0 from wl1612;
select col2/0 from wl1612;
select col3/0 from wl1612;

insert into wl1612 values(5,5000.0005,5000.0005);
insert into wl1612 values(6,5000.0005,5000.0005);
select sum(col2),sum(col3) from wl1612;

insert into wl1612 values(7,500000.000005,500000.000005);
insert into wl1612 values(8,500000.000005,500000.000005);
select sum(col2),sum(col3) from wl1612 where col1>4;

insert into wl1612 (col1, col2) values(9,1.01234567891);
insert into wl1612 (col1, col2) values(10,1.01234567894);
insert into wl1612 (col1, col2) values(11,1.01234567895);
insert into wl1612 (col1, col2) values(12,1.01234567896);
select col1,col2 from wl1612 where col1>8;

insert into wl1612 (col1, col3) values(13,1.01234567891);
insert into wl1612 (col1, col3) values(14,1.01234567894);
insert into wl1612 (col1, col3) values(15,1.01234567895);
insert into wl1612 (col1, col3) values(16,1.01234567896);
select col1,col3 from wl1612 where col1>12;

select col1 from wl1612 where col1>4 and col2=1.01234567891;
select col1 from wl1612 where col1>4 and col2=1.0123456789;
select col1 from wl1612 where col1>4 and col2<>1.0123456789;
select col1 from wl1612 where col1>4 and col2<1.0123456789;
select col1 from wl1612 where col1>4 and col2<=1.0123456789;
select col1 from wl1612 where col1>4 and col2>1.0123456789;
select col1 from wl1612 where col1>4 and col2>=1.0123456789;
select col1 from wl1612 where col1>4 and col2=1.012345679;
select col1 from wl1612 where col1>4 and col2<>1.012345679;
select col1 from wl1612 where col1>4 and col3=1.01234567891;
select col1 from wl1612 where col1>4 and col3=1.0123456789;
select col1 from wl1612 where col1>4 and col3<>1.0123456789;
select col1 from wl1612 where col1>4 and col3<1.0123456789;
select col1 from wl1612 where col1>4 and col3<=1.0123456789;
select col1 from wl1612 where col1>4 and col3>1.0123456789;
select col1 from wl1612 where col1>4 and col3>=1.0123456789;
select col1 from wl1612 where col1>4 and col3=1.012345679;
select col1 from wl1612 where col1>4 and col3<>1.012345679;
drop table wl1612;
select 1/3;
select 0.8=0.7+0.1;
select 0.7+0.1;
create table wl1612_1 (col1 int);
insert into wl1612_1 values(10);
select * from wl1612_1 where 0.8=0.7+0.1;
select 0.07+0.07 from wl1612_1;
select 0.07-0.07 from wl1612_1;
select 0.07*0.07 from wl1612_1;
select 0.07/0.07 from wl1612_1;
drop table wl1612_1;
create table wl1612_2 (col1 decimal(10,2), col2 numeric(10,2));
insert into wl1612_2 values(1,1);
insert into wl1612_2 values(+1,+1);
insert into wl1612_2 values(+01,+01);
insert into wl1612_2 values(+001,+001);
select col1,count(*) from wl1612_2 group by col1;
select col2,count(*) from wl1612_2 group by col2;
drop table wl1612_2;
create table wl1612_3 (col1 decimal(10,2), col2 numeric(10,2));
insert into wl1612_3 values('1','1');
insert into wl1612_3 values('+1','+1');
insert into wl1612_3 values('+01','+01');
insert into wl1612_3 values('+001','+001');
select col1,count(*) from wl1612_3 group by col1;
select col2,count(*) from wl1612_3 group by col2;
drop table wl1612_3;
select mod(234,10) ;
select mod(234.567,10.555);
select mod(-234.567,10.555);
select mod(234.567,-10.555);
select round(15.1);
select round(15.4);
select round(15.5);
select round(15.6);
select round(15.9);
select round(-15.1);
select round(-15.4);
select round(-15.5);
select round(-15.6);
select round(-15.9);
select round(15.1,1);
select round(15.4,1);
select round(15.5,1);
select round(15.6,1);
select round(15.9,1);
select round(-15.1,1);
select round(-15.4,1);
select round(-15.5,1);
select round(-15.6,1);
select round(-15.9,1);
select round(15.1,0);
select round(15.4,0);
select round(15.5,0);
select round(15.6,0);
select round(15.9,0);
select round(-15.1,0);
select round(-15.4,0);
select round(-15.5,0);
select round(-15.6,0);
select round(-15.9,0);
select round(15.1,-1);
select round(15.4,-1);
select round(15.5,-1);
select round(15.6,-1);
select round(15.9,-1);
select round(-15.1,-1);
select round(-15.4,-1);
select round(-15.5,-1);
select round(-15.6,-1);
select round(-15.91,-1);
select truncate(5678.123451,0);
select truncate(5678.123451,1);
select truncate(5678.123451,2);
select truncate(5678.123451,3);
select truncate(5678.123451,4);
select truncate(5678.123451,5);
select truncate(5678.123451,6);
select truncate(5678.123451,-1);
select truncate(5678.123451,-2);
select truncate(5678.123451,-3);
select truncate(5678.123451,-4);
select truncate(-5678.123451,0);
select truncate(-5678.123451,1);
select truncate(-5678.123451,2);
select truncate(-5678.123451,3);
select truncate(-5678.123451,4);
select truncate(-5678.123451,5);
select truncate(-5678.123451,6);
select truncate(-5678.123451,-1);
select truncate(-5678.123451,-2);
select truncate(-5678.123451,-3);
select truncate(-5678.123451,-4);
create table wl1612_4 (col1 int, col2 decimal(30,25), col3 numeric(30,25));
insert into wl1612_4 values(1,0.0123456789012345678912345,0.0123456789012345678912345);
select col2/9999999999 from wl1612_4 where col1=1;
select col3/9999999999 from wl1612_4 where col1=1;
select 9999999999/col2 from wl1612_4 where col1=1;
select 9999999999/col3 from wl1612_4 where col1=1;
select col2*9999999999 from wl1612_4 where col1=1;
select col3*9999999999 from wl1612_4 where col1=1;
insert into wl1612_4 values(2,55555.0123456789012345678912345,55555.0123456789012345678912345);
select col2/9999999999 from wl1612_4 where col1=2;
select col3/9999999999 from wl1612_4 where col1=2;
select 9999999999/col2 from wl1612_4 where col1=2;
select 9999999999/col3 from wl1612_4 where col1=2;
select col2*9999999999 from wl1612_4 where col1=2;
select col3*9999999999 from wl1612_4 where col1=2;
drop table wl1612_4;
set sql_mode='';
select 23.4 + (-41.7), 23.4 - (41.7) = -18.3;
select -18.3=-18.3;
select 18.3=18.3;
select -18.3=18.3;
select 0.8 = 0.7 + 0.1;

--
---- It should be possible to define a column
---- with up to 38 digits precision either before
---- or after the decimal point. Any number which
---- is inserted, if it's within the range, should
---- be exactly the same as the number that gets
---- selected.
--
drop table if exists t1;
create table t1 (col1 decimal(38));
insert into t1 values (12345678901234567890123456789012345678);
select * from t1;
--| col1                                   |
--+----------------------------------------+
--| 12345678901234567890123456789012345678 |
--+----------------------------------------+
--
--drop table t1;
--| col1                                     |
--+------------------------------------------+
--| 0.12345678901234567890123456789012345678 |
--+------------------------------------------+
--
drop table t1;
create table t1 (col1 decimal(31,30));
insert into t1 values (0.00000000001);
select * from t1;
--| 0.00000000001 |
--+---------------+
--
drop table t1;
select 7777777777777777777777777777777777777 * 10;
select .7777777777777777777777777777777777777 *
       1000000000000000000;
select .7777777777777777777777777777777777777 - 0.1;
select .343434343434343434 + .343434343434343434;
select abs(9999999999999999999999);
select abs(-9999999999999999999999);
select ceiling(999999999999999999);
select ceiling(99999999999999999999);
select ceiling(9.9999999999999999999);
select ceiling(-9.9999999999999999999);
select floor(999999999999999999);
select floor(9999999999999999999999);
select floor(9.999999999999999999999);
select floor(-9.999999999999999999999);
select floor(-999999999999999999999.999);
select ceiling(999999999999999999999.999);
select 99999999999999999999999999999999999999 mod 3;
select round(99999999999999999.999);
select round(-99999999999999999.999);
select round(99999999999999999.999,3);
select round(-99999999999999999.999,3);
select truncate(99999999999999999999999999999999999999,31);
select truncate(99.999999999999999999999999999999999999,31);
select truncate(99999999999999999999999999999999999999,-31);
--  declare v1 int default 1;
--  create table t1 (col1 decimal(0,38));
--  while v1 <= 10000 do 
--    insert into t1 values (-v2);
--    set v2 = v2 + 0.00000000000000000000000000000000000001;
--    set v1 = v1 + 1;
--  end while;
--  select avg(col1),sum(col1),count(col1) from t1;
--   -- avg(col1)=0.00000000000000000000000000000000000001 added 10,000 times, then divided by 10,000
--   -- sum(col1)=0.00000000000000000000000000000000000001 added 10,000 times
--
--   -- count(col1)=10000
--
--delimiter ;
--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
--show create table t1;
--| Table | Create Table                   |
--+-------+--------------------------------+
--| t9    | CREATE TABLE `t1` (            |
--|`s1` decimal(0,38) default NULL         |
--| ) ENGINE=MyISAM DEFAULT CHARSET=latin1 |
--+-------+--------------------------------+
--
--drop table t1;
create table t1 as select 0.5;
--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
show create table t1;
--| Table | Create Table                      |
--+-------+-----------------------------------+
--| t7 | CREATE TABLE `t1` (                  |
--| `0.5` decimal(3,1) NOT NULL default '0.0' |
--| ) ENGINE=MyISAM DEFAULT CHARSET=latin1    |
--+-------+-----------------------------------+
--
drop table t1;
select round(1.5),round(2.5);
--| round(1.5) | round(2.5) |
--+------------+------------+
--| 2          | 3          |
--+------------+------------+
--
---- From WL#1612, "The future", point 4.: "select 0.07 * 0.07;
select 0.07 * 0.07;
set sql_mode='traditional';
select 1E-500 = 0;
select 1 / 1E-500;
select 1 / 0;
--| 1 / 0 |
--+-------+
--| NULL  |
--+-------+
--1 row in set, 1 warning (0.00 sec)
--
---- From WL#1612 "The future" point 6.: Overflow is an error.
--
--set sql_mode='';
--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
--show create table t2;
--| Table | Create Table                    |
--+-------+---------------------------------+
--| t2    | CREATE TABLE `t2` (             |
--| `avg(col1)` decimal(17,4) default NULL, |
--| `avg(col2)` decimal(17,5) default NULL  |
--| ) ENGINE=MyISAM DEFAULT CHARSET=latin1  |
--+-------+---------------------------------+
--
--drop table t2;
--   leading "0"s.
--
--drop table if exists t1;
--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
--show create table t1;
--

--BUG#559  Maximum precision for DECIMAL column ...
--BUG#1499 INSERT/UPDATE into decimal field rounding problem
--BUG#1845 Not correctly recognising value for decimal field
--BUG#2493 Round function doesn't work correctly
--BUG#2649 round(0.5) gives 0 (should be 1)
--BUG#3612 impicite rounding of VARCHARS during aritchmetic operations...
--BUG#3722 SELECT fails for certain values in Double(255,10) column.
--BUG#4485 Floating point conversions are inconsistent
--BUG#4891 MATH
--BUG#5931 Out-of-range values are accepted
--BUG#6048 Stored procedure causes operating system reboot
--BUG#6053 DOUBLE PRECISION literal

-- Tests from 'traditional' mode tests
--
set sql_mode='ansi,traditional';
CREATE TABLE Sow6_2f (col1 NUMERIC(4,2));
INSERT INTO Sow6_2f VALUES (10.55);
INSERT INTO Sow6_2f VALUES (10.5555);
INSERT INTO Sow6_2f VALUES (-10.55);
INSERT INTO Sow6_2f VALUES (-10.5555);
INSERT INTO Sow6_2f VALUES (11);
INSERT INTO Sow6_2f VALUES (101.55);
UPDATE Sow6_2f SET col1 = col1 * 50 WHERE col1 = 11;
UPDATE Sow6_2f SET col1 = col1 / 0 WHERE col1 > 0;
SELECT MOD(col1,0) FROM Sow6_2f;
INSERT INTO Sow6_2f VALUES ('a59b');
drop table Sow6_2f;

--
-- bug#9501
--
select 10.3330000000000/12.34500000;

--
-- Bug #10404
--

set sql_mode='';
select 0/0;

--
-- bug #9546
--
select 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 as x;
select 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 + 1 as x;
select 0.190287977636363637 + 0.040372670 * 0 -  0;
select -0.123 * 0;

--
-- Bug #10232
--

CREATE TABLE t1 (f1 DECIMAL (12,9), f2 DECIMAL(2,2));
INSERT INTO t1 VALUES (10.5, 0);
UPDATE t1 SET f1 = 4.5;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (f1 DECIMAL (64,20), f2 DECIMAL(2,2));
INSERT INTO t1 VALUES (9999999999999999999999999999999999, 0);
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug #10599: problem with NULL
--

select abs(10/0);
select abs(NULL);

--
-- Bug #9894 (negative to unsigned column)
--
set @@sql_mode='traditional';
create table t1( d1 decimal(18) unsigned, d2 decimal(20) unsigned, d3 decimal (22) unsigned);
insert into t1 values(1,-1,-1);
drop table t1;
create table t1 (col1 decimal(5,2), col2 numeric(5,2));
insert into t1 values (999.999,999.999);
insert into t1 values (-999.999,-999.999);
select * from t1;
drop table t1;
set sql_mode='';

--
-- Bug #8425 (insufficient precision of the division)
--
set @sav_dpi= @@div_precision_increment;
set @@div_precision_increment=15;
create table t1 (col1 int, col2 decimal(30,25), col3 numeric(30,25));
insert into t1 values (1,0.0123456789012345678912345,0.0123456789012345678912345);
select col2/9999999999 from t1 where col1=1;
select 9999999999/col2 from t1 where col1=1;
select 77777777/7777777;
drop table t1;
set div_precision_increment= @sav_dpi;

--
-- Bug #10896 (0.00 > -0.00)
--
create table t1 (a decimal(4,2));
insert into t1 values (0.00);
select * from t1 where a > -0.00;
select * from t1 where a = -0.00;
drop table t1;

--
-- Bug #11215: a problem with LONGLONG_MIN
--

create table t1 (col1 bigint default -9223372036854775808);
insert into t1 values (default);
select * from t1;
drop table t1;

--
-- Bug #10891 (converting to decimal crashes server)
--
select cast('1.00000001335143196001808973960578441619873046875E-10' as decimal(30,15));

--
-- Bug #11708 (conversion to decimal fails in decimal part)
--
select ln(14000) c1, convert(ln(14000),decimal(5,3)) c2, cast(ln(14000) as decimal(5,3)) c3;
select convert(ln(14000),decimal(2,3)) c1;
select cast(ln(14000) as decimal(2,3)) c1;
 
--
-- Bug #8449 (Silent column changes)
--
--error 1426
create table t1 (sl decimal(70,30));
create table t1 (sl decimal(32,31));
create table t1 (sl decimal(0,38));
create table t1 (sl decimal(0,30));
create table t1 (sl decimal(5, 5));
drop table t1;
create table t1 (sl decimal(65, 30));
drop table t1;

--
-- Bug 11557 (DEFAULT values rounded improperly
--
create table t1 (
       f1 decimal unsigned not null default 17.49, 
       f2 decimal unsigned not null default 17.68, 
       f3 decimal unsigned not null default 99.2, 
       f4 decimal unsigned not null default 99.7, 
       f5 decimal unsigned not null default 104.49, 
       f6 decimal unsigned not null default 199.91, 
       f7 decimal unsigned not null default 999.9, 
       f8 decimal unsigned not null default 9999.99);
insert into t1 (f1) values (1);
select * from t1;
drop table t1;

--

--Replace default engine value with static engine string 
--replace_result $DEFAULT_ENGINE ENGINE
-- Bug 12173 (show create table fails)
--
create table t1 (
        f0 decimal (30,30) zerofill not null DEFAULT 0,
        f1 decimal (0,0) zerofill not null default 0);
drop table t1;

--
-- Bug 12938 (arithmetic loop's zero)
--
--disable_warnings
drop procedure if exists wg2;
create procedure wg2()
begin
  declare v int default 1;
    select v, tdec;
    set v = v + 1;
  end while;
drop procedure wg2;

--
-- Bug #12979 Stored procedures: crash if inout decimal parameter
-- (not a SP bug in fact)
--

select cast(@non_existing_user_var/2 as DECIMAL);

--
-- Bug #13667 (Inconsistency for decimal(m,d) specification
--
--error 1427
create table t (d decimal(0,10));

--
-- Bug #14268 (bad FLOAT->DECIMAL conversion)
--

CREATE TABLE t1 (
   my_float   FLOAT,
   my_double  DOUBLE,
   my_varchar VARCHAR(50),
   my_decimal DECIMAL(65,30)
);

let $max_power= 32;
{
   eval INSERT INTO t1 SET my_float = 1.175494345e-$max_power,
                           my_double = 1.175494345e-$max_power,
                           my_varchar = '1.175494345e-$max_power';
   dec $max_power;
SELECT my_float, my_double, my_varchar FROM t1;

-- The following statement produces results with garbage past
-- the significant digits. Improving it is a part of the WL#3977.
SELECT CAST(my_float   AS DECIMAL(65,30)), my_float FROM t1;
SELECT CAST(my_double  AS DECIMAL(65,30)), my_double FROM t1;
SELECT CAST(my_varchar AS DECIMAL(65,30)), my_varchar FROM t1;

-- We have to disable warnings here as the test in
-- Field_new_decimal::store(double):
-- if (nr2 != nr)
-- fails randomly depending on compiler options

--disable_warnings
UPDATE t1 SET my_decimal = my_float;

-- Expected result   0.000000000011754943372854760000
-- On windows we get 0.000000000011754943372854770000
-- use replace_result to correct it
--replace_result 0.000000000011754943372854770000 0.000000000011754943372854760000
SELECT my_decimal, my_float   FROM t1;

UPDATE t1 SET my_decimal = my_double;
SELECT my_decimal, my_double  FROM t1;
UPDATE t1 SET my_decimal = my_varchar;
SELECT my_decimal, my_varchar FROM t1;

DROP TABLE t1;

--
-- Bug #13573 (Wrong data inserted for too big values)
--

create table t1 (c1 decimal(64));
insert into t1 values(
89000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);
insert into t1 values(
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 *
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999);
insert into t1 values(1e100);
select * from t1;
drop table t1;

--
-- Bug #18014: problem with 'alter table'
--

create table t1(a decimal(7,2));
insert into t1 values(123.12);
select * from t1;
alter table t1 modify a decimal(10,2);
select * from t1;
drop table t1;

--
-- Bug#19667 group by a decimal expression yields wrong result
--
create table t1 (i int, j int);
insert into t1 values (1,1), (1,2), (2,3), (2,4);
select i, count(distinct j) from t1 group by i;
select i+0.0 as i2, count(distinct j) from t1 group by i2;
drop table t1;

create table t1(f1 decimal(20,6));
insert into t1 values (CAST('10:11:12' AS date) + interval 14 microsecond);
insert into t1 values (CAST('10:11:12' AS time));
select * from t1;
drop table t1;

--
-- Bug #8663 (cant use bigint as input to CAST)
--
select cast(19999999999999999999 as unsigned);

--
-- Bug #24558: Increasing decimal column length causes data loss
--
create table t1(a decimal(18));
insert into t1 values(123456789012345678);
alter table t1 modify column a decimal(19);
select * from t1;
drop table t1;

--
-- Bug #27957 cast as decimal does not check overflow, also inconsistent with group, subselect 
--

select cast(11.1234 as DECIMAL(3,2));
select * from (select cast(11.1234 as DECIMAL(3,2))) t;

select cast(a as DECIMAL(3,2))
 from (select 11.1233 as a
  UNION select 11.1234
  UNION select 12.1234
 ) t;
select cast(a as DECIMAL(3,2)), count(*)
 from (select 11.1233 as a
  UNION select 11.1234
  UNION select 12.1234
 ) t group by 1;

--
-- Bug #28361 Buffer overflow in DECIMAL code on Windows 
--

create table t1 (s varchar(100));
insert into t1 values (0.00000000010000000000000000364321973154977415791655470655996396089904010295867919921875);
drop table t1;

--
-- Bug #27984 Long Decimal Maths produces truncated results 
--

SELECT 1.000000000000 * 99.999999999998 / 100 a,1.000000000000 * (99.999999999998 / 100) b;

--
-- Bug #29415: CAST AS DECIMAL(P,S) with too big precision/scale 
--

SELECT CAST(1 AS decimal(65,10));
SELECT CAST(1 AS decimal(66,10));

SELECT CAST(1 AS decimal(65,30));
SELECT CAST(1 AS decimal(65,31));

CREATE TABLE t1 (a int DEFAULT NULL, b int DEFAULT NULL);
INSERT INTO t1 VALUES (3,30), (1,10), (2,10);
SELECT a+CAST(1 AS decimal(65,30)) AS aa, SUM(b) FROM t1 GROUP BY aa;
SELECT a+CAST(1 AS decimal(65,31)) AS aa, SUM(b) FROM t1 GROUP BY aa;

DROP TABLE t1;

--
-- Bug #29417: assertion abort for a grouping query with decimal user variable
--

CREATE TABLE t1 (a int DEFAULT NULL, b int DEFAULT NULL);
INSERT INTO t1 VALUES (3,30), (1,10), (2,10);

SET @a= CAST(1 AS decimal);
SELECT 1 FROM t1 GROUP BY @b := @a, @b;

DROP TABLE t1;

--
-- Bug #24907: unpredictable (display) precission, if input precission
--             increases
--

-- As per 10.1.1. Overview of Numeric Types, type (new) DECIMAL has a
-- maxmimum precision of 30 places after the decimal point. Show that
-- temp field creation beyond that works and throws a truncation warning.
-- DECIMAL(37,36) should be adjusted to DECIMAL(31,30).
CREATE TABLE t1 SELECT 0.123456789012345678901234567890123456 AS f1;
SELECT f1 FROM t1;
DROP TABLE t1;

-- too many decimal places, AND too many digits altogether (90 = 45+45).
-- should preserve integers (65 = 45+20)
CREATE TABLE t1 SELECT 123451234512345123451234512345123451234512345.678906789067890678906789067890678906789067890 AS f1;
SELECT f1 FROM t1;
DROP TABLE t1;

--
-- Bug #36270: incorrect calculation result - works in 4.1 but not in 5.0 or 5.1
--

-- show that if we need to truncate the scale of an operand, we pick the
-- right one (that is, we discard the least significant decimal places)
select (1.20396873 * 0.89550000 * 0.68000000 * 1.08721696 * 0.99500000 *
        1.01500000 * 1.01500000 * 0.99500000);

--
-- Bug #31616 div_precision_increment description looks wrong 
--

create table t1 as select 5.05 / 0.014;
select * from t1;
DROP TABLE t1;

let $nine_81=
999999999999999999999999999999999999999999999999999999999999999999999999999999999;
                     interval ((SELECT date_add((0x77500000),
                                                 interval ('Oml') second)))
                     day_minute)
AS foo;

--
-- Bug#16172 DECIMAL data type processed incorrectly
--
select cast(143.481 as decimal(4,1));
select cast(143.481 as decimal(4,0));
select cast(143.481 as decimal(2,1));
select cast(-3.4 as decimal(2,1));
select cast(99.6 as decimal(2,0));
select cast(-13.4 as decimal(2,1));
select cast(98.6 as decimal(2,0));

CREATE TABLE t1 SELECT .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT 1 + .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT 1 * .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT 1 / .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT 1 % .123456789123456789123456789123456789123456789123456789123456789123456789123456789 AS my_col;
SELECT my_col FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 SELECT
  /* 81 */ 100000000000000000000000000000000000000000000000000000000000000000000000000000001
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 81 */ 100000000000000000000000000000000000000000000000000000000000000000000000000000001.
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 81 */ 100000000000000000000000000000000000000000000000000000000000000000000000000000001.1 /* 1 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 82 */ 1000000000000000000000000000000000000000000000000000000000000000000000000000000001
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 40 */ 1000000000000000000000000000000000000001.1000000000000000000000000000000000000001 /* 40 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 1 */ 1.10000000000000000000000000000000000000000000000000000000000000000000000000000001 /* 80 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 1 */ 1.100000000000000000000000000000000000000000000000000000000000000000000000000000001 /* 81 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  .100000000000000000000000000000000000000000000000000000000000000000000000000000001 /* 81 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 45 */ 123456789012345678901234567890123456789012345.123456789012345678901234567890123456789012345 /* 45 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 65 */ 12345678901234567890123456789012345678901234567890123456789012345.1 /* 1 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  /* 66 */ 123456789012345678901234567890123456789012345678901234567890123456.1 /* 1 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT
  .123456789012345678901234567890123456789012345678901234567890123456 /* 66 */
  AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 AS SELECT 123.1234567890123456789012345678901 /* 31 */ AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 SELECT 1.1 + CAST(1 AS DECIMAL(65,30)) AS c1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (a DECIMAL(30,30));
INSERT INTO t1 VALUES (0.1),(0.2),(0.3);
CREATE TABLE t2 SELECT MIN(a + 0.0000000000000000000000000000001) AS c1 FROM t1;
DROP TABLE t1,t2;

CREATE TABLE t1 (a DECIMAL(30,30));
INSERT INTO t1 VALUES (0.1),(0.2),(0.3);
CREATE TABLE t2 SELECT IFNULL(a + 0.0000000000000000000000000000001, NULL) AS c1 FROM t1;
DROP TABLE t1,t2;

CREATE TABLE t1 (a DECIMAL(30,30));
INSERT INTO t1 VALUES (0.1),(0.2),(0.3);
CREATE TABLE t2 SELECT CASE a WHEN 0.1 THEN 0.0000000000000000000000000000000000000000000000000000000000000000001 END AS c1 FROM t1;
DROP TABLE t1,t2;

SET @decimal= 1.1;
CREATE TABLE t1 SELECT @decimal AS c1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 
SELECT .123456789012345678901234567890123456789012345678901234567890123456 AS a;
DROP TABLE t1;
CREATE PROCEDURE test_proc()
BEGIN
  -- The las non critical CUSER definition is:
  -- DECLARE mycursor CURSOR FOR SELECT 1 % 
  -- .12345678912345678912345678912345678912345678912345678912345678912 AS my_col;
SELECT 1 % 
.123456789123456789123456789123456789123456789123456789123456789123456789123456789 
  AS my_col;
DROP PROCEDURE test_proc;

CREATE TABLE currencies (id int, rate decimal(16,4), 
  PRIMARY KEY (id), KEY (rate));

INSERT INTO currencies VALUES (11,0.7028);
INSERT INTO currencies VALUES (1,1);

CREATE TABLE payments (
  id int,
  supplier_id int,
  status int,
  currency_id int,
  vat decimal(7,4),
  PRIMARY KEY (id),
  KEY currency_id (currency_id),
  KEY supplier_id (supplier_id)
);

INSERT INTO payments (id,status,vat,supplier_id,currency_id) VALUES
(3001,2,0.0000,344,11), (1,2,0.0000,1,1);

CREATE TABLE sub_tasks (
  id int,
  currency_id int,
  price decimal(16,4),
  discount decimal(10,4),
  payment_id int,
  PRIMARY KEY (id),
  KEY currency_id (currency_id),
  KEY payment_id (payment_id)
) ;

INSERT INTO sub_tasks (id, price, discount, payment_id, currency_id) VALUES
(52, 12.60, 0, 3001, 11), (56, 14.58, 0, 3001, 11);
select STRAIGHT_JOIN
  (1 + PAY.vat) AS mult,
  SUM(ROUND((SUB.price - ROUND(ROUND(SUB.price, 2) * SUB.discount, 2)) * 
            CUR.rate / CUR.rate, 2)
  ) v_net_with_discount,

  SUM(ROUND((SUB.price - ROUND(ROUND(SUB.price, 2) * SUB.discount, 1)) *
            CUR.rate / CUR.rate , 2) 
      * (1 + PAY.vat)
  ) v_total
from
   currencies CUR, payments PAY, sub_tasks SUB
where
  SUB.payment_id = PAY.id and
  PAY.currency_id = CUR.id and
  PAY.id > 2
group by PAY.id + 1;

DROP TABLE currencies, payments, sub_tasks;

CREATE TABLE t1 (a DECIMAL(4,4) UNSIGNED);
INSERT INTO t1 VALUES (0);
SELECT AVG(DISTINCT a) FROM t1;
SELECT SUM(DISTINCT a) FROM t1;
DROP TABLE t1;

CREATE TABLE t1(d1 DECIMAL(60,0) NOT NULL,
                d2 DECIMAL(60,0) NOT NULL);

INSERT INTO t1 (d1, d2) VALUES(0.0, 0.0);
SELECT d1 * d2 FROM t1;

DROP TABLE t1;
CREATE TABLE t1 (a DECIMAL(20,3) NOT NULL);
INSERT INTO t1 VALUES (20000716055804.035);
INSERT INTO t1 VALUES (20080821000000.000);
INSERT INTO t1 VALUES (0);
SELECT GREATEST(a, 1323) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (b INT, KEY(b));

INSERT INTO t1 VALUES (1),(2);
UPDATE  IGNORE t1 SET b = 1
WHERE b NOT IN (NULL, -3333333333333333333333);

DROP TABLE t1;

CREATE TABLE t1(b INT, KEY(b));
INSERT INTO t1 VALUES (0);
SELECT 1 FROM t1 WHERE b NOT IN (0.1,-0.1);
DROP TABLE t1;

CREATE TABLE t1(
a DECIMAL(25,20) UNSIGNED, KEY(a)
);

INSERT INTO t1 VALUES (1), (NULL);

SELECT a FROM t1 GROUP BY 1 IN(1) INTO @b;
DROP TABLE t1;

SET sql_mode = default;

CREATE TABLE t (id SERIAL, d DECIMAL(65,30));
INSERT INTO t VALUES (),(),(),(),(),(),(),(),();
INSERT INTO t VALUES (),(),(),(),(),(),(),(),();
INSERT INTO t VALUES (),(),(),(),(),(),(),(),();
UPDATE t SET d = CONCAT('1e-', id);
SELECT d, d MOD 1 FROM t;
DROP TABLE t;

CREATE TABLE t1(value DECIMAL(24,0) NOT NULL);
INSERT INTO t1(value) 
VALUES('100000000000000000000001'),
      ('100000000000000000000002'), 
      ('100000000000000000000003');
SELECT * FROM t1 WHERE value = '100000000000000000000002';
SELECT * FROM t1 WHERE '100000000000000000000002' = value;
SELECT * FROM t1 WHERE value + 0 = '100000000000000000000002';
SELECT * FROM t1 WHERE value = 100000000000000000000002;
SELECT * FROM t1 WHERE value + 0 = 100000000000000000000002;
set @a="100000000000000000000002";
set @a=100000000000000000000002;

ALTER TABLE t1 ADD INDEX value (value);
SELECT * FROM t1 WHERE value = '100000000000000000000002';
DROP TABLE t1;

SELECT CAST(-0.0e0 AS DECIMAL) = 0;

SET sql_mode="";
CREATE TABLE t1(a time);
INSERT INTO t1 VALUES('00:00:01');

SELECT 1 FROM t1 WHERE EXISTS
(SELECT 1 FROM t1 HAVING (a / -7777777777) in ("a"));
DROP TABLE t1;
SET sql_mode=default;

CREATE TABLE t1 (
  d decimal(18,2) unsigned DEFAULT NULL,
  i int unsigned DEFAULT NULL
)
SELECT
1000 AS d,
3 AS i;

SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t(a DECIMAL(56,13) NOT NULL);
INSERT INTO t VALUES(0);
SELECT 1 FROM t WHERE a<=>time('-t');
DROP TABLE t;

select maketime(1,1.1,1);

CREATE TABLE t1
(
  f1 INT(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT INTO t1 VALUES (1), (2);


CREATE TABLE t2
(
  f1 SMALLINT(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT INTO t2 VALUES (84), (126), (36), (36);

SELECT DISTINCT q1.f1 / 3 FROM (SELECT SUM(f1) AS f1 FROM t2  ) q1, (SELECT 0 FROM t1) q2;
SELECT DISTINCT q1.f1 / 3 FROM (SELECT SUM(f1) AS f1 FROM t2  ) q1;

DROP TABLE t1, t2;

CREATE TABLE t1(a INT UNSIGNED, b DECIMAL(10,2) UNSIGNED);
INSERT INTO t1 VALUES (2015, 123456.78);

CREATE TABLE t2(a INT UNSIGNED, b INT UNSIGNED);
INSERT INTO t2 VALUES (2015, 123456);

CREATE TABLE t3(a DECIMAL(10,2) UNSIGNED, b DECIMAL(10,2) UNSIGNED);
INSERT INTO t3 VALUES (2015, 123456);
SELECT a - b FROM t1;
SELECT a - b FROM t2;
SELECT a - b FROM t3;

SET sql_mode=NO_UNSIGNED_SUBTRACTION;
SELECT a - b FROM t1;
SELECT a - b FROM t2;
SELECT a - b FROM t3;

DROP TABLE t1, t2, t3;
SET sql_mode=DEFAULT;

SET sql_mode="";
CREATE TABLE t(
  a YEAR NOT NULL,
  b DECIMAL(29,5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=INNODB;
INSERT INTO t VALUES (2000,1),(2000,1),(2000,9999);
SELECT * FROM t ORDER BY (a-b);
DROP TABLE t;
SET sql_mode= DEFAULT;

CREATE TABLE t1(a DATETIME(4));
INSERT INTO t1 VALUES(NOW()),(NOW()),(NOW()),(NOW()),(NOW());
SELECT SQL_BUFFER_RESULT JSON_OBJECT('a', a MOD 1) FROM t1;
DROP TABLE t1;
SELECT -1 DIV LEAST(1,JSON_INSERT(1, '$[1]','','',''));
SELECT -1 DIV LEAST(1, JSON_EXTRACT('1', '$.abc'));

SELECT 1.056448745601382294204817708678199647327125723403005048300399553 *
CAST(0.996 AS DECIMAL(14,3)) AS RESULT;
SELECT 1.0564487456013822942048177086781996473271257234030050483003995531 *
CAST(0.996 AS DECIMAL(14,3)) AS RESULT;

SELECT CAST(0.996 AS DECIMAL(14,3)) *
1.056448745601382294204817708678199647327125723403005048300399553 AS RESULT;
SELECT CAST(0.996 AS DECIMAL(14,3)) *
1.0564487456013822942048177086781996473271257234030050483003995531 AS RESULT;

CREATE TABLE t2 (i DECIMAL (30,27));
INSERT INTO t2 VALUES (6.8926822182388193469056146);
DROP TABLE t2;

SET sql_mode="";
CREATE TABLE t (a int);
INSERT INTO t() VALUES(),(),(),();
SELECT
lag(1,96,
-66812354762147309124165421419678600705366236356475480.892682218238819346905614650696)
over()
FROM t;

DROP TABLE t;
SET sql_mode = default;

CREATE TABLE t1(a DECIMAL(10,0));
INSERT INTO t1 VALUES(0);
SELECT * FROM t1 AS alias1 NATURAL JOIN t1 AS alias2;
DROP TABLE t1;

CREATE TABLE t(a DECIMAL(10,4));
INSERT INTO t VALUES(-1),(1),(100);
SET @d:=' ';
  SELECT a AS a1 FROM  t
),
cte2 AS (
  SELECT (0xfa > @d) AS a2 FROM t
)
SELECT cte1.a1
FROM cte1,cte2
WHERE cte1.a1 >= cte2.a2;
DROP TABLE t;

CREATE TABLE t(a DECIMAL(14,14) DEFAULT NULL);
INSERT INTO t VALUES
 (-0.99999999999999), (-0.99999999999999), (0.15610000000000);
SELECT WEIGHT_STRING(TRUNCATE((SELECT a FROM t), -17410));
DROP TABLE t;

SET sql_mode=default;

-- Hypergraph optimizer has different warnings.
--disable_warnings

SELECT 1.0 div (@a:='xx');

SELECT 1.0 div (@a:='1xx');

CREATE TABLE t1 (a DECIMAL(10,0), b DECIMAL(10,0), KEY(a)) ENGINE=INNODB;
INSERT INTO t1 VALUES (0,0),(1,1);

SELECT a FROM t1 FORCE INDEX(a) WHERE a='m';
SELECT a FROM t1 FORCE INDEX(a) WHERE a=CONCAT('m');
SELECT a FROM t1 FORCE INDEX(a) WHERE a=COALESCE('m');

SELECT * FROM t1 WHERE b='m';

SELECT * FROM t1 WHERE b=CONCAT('m');

SELECT * FROM t1 WHERE b=COALESCE('m');

SELECT a FROM t1 FORCE INDEX(a) WHERE a='';
SELECT a FROM t1 FORCE INDEX(a) WHERE a=CONCAT('');
SELECT a FROM t1 FORCE INDEX(a) WHERE a=COALESCE('');

SELECT * FROM t1 WHERE b='';

SELECT * FROM t1 WHERE b=CONCAT('');

SELECT * FROM t1 WHERE b=COALESCE('');
CREATE TEMPORARY TABLE tt1 AS SELECT * FROM t1 FORCE INDEX(a) WHERE a='m';
CREATE TEMPORARY TABLE tt1 AS SELECT * FROM t1 FORCE INDEX(a) WHERE a=CONCAT('m');
CREATE TEMPORARY TABLE tt1 AS SELECT * FROM t1 FORCE INDEX(a) WHERE a=COALESCE('m');
CREATE TEMPORARY TABLE tt1 AS SELECT * FROM t1 WHERE b='m';
CREATE TEMPORARY TABLE tt1 AS SELECT * FROM t1 WHERE b=CONCAT('m');
CREATE TEMPORARY TABLE tt1 AS SELECT * FROM t1 WHERE b=COALESCE('m');

CREATE TABLE t2 (a char(10), b varchar(10));
INSERT INTO t2 VALUES('x1 y ', 'x1 y ');

-- Just 'x1 y' in warning, since 'a' is CHAR.
SELECT maketime(1, 2, a) FROM t2;

-- Traling space in warning, since 'b' is VARCHAR.
SELECT maketime(1, 2, b) FROM t2;

DROP TABLE t1, t2;

CREATE TABLE t1 (d DECIMAL(20,10));
INSERT INTO t1 VALUES (93.33);

-- Leading zeros yielded E_DEC_OVERFLOW
SELECT * FROM t1 WHERE
d<0000000000000000000000000000000000000000000000000000000000000000000000000000000020.01
;
SELECT * FROM t1 WHERE
d>0000000000000000000000000000000000000000000000000000000000000000000000000000000020.01
;

-- Leading zeros gave an assert during constant folding.
SELECT * FROM t1 WHERE
d<000000000000000000000000000000000000000000000000000000000000000000000000000000000.01
;
SELECT * FROM t1 WHERE
d>000000000000000000000000000000000000000000000000000000000000000000000000000000000.01
;

DROP TABLE t1;
