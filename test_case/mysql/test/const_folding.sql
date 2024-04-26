--

let $dec_0_5=0.5;
let $dec_minus_0_5=-0.5;
let $dec_too_big_positive_for_any_int=18446744073709551615.00000001;
let $dec_too_big_negative_for_any_int=-9223372036854775808.00000001;

let $real_0_5=0.5E00;
let $real_minus_0_5=-0.5E00;
let $real_too_big_positive_for_any_int=18446744073709551615.00000001E+00;
let $real_dec_too_big_negative_for_any_int=-9223372036854775808.00000001E+00;
let $real_too_big_positive_for_any_decimal=1.7976931348623157E+308;
let $real_too_big_negative_for_any_decimal=-1.7976931348623157E+308;
let $real_too_small_positive_for_any_decimal=1.7976931348623157E-308;
let $real_too_small_negative_for_any_decimal=-1.7976931348623157E-308;

--
-- T I N Y I N T
--
let $int_type=TINYINT;
let $table_name=tinytbl;

let $minint=0;
let $minint_plus_1=1;
let $minint_minus_1=-1;
let $maxint=255;
let $maxint_plus_1=256;
let $maxint_minus_1=254;
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;

let $dec_max_plus_delta=255.00001;
let $dec_max_minus_delta=254.99999;
let $dec_min_plus_delta=0.00001;
let $dec_min_minus_delta=-0.99999;

-- Try with strings instead of ints - should see same result since
-- strings are folded to ints in int context. Do it only for tiny and
-- bigint to avoid test bloat.
let $minint='0';
let $minint_plus_1='1';
let $minint_minus_1='-1';
let $maxint='255';
let $maxint_plus_1='256';
let $maxint_minus_1='254';
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;

-- Try with strings containing decimals

let $minint='0.0';
let $minint_plus_1='1.0';
let $minint_minus_1='-1.1';
let $maxint='255.0';
let $maxint_plus_1='256.1';
let $maxint_minus_1='254.0';
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;
let $dec_max_plus_delta='255.00001';
let $dec_max_minus_delta='254.99999';
let $dec_min_plus_delta='0.00001';
let $dec_min_minus_delta='-0.99999';

-- Try with reals
let $minint=0.0E+00;
let $minint_plus_1=1.0E00;
let $minint_minus_1=-1.0E00;
let $maxint=2.55E02;
let $maxint_plus_1=2.56E02;
let $maxint_minus_1=2.54E02;
let $real_max_plus_delta=255.00001E+00;
let $real_max_minus_delta=254.99999E+00;
let $real_min_plus_delta=0.00001E+00;
let $real_min_minus_delta=-0.99999E+00;


let $nullness=NOT NULL;
let $nullval=0;

let $table_name=tinytbls;
let $minint=-128;
let $minint_plus_1=-127;
let $minint_minus_1=-129;
let $maxint=127;
let $maxint_plus_1=128;
let $maxint_minus_1=126;
let $signedness=;
let $nullness=;
let $nullval=NULL;

let $dec_max_plus_delta=127.00001;
let $dec_max_minus_delta=126.99999;
let $dec_min_plus_delta=-127.99999;
let $dec_min_minus_delta=-128.00001;
let $nullness=NOT NULL;
let $nullval=0;

--
-- S M A L L I N T
--
let $int_type=SMALLINT;
let $table_name=smalltbl;

let $minint=0;
let $minint_plus_1=1;
let $minint_minus_1=-1;
let $maxint=65535;
let $maxint_plus_1=65536;
let $maxint_minus_1=65534;
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;

let $dec_0_5=0.5;
let $dec_minus_0_5=-0.5;
let $dec_max_plus_delta=65535.00001;
let $dec_max_minus_delta=65534.99999;
let $dec_min_plus_delta=0.00001;
let $dec_min_minus_delta=-0.99999;
let $nullness=NOT NULL;
let $nullval=0;

let $table_name=smalltbls;
let $minint=-32768;
let $minint_plus_1=-32767;
let $minint_minus_1=-32769;
let $maxint=32767;
let $maxint_plus_1=32768;
let $maxint_minus_1=32766;
let $signedness=;
let $nullness=;
let $nullval=NULL;

let $dec_max_plus_delta=32767.00001;
let $dec_max_minus_delta=32766.99999;
let $dec_min_plus_delta=-32767.99999;
let $dec_min_minus_delta=-32768.00001;
let $nullness=NOT NULL;
let $nullval=0;

--
-- M E D I U M I N T
--
let $int_type=MEDIUMINT;
let $table_name=mediumtbl;

let $minint=0;
let $minint_plus_1=1;
let $minint_minus_1=-1;
let $maxint=16777215;
let $maxint_plus_1=16777216;
let $maxint_minus_1=16777214;
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;
let $nullness=NOT NULL;
let $nullval=0;

let $table_name=mediumtbls;
let $minint=-8388608;
let $minint_plus_1=-8388607;
let $minint_minus_1=-8388609;
let $maxint=8388607;
let $maxint_plus_1=8388608;
let $maxint_minus_1=8388606;
let $signedness=;
let $nullness=;
let $nullval=NULL;
let $nullness=NOT NULL;
let $nullval=0;

--
-- I N T
--
let $int_type=INT;
let $table_name=inttbl;

let $minint=0;
let $minint_plus_1=1;
let $minint_minus_1=-1;
let $maxint=4294967295;
let $maxint_plus_1=4294967296;
let $maxint_minus_1=4294967294;
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;
let $nullness=NOT NULL;
let $nullval=0;

let $table_name=inttbls;
let $minint=-2147483648;
let $minint_plus_1=-2147483647;
let $minint_minus_1=-2147483649;
let $maxint=2147483647;
let $maxint_plus_1=2147483648;
let $maxint_minus_1=2147483646;
let $signedness=;
let $nullness=;
let $nullval=NULL;
let $nullness=NOT NULL;
let $nullval=0;

--
-- B I G I N T
--
let $int_type=BIGINT;
let $table_name=inttbl;

let $minint=0;
let $minint_plus_1=1;
let $minint_minus_1=-1;
let $maxint=18446744073709551615;
let $maxint_plus_1=18446744073709551616;
let $maxint_minus_1=18446744073709551614;
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;

let $dec_0_5=0.5;
let $dec_minus_0_5=-0.5;
let $dec_max_plus_delta=18446744073709551615.00001;
let $dec_max_minus_delta=18446744073709551614.99999;
let $dec_min_plus_delta=0.00001;
let $dec_min_minus_delta=-0.99999;

-- Try with string constants instead, cf. comment in TINYINT section
let $minint='0';
let $minint_plus_1='1';
let $minint_minus_1='-1';
let $maxint='18446744073709551615';
let $maxint_plus_1='18446744073709551616';
let $maxint_minus_1='18446744073709551614';


let $nullness=NOT NULL;
let $nullval=0;

-- Try with strings containing decimals

let $minint='0.0';
let $minint_plus_1='1.0';
let $minint_minus_1='-1.1';
let $maxint='18446744073709551615.0';
let $maxint_plus_1='18446744073709551616.1';
let $maxint_minus_1='18446744073709551614.0';
let $signedness=UNSIGNED;
let $nullness=;
let $nullval=NULL;
let $dec_max_plus_delta='18446744073709551615.00001';
let $dec_max_minus_delta='18446744073709551614.99999';
let $dec_min_plus_delta='0.00001';
let $dec_min_minus_delta='-0.99999';

let $table_name=inttbls;
let $minint=-9223372036854775808;
let $minint_plus_1=-9223372036854775807;
let $minint_minus_1=-9223372036854775809;
let $maxint=9223372036854775807;
let $maxint_plus_1=9223372036854775808;
let $maxint_minus_1=9223372036854775806;
let $signedness=;
let $nullness=;
let $nullval=NULL;
let $nullness=NOT NULL;
let $nullval=0;

--
-- Folding inside function arguments, including nullability handling
--
CREATE TABLE t(u TINYINT UNSIGNED);
INSERT INTO t VALUES (0), (3), (255), (NULL);

SELECT * FROM t WHERE u=256 IS NOT NULL;
SELECT * FROM t WHERE u=256 IS NULL;
SELECT * FROM t WHERE u=256 IS UNKNOWN;
SELECT * FROM t WHERE ABS(u=256)=0;
SELECT * FROM t WHERE u=256;
drop table t;

CREATE TABLE t(u TINYINT UNSIGNED NOT NULL);
INSERT INTO t VALUES (0), (3), (255);

SELECT * FROM t WHERE u=256 IS NOT NULL;
SELECT * FROM t WHERE u=256 IS NULL;
SELECT * FROM t WHERE u=256 IS UNKNOWN;
SELECT * FROM t WHERE ABS(u=256)=0;
SELECT * FROM t WHERE u=256;
DROP TABLE t;
CREATE TABLE t1(i TINYINT);
CREATE TABLE t2(i INT);
CREATE TABLE t3(i INT);

INSERT INTO t1 VALUES (127);
INSERT INTO t2 VALUES (128);
INSERT INTO t3 VALUES (128);
--     /--> t2
--    /
--  t1
--    \
--     \--> t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t1.i=t2.i AND t1.i=t3.i AND t1.i=128;
--     /-<- t2
--    /
--  t1
--    \
--     \--> t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t2.i=t1.i AND t1.i=t3.i AND t1.i=128;
--     /--> t2
--    /
--  t1
--    \
--     \-<- t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t1.i=t2.i AND t3.i=t1.i AND t1.i=128;
--     /-<- t2
--    /
--  t1
--    \
--     \-<- t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t2.i=t1.i AND t3.i=t1.i AND t1.i=128;
--            t2
--            |
--  t1--\     |
--       \    V
--        \-> t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t1.i=t3.i AND t2.i=t3.i AND t1.i=128;
--            t2
--            ^
--  t1--\     |
--       \    |
--        \-> t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t1.i=t3.i AND t3.i=t2.i AND t1.i=128;
--            t2
--            |
--  t1<-\     |
--       \    V
--        \-- t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t3.i=t1.i AND t2.i=t3.i AND t1.i=128;
--            t2
--            ^
--  t1<-\     |
--       \    |
--        \-- t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t3.i=t1.i AND t3.i=t2.i AND t1.i=128;
--     /----> t2
--    /       ^
--  t1        |
--            |
--            t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t1.i=t2.i AND t3.i=t2.i AND t1.i=128;
--     /-<--- t2
--    /       ^
--  t1        |
--            |
--            t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t2.i=t1.i AND t3.i=t2.i AND t1.i=128;
--     /-<--- t2
--    /       |
--  t1        |
--            V
--            t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t2.i=t1.i AND t2.i=t3.i AND t1.i=128;
--     /----> t2
--    /       |
--  t1        |
--            V
--            t3
--
--echo
EXPLAIN SELECT * FROM t1,t2,t3 WHERE t1.i=t2.i AND t2.i=t3.i AND t1.i=128;

DROP TABLES t1, t2, t3;

-- PART II
--
-- Test of rewriting comparison of a decimal field and a constant
-- (decimal, int, string, real).

let $nullness=;
let $nullval=NULL;

let $nullness=NOT NULL;
let $nullval=0;

let $nullness=;
let $nullval=NULL;

let $nullness=NOT NULL;
let $nullval=0;

let $nullness=;
let $nullval=NULL;

let $nullness=NOT NULL;
let $nullval=0;
CREATE TABLE t(i INT NOT NULL);
SELECT * FROM t WHERE i IS NOT NULL;

INSERT INTO t VALUES (3), (4);
SELECT * FROM t WHERE i IS NOT NULL;
DROP TABLE t;
CREATE TABLE t(i TINYINT NOT NULL);
INSERT INTO t VALUES (10),(100),(1),(0);
let query=SELECT * FROM t WHERE i = (i < 255);

DROP TABLE t;

CREATE TABLE t(i TINYINT);
INSERT INTO t VALUES (10),(100),(1),(0),(NULL);
let query=SELECT * FROM t WHERE i = (i < 255);
let query=SELECT * FROM t WHERE 1 = (i < 255);
let query=SELECT * FROM t WHERE 0 = (i < 255);

DROP TABLE t;

-- Missing coverage for too large (for decimal) double constants, add here:
CREATE TABLE t(d DECIMAL(65,0));
DROP TABLE t;

-- PART III
--
-- Test of rewriting comparison of a real field and a constant
-- (decimal, int, string, real).

--
-- F L O A T  (5,2)
--
let $real_type=FLOAT(5,2);
let $table_name=float_5_2_tbl;

let $minreal=-999.99;
let $minreal_plus_delta_round_down=-999.984;
let $minreal_plus_delta_round_up=-999.985;
let $minreal_minus_delta_round_down=-999.995;
let $minreal_minus_delta_round_up=-999.994;
let $maxreal=999.99;
let $maxreal_minus_delta_round_down=999.984;
let $maxreal_minus_delta_round_up=999.985;
let $maxreal_plus_delta_round_down=999.994;
let $maxreal_plus_delta_round_up=999.995;


let $signedness=;
let $nullness=;
let $nullval=NULL;

-- Use string constants
let $minreal='-999.99';
let $minreal_plus_delta_round_down='-999.984';
let $minreal_plus_delta_round_up='-999.985';
let $minreal_minus_delta_round_down='-999.995';
let $minreal_minus_delta_round_up='-999.994';
let $maxreal='999.99';
let $maxreal_minus_delta_round_down='999.984';
let $maxreal_minus_delta_round_up='999.985';
let $maxreal_plus_delta_round_down='999.994';
let $maxreal_plus_delta_round_up='999.995';

let $signedness=UNSIGNED;
let $minreal=0.0;
let $minreal_plus_delta_round_down=0.004;
let $minreal_plus_delta_round_up=0.005;
let $minreal_minus_delta_round_down=0.0;
let $minreal_minus_delta_round_up=0.0;

--
-- F L O A T
--
let $signedness=;
let $real_type=FLOAT;
let $table_name=float_tbl;

let $minreal=-3.4028234663852886e+38;
let $minreal_plus_delta_round_down=-3.4028234663852886e+38;
let $minreal_plus_delta_round_up=-3.4028234663852886e+38;
let $minreal_minus_delta_round_down=-3.402823466385288E+38;
let $minreal_minus_delta_round_up=-3.402823466385288E+38;
let $maxreal=3.402823466E+38;
let $maxreal_minus_delta_round_down=3.4028234663852886e+38;
let $maxreal_minus_delta_round_up=3.4028234663852886e+38;
let $maxreal_plus_delta_round_down=3.402823466385288E+38;
let $maxreal_plus_delta_round_up=3.402823466385288E+38;

--
-- D O U B L E  (5,2)
--
let $real_type=DOUBLE(5,2);
let $table_name=double_5_2_tbl;

let $minreal=-999.99;
let $minreal_plus_delta_round_down=-999.984;
let $minreal_plus_delta_round_up=-999.985;
let $minreal_minus_delta_round_down=-999.995;
let $minreal_minus_delta_round_up=-999.994;
let $maxreal=999.99;
let $maxreal_minus_delta_round_down=999.984;
let $maxreal_minus_delta_round_up=999.985;
let $maxreal_plus_delta_round_down=999.994;
let $maxreal_plus_delta_round_up=999.995;


let $signedness=;
let $nullness=;
let $nullval=NULL;

--
-- D O U B L E
--
-- We don't do folding real constants when we have a DOUBLE type,
-- since any range error is caught at parse time, but include test
-- for completeness and to verify we don't change semantics.
--
let $signedness=;
let $real_type=DOUBLE;
let $table_name=double_tbl;

let $minreal=-1.7976931348623157E+308;
let $minreal_plus_delta_round_down=-1.7976931348623156E+308;
let $minreal_plus_delta_round_up=-1.7976931348623156E+308;
let $minreal_minus_delta_round_down=-1.7976931348623157E+308;
let $minreal_minus_delta_round_up=-1.7976931348623157E+308;

let $maxreal=1.7976931348623157E+308;
let $maxreal_minus_delta_round_down=1.7976931348623156E+308;
let $maxreal_minus_delta_round_up=1.7976931348623156E+308;
let $maxreal_plus_delta_round_down=1.7976931348623157E+308;
let $maxreal_plus_delta_round_up=1.7976931348623157E+308;

-- Use string constants
let $minreal='-1.7976931348623157E+308';
let $minreal_plus_delta_round_down='-1.7976931348623156E+308';
let $minreal_plus_delta_round_up='-1.7976931348623156E+308';
let $minreal_minus_delta_round_down='-1.7976931348623157E+308';
let $minreal_minus_delta_round_up='-1.7976931348623157E+308';

let $maxreal='1.7976931348623157E+308';
let $maxreal_minus_delta_round_down='1.7976931348623156E+308';
let $maxreal_minus_delta_round_up='1.7976931348623156E+308';
let $maxreal_plus_delta_round_down='1.7976931348623157E+308';
let $maxreal_plus_delta_round_up='1.7976931348623157E+308';

-- Lastly, integral and decimal constants
--source include/const_folding_real_decimal.inc

-- PART IV
--
-- Test of rewriting comparison of a YEAR field and a constant
-- (decimal, int, string, real).
--
--

--echo --  I N T  constant
let $table_name=tbl_year;
let $nullness=;
let $zero=0;
let $zero_minus_delta=-1;
let $zero_plus_delta=1;
let $in_hole=300;
let $min_minus_delta=1900;
let $min=1901;
let $min_plus_delta=1902;
let $inside=2018;
let $max_minus_delta=2154;
let $max=2155;
let $max_plus_delta=2156;
let $zero=0;
let $zero_minus_delta=-1;
let $zero_plus_delta=1;
let $in_hole=300;
let $min_minus_delta=1900;
let $min=01;
let $min_plus_delta=02;
let $inside=18;
let $max_minus_delta=2154;
let $max=2155;
let $max_plus_delta=2156;
let $zero=0.0;
let $zero_minus_delta=-1.0;
let $zero_plus_delta=1.0;
let $in_hole=300.0;
let $min_minus_delta=1900.0;
let $min=1901.0;
let $min_plus_delta=1902.0;
let $inside=2018.0;
let $max_minus_delta=2154.0;
let $max=2155.0;
let $max_plus_delta=2156.0;
let $zero=0.1;
let $zero_minus_delta=-1.1;
let $zero_plus_delta=1.1;
let $in_hole=300.1;
let $min_minus_delta=1900.1;
let $min=1901.1;
let $min_plus_delta=1902.1;
let $inside=2018.1;
let $max_minus_delta=2154.1;
let $max=2155.1;
let $max_plus_delta=2156.1;

let $zero=0.9;
let $zero_minus_delta=-1.9;
let $zero_plus_delta=1.9;
let $in_hole=300.9;
let $min_minus_delta=1900.9;
let $min=1901.9;
let $min_plus_delta=1902.9;
let $inside=2018.9;
let $max_minus_delta=2154.9;
let $max=2155.9;
let $max_plus_delta=2156.9;
let $zero=0.0E00;
let $zero_minus_delta=-1.0E00;
let $zero_plus_delta=1.0E00;
let $in_hole=300.0E00;
let $min_minus_delta=1900.0E00;
let $min=1901.0E00;
let $min_plus_delta=1902.0E00;
let $inside=2018.0E00;
let $max_minus_delta=2154.0E00;
let $max=2155.0E00;
let $max_plus_delta=2156.0E00;
let $zero=0.1E00;
let $zero_minus_delta=-1.1E00;
let $zero_plus_delta=1.1E00;
let $in_hole=300.1E00;
let $min_minus_delta=1900.1E00;
let $min=1901.1E00;
let $min_plus_delta=1902.1E00;
let $inside=2018.1E00;
let $max_minus_delta=2154.1E00;
let $max=2155.1E00;
let $max_plus_delta=2156.1E00;
let $zero='0';
let $zero_minus_delta='-1';
let $zero_plus_delta='1';
let $in_hole='300';
let $min_minus_delta='1900';
let $min='1901';
let $min_plus_delta='1902';
let $inside='2018';
let $max_minus_delta='2154';
let $max='2155';
let $max_plus_delta='2156';
let $zero='0';
let $zero_minus_delta='-1';
let $zero_plus_delta='1';
let $in_hole='300';
let $min_minus_delta='1900';
let $min='01';
let $min_plus_delta='02';
let $inside='18';
let $max_minus_delta='2154';
let $max='2155';
let $max_plus_delta='2156';
let $zero='0.0';
let $zero_minus_delta='-1.0';
let $zero_plus_delta='1.0';
let $in_hole='300.0';
let $min_minus_delta='1900.0';
let $min='1901.0';
let $min_plus_delta='1902.0';
let $inside='2018.0';
let $max_minus_delta='2154.0';
let $max='2155.0';
let $max_plus_delta='2156.0';
let $zero='0.0E00';
let $zero_minus_delta='-1.0E00';
let $zero_plus_delta='1.0E00';
let $in_hole='300.0E00';
let $min_minus_delta='1900.0E00';
let $min='1901.0E00';
let $min_plus_delta='1902.0E00';
let $inside='2018.0E00';
let $max_minus_delta='2154.0E00';
let $max='2155.0E00';
let $max_plus_delta='2156.0E00';

-- PART V
--
-- Test of rewriting comparison of a TIMESTAMP[(dec)] field and a
-- constant (decimal, int, string, real).
--
--

let $table_name=tbl_ts;
let $ts_type=TIMESTAMP;
let $decimals=;
let $nullness=;
let $min_ts='1970-01-01 03:00:01';
let $max_ts='2038-01-19 06:14:07';
let $ca_now='2018-06-19 21:00:00';
let $decimals=(2);
let $min_ts='1970-01-01 03:00:01.00';
let $max_ts='2038-01-19 06:14:07.99';

let $decimals=(6);
let $min_ts='1970-01-01 03:00:01.000000';
let $max_ts='2038-01-19 06:14:07.999999';

-- PART VI
--
-- Test of rewriting comparison of a DATETIME[(dec)] field and a
-- constant (decimal, int, string, real).
--
-- Essentially, we get no folding for datetime constants, because we
-- get errors if TIMESTAMP'..' literals illegal, and other type
-- comparison (string, double), os we use other out of range literals.
-- So, only benefot of patch here is to clearly identify constants
-- which are legal, since even int and string literals are converted to
-- TIMESTAMP literals if meaningful. The situation is different for
-- TIMESTAMP fields, since a TIMESTAMP literal can have DATETIME range
-- values. NOTE: The range of DATETIME corresponds to standard SQL
-- TIMESTAMP.

let $table_name=tbl_datetime;
let $ts_type=DATETIME;

let $decimals=;
let $nullness=;
let $min_ts='1970-01-01 03:00:01';
let $max_ts='2038-01-19 06:14:07';
let $ca_now='2018-06-19 21:00:00';
let $decimals=(2);
let $min_ts='1970-01-01 03:00:01.00';
let $max_ts='2038-01-19 06:14:07.99';

let $decimals=(6);
let $min_ts='1970-01-01 03:00:01.000000';
let $max_ts='2038-01-19 06:14:07.999999';

-- PART VII
--
-- Test of rewriting comparison of a DATE field and a
-- constant (decimal, int, string, real).
--source include/const_folding_date.inc


-- PART VIII
--
-- Test that TIME constants not given as TIME literals are
-- converted to TIME literals;
CREATE TABLE t(t TIME);
INSERT INTO t VALUES ('18:00:00');
SELECT * FROM t WHERE t = '18:00:00';
SELECT * FROM t WHERE t = '18:00:00.001';
SELECT * FROM t WHERE t = 180000;
SELECT * FROM t WHERE t = 180000.001;
SELECT * FROM t WHERE t = 'abra cadabra';
SELECT * FROM t WHERE t = TIME'180000.001';

-- Test fallback to double when constant is not interpretable
-- as a time constant
EXPLAIN SELECT * FROM t WHERE t = 3.14E44;

DROP TABLE t;



-- Test of AD-158 Folding of IS NOT NULL if argument is not nullable.
CREATE TABLE t(i TINYINT NOT NULL, j TINYINT NOT NULL);
INSERT INTO t VALUES (1,1), (1,2), (2,1), (2,2);
SELECT SUM(i) s, j FROM t WHERE j != 128 GROUP BY j;
SELECT SUM(i) s, j FROM t  WHERE j != 128 GROUP BY j WITH ROLLUP;
SELECT SUM(i) s, j FROM t GROUP BY j HAVING j != 128;
SELECT SUM(i) s, j FROM t GROUP BY j WITH ROLLUP HAVING j != 128;
SELECT SUM(i) s, j FROM t GROUP BY j WITH ROLLUP HAVING j IS NOT NULL;

DROP TABLE t;

--
-- Bug#28909279 WL#11935: SIG11 IN STRING::LENGTH|INCLUDE/SQL_STRING.H
--
CREATE TABLE a(col_int INT, col_date DATE);
SELECT col_date FROM a WHERE
   (NULL, NULL) IN (SELECT col_date, col_date FROM a) OR
   (col_int <> 'C') ;
DROP TABLE a;

--
-- Bug#28935247 WL#11935: COMPARISON OF TIME DATATYPE WITH AN INTEGER RETURNS A DIFFERENT RESULT
--
CREATE TABLE t11 (col_time TIME);
INSERT INTO t11 VALUES('11:00:00');
let query=SELECT col_time FROM t11 HAVING col_time > 156970;

let query=SELECT col_time FROM t11 WHERE col_time > 156970;

let query=SELECT col_time FROM t11 WHERE col_time < 156970;

DROP TABLE t11;

--
-- Bug#29155126  CRASH IN GET_MYSQL_TIME_FROM_STR_NO_WARN
--
CREATE TABLE t1(d DOUBLE);
INSERT INTO t1 VALUES (3.3);
CREATE TABLE t2 (ts TIMESTAMP);
INSERT INTO t2 VALUES ('2018-09-15 11:00:25.00');
SELECT * FROM cte1, cte2 WHERE cte1.a1 <> cte2.a2;

DROP TABLE t1, t2;

--
-- Bug#29155439 ASSERTION FALSE IN WIDEN_FRACTION() DECIMAL.CC, LINE 993
--
CREATE TABLE t(c DECIMAL(9,3));
SELECT * FROM t WHERE c <=> 8106.000000;
DROP TABLE t;

--
-- Bug#29939331 THE NEGATION OF A "<=>" COMPARISON MALFUNCTIONS DEPENDING ON THE COLUMN'S TYPE
--
CREATE TABLE t0(c0 TINYINT);
INSERT INTO t0(c0) VALUES(NULL);
SELECT * FROM t0 WHERE NOT(t0.c0 <=> 2035382037);
SELECT * FROM t0 WHERE t0.c0 <=> 2035382037;
DROP TABLE t0;

--
-- Bug#31110614 INCORRECT RESULT WHEN COMPARING A FLOATING-POINT NUMBER WITH AN INTEGER
--
CREATE TABLE t0(c0 INT);
INSERT INTO t0(c0) VALUES (0);
SELECT * FROM t0 WHERE 0.9 > t0.c0;
DROP TABLE t0;

--
-- Bug#35200367 WHERE condition assertion error
--
CREATE TABLE t0 (c0 BIGINT);
let $query = SELECT 1 FROM t0 WHERE t0.c0 =  05687.3E-84;
let $query = SELECT 1 FROM t0 WHERE t0.c0 >  05687.3E-84;
let $query = SELECT 1 FROM t0 WHERE t0.c0 >= 05687.3E-84;
let $query = SELECT 1 FROM t0 WHERE t0.c0 <  05687.3E-84;
let $query = SELECT 1 FROM t0 WHERE t0.c0 <= 05687.3E-84;
DROP TABLE t0;
