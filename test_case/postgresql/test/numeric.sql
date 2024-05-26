VACUUM ANALYZE num_exp_add;
VACUUM ANALYZE num_exp_sub;
VACUUM ANALYZE num_exp_div;
VACUUM ANALYZE num_exp_mul;
VACUUM ANALYZE num_exp_sqrt;
VACUUM ANALYZE num_exp_ln;
VACUUM ANALYZE num_exp_log10;
VACUUM ANALYZE num_exp_power_10_ln;
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, t1.val + t2.val
    FROM num_data t1, num_data t2;
SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_add t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, round(t1.val + t2.val, 10)
    FROM num_data t1, num_data t2;
SELECT t1.id1, t1.id2, t1.result, round(t2.expected, 10) as expected
    FROM num_result t1, num_exp_add t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != round(t2.expected, 10);
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, t1.val - t2.val
    FROM num_data t1, num_data t2;
SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_sub t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, round(t1.val - t2.val, 40)
    FROM num_data t1, num_data t2;
SELECT t1.id1, t1.id2, t1.result, round(t2.expected, 40)
    FROM num_result t1, num_exp_sub t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != round(t2.expected, 40);
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, t1.val * t2.val
    FROM num_data t1, num_data t2;
SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_mul t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, round(t1.val * t2.val, 30)
    FROM num_data t1, num_data t2;
SELECT t1.id1, t1.id2, t1.result, round(t2.expected, 30) as expected
    FROM num_result t1, num_exp_mul t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != round(t2.expected, 30);
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, t1.val / t2.val
    FROM num_data t1, num_data t2
    WHERE t2.val != '0.0';
SELECT t1.id1, t1.id2, t1.result, t2.expected
    FROM num_result t1, num_exp_div t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT t1.id, t2.id, round(t1.val / t2.val, 80)
    FROM num_data t1, num_data t2
    WHERE t2.val != '0.0';
SELECT t1.id1, t1.id2, t1.result, round(t2.expected, 80) as expected
    FROM num_result t1, num_exp_div t2
    WHERE t1.id1 = t2.id1 AND t1.id2 = t2.id2
    AND t1.result != round(t2.expected, 80);
DELETE FROM num_result;
INSERT INTO num_result SELECT id, 0, SQRT(ABS(val))
    FROM num_data;
SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_sqrt t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT id, 0, LN(ABS(val))
    FROM num_data
    WHERE val != '0.0';
SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_ln t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT id, 0, LOG(numeric '10', ABS(val))
    FROM num_data
    WHERE val != '0.0';
SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_log10 t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected;
DELETE FROM num_result;
INSERT INTO num_result SELECT id, 0, POWER(numeric '10', LN(ABS(round(val,200))))
    FROM num_data
    WHERE val != '0.0';
SELECT t1.id1, t1.result, t2.expected
    FROM num_result t1, num_exp_power_10_ln t2
    WHERE t1.id1 = t2.id
    AND t1.result != t2.expected;
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('inf'),('-inf'),('nan'))
SELECT x1, x2,
  x1 + x2 AS sum,
  x1 - x2 AS diff,
  x1 * x2 AS prod
FROM v AS v1(x1), v AS v2(x2);
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('inf'),('-inf'),('nan'))
SELECT x1, x2,
  x1 / x2 AS quot,
  x1 % x2 AS mod,
  div(x1, x2) AS div
FROM v AS v1(x1), v AS v2(x2) WHERE x2 != 0;
SELECT 'nan'::numeric / '0';
SELECT 'nan'::numeric % '0';
SELECT div('nan'::numeric, '0');
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('inf'),('-inf'),('nan'))
SELECT x, -x as minusx, abs(x), floor(x), ceil(x), sign(x), numeric_inc(x) as inc
FROM v;
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('inf'),('-inf'),('nan'))
SELECT x, round(x), round(x,1) as round1, trunc(x), trunc(x,1) as trunc1
FROM v;
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('-1'),('4.2'),('-7.777'),('1e340'),('-1e340'),
         ('inf'),('-inf'),('nan'),
         ('inf'),('-inf'),('nan'))
SELECT substring(x::text, 1, 32)
FROM v ORDER BY x;
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('4.2'),('inf'),('nan'))
SELECT x, sqrt(x)
FROM v;
WITH v(x) AS
  (VALUES('1'::numeric),('4.2'),('inf'),('nan'))
SELECT x,
  log(x),
  log10(x),
  ln(x)
FROM v;
WITH v(x) AS
  (VALUES('2'::numeric),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  log(x1, x2)
FROM v AS v1(x1), v AS v2(x2);
WITH v(x) AS
  (VALUES('0'::numeric),('1'),('2'),('4.2'),('inf'),('nan'))
SELECT x1, x2,
  power(x1, x2)
FROM v AS v1(x1), v AS v2(x2) WHERE x1 != 0 OR x2 >= 0;
SELECT power('-1'::numeric, 'inf');
SELECT AVG(val) FROM num_data;
SELECT MAX(val) FROM num_data;
SELECT MIN(val) FROM num_data;
SELECT STDDEV(val) FROM num_data;
SELECT VARIANCE(val) FROM num_data;
CREATE TABLE fract_only (id int, val numeric(4,4));
INSERT INTO fract_only VALUES (1, '0.0');
INSERT INTO fract_only VALUES (2, '0.1');
INSERT INTO fract_only VALUES (4, '-0.9999');
INSERT INTO fract_only VALUES (5, '0.99994');
INSERT INTO fract_only VALUES (7, '0.00001');
INSERT INTO fract_only VALUES (8, '0.00017');
INSERT INTO fract_only VALUES (9, 'NaN');
SELECT * FROM fract_only;
DROP TABLE fract_only;
SELECT (-9223372036854775808.4)::int8;
SELECT 9223372036854775807.4::int8;
SELECT (-2147483648.4)::int4;
SELECT 2147483647.4::int4;
SELECT (-32768.4)::int2;
SELECT 32767.4::int2;
SELECT 'NaN'::float8::numeric;
SELECT 'Infinity'::float8::numeric;
SELECT '-Infinity'::float8::numeric;
SELECT 'NaN'::numeric::float8;
SELECT 'Infinity'::numeric::float8;
SELECT '-Infinity'::numeric::float8;
SELECT 'NaN'::float4::numeric;
SELECT 'Infinity'::float4::numeric;
SELECT '-Infinity'::float4::numeric;
SELECT 'NaN'::numeric::float4;
SELECT 'Infinity'::numeric::float4;
SELECT '-Infinity'::numeric::float4;
SELECT '42'::int2::numeric;
CREATE TABLE ceil_floor_round (a numeric);
INSERT INTO ceil_floor_round VALUES ('-5.5');
INSERT INTO ceil_floor_round VALUES ('-5.499999');
INSERT INTO ceil_floor_round VALUES ('9.5');
INSERT INTO ceil_floor_round VALUES ('9.4999999');
INSERT INTO ceil_floor_round VALUES ('0.0');
INSERT INTO ceil_floor_round VALUES ('0.0000001');
INSERT INTO ceil_floor_round VALUES ('-0.000001');
SELECT a, ceil(a), ceiling(a), floor(a), round(a) FROM ceil_floor_round;
DROP TABLE ceil_floor_round;
CREATE TABLE width_bucket_test (operand_num numeric, operand_f8 float8);
SELECT
    operand_num,
    width_bucket(operand_num, 0, 10, 5) AS wb_1,
    width_bucket(operand_f8, 0, 10, 5) AS wb_1f,
    width_bucket(operand_num, 10, 0, 5) AS wb_2,
    width_bucket(operand_f8, 10, 0, 5) AS wb_2f,
    width_bucket(operand_num, 2, 8, 4) AS wb_3,
    width_bucket(operand_f8, 2, 8, 4) AS wb_3f,
    width_bucket(operand_num, 5.0, 5.5, 20) AS wb_4,
    width_bucket(operand_f8, 5.0, 5.5, 20) AS wb_4f,
    width_bucket(operand_num, -25, 25, 10) AS wb_5,
    width_bucket(operand_f8, -25, 25, 10) AS wb_5f
    FROM width_bucket_test;
SELECT width_bucket('Infinity'::numeric, 1, 10, 10),
       width_bucket('-Infinity'::numeric, 1, 10, 10);
DROP TABLE width_bucket_test;
SELECT x, width_bucket(x::float8, 10, 100, 9) as flt,
       width_bucket(x::numeric, 10, 100, 9) as num
FROM generate_series(0, 110, 10) x;
SELECT x, width_bucket(x::float8, 100, 10, 9) as flt,
       width_bucket(x::numeric, 100, 10, 9) as num
FROM generate_series(0, 110, 10) x;
SELECT to_char(val, '9G999G999G999G999G999')
	FROM num_data;
WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, '9.999EEEE') as numeric,
  to_char(val::float8, '9.999EEEE') as float8,
  to_char(val::float4, '9.999EEEE') as float4
FROM v;
WITH v(exp) AS
  (VALUES(-16379),(-16378),(-1234),(-789),(-45),(-5),(-4),(-3),(-2),(-1),(0),
         (1),(2),(3),(4),(5),(38),(275),(2345),(45678),(131070),(131071))
SELECT exp,
  to_char(('1.2345e'||exp)::numeric, '9.999EEEE') as numeric
FROM v;
WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, 'MI9999999999.99') as numeric,
  to_char(val::float8, 'MI9999999999.99') as float8,
  to_char(val::float4, 'MI9999999999.99') as float4
FROM v;
WITH v(val) AS
  (VALUES('0'::numeric),('-4.2'),('4.2e9'),('1.2e-5'),('inf'),('-inf'),('nan'))
SELECT val,
  to_char(val, 'MI99.99') as numeric,
  to_char(val::float8, 'MI99.99') as float8,
  to_char(val::float4, 'MI99.99') as float4
FROM v;
SET lc_numeric = 'C';
SELECT to_number('-34,338,492', '99G999G999');
RESET lc_numeric;
CREATE TABLE num_input_test (n1 numeric);
INSERT INTO num_input_test(n1) VALUES (' 123');
INSERT INTO num_input_test(n1) VALUES ('   3245874    ');
INSERT INTO num_input_test(n1) VALUES ('  -93853');
INSERT INTO num_input_test(n1) VALUES ('555.50');
INSERT INTO num_input_test(n1) VALUES ('-555.50');
INSERT INTO num_input_test(n1) VALUES ('NaN ');
INSERT INTO num_input_test(n1) VALUES ('        nan');
INSERT INTO num_input_test(n1) VALUES (' inf ');
INSERT INTO num_input_test(n1) VALUES (' +inf ');
INSERT INTO num_input_test(n1) VALUES (' -inf ');
INSERT INTO num_input_test(n1) VALUES (' Infinity ');
INSERT INTO num_input_test(n1) VALUES (' +inFinity ');
INSERT INTO num_input_test(n1) VALUES (' -INFINITY ');
INSERT INTO num_input_test(n1) VALUES ('12_000_000_000');
INSERT INTO num_input_test(n1) VALUES ('12_000.123_456');
INSERT INTO num_input_test(n1) VALUES ('23_000_000_000e-1_0');
INSERT INTO num_input_test(n1) VALUES ('.000_000_000_123e1_0');
INSERT INTO num_input_test(n1) VALUES ('.000_000_000_123e+1_1');
INSERT INTO num_input_test(n1) VALUES ('0b10001110111100111100001001010');
INSERT INTO num_input_test(n1) VALUES ('  -0B_1010_1011_0101_0100_1010_1001_1000_1100_1110_1011_0001_1111_0000_1010_1101_0010  ');
INSERT INTO num_input_test(n1) VALUES ('  +0o112402761777 ');
INSERT INTO num_input_test(n1) VALUES ('-0O0012_5524_5230_6334_3167_0261');
INSERT INTO num_input_test(n1) VALUES ('-0x0000000000000000000000000deadbeef');
INSERT INTO num_input_test(n1) VALUES (' 0X_30b1_F33a_6DF0_bD4E_64DF_9BdA_7D15 ');
SELECT * FROM num_input_test;
SELECT pg_input_is_valid('34.5', 'numeric');
SELECT * FROM pg_input_error_info('1e400000', 'numeric');
CREATE TABLE num_typemod_test (
  millions numeric(3, -6),
  thousands numeric(3, -3),
  units numeric(3, 0),
  thousandths numeric(3, 3),
  millionths numeric(3, 6)
);
INSERT INTO num_typemod_test VALUES (123456, 123, 0.123, 0.000123, 0.000000123);
INSERT INTO num_typemod_test VALUES (654321, 654, 0.654, 0.000654, 0.000000654);
INSERT INTO num_typemod_test VALUES (2345678, 2345, 2.345, 0.002345, 0.000002345);
INSERT INTO num_typemod_test VALUES (7654321, 7654, 7.654, 0.007654, 0.000007654);
INSERT INTO num_typemod_test VALUES (12345678, 12345, 12.345, 0.012345, 0.000012345);
INSERT INTO num_typemod_test VALUES (87654321, 87654, 87.654, 0.087654, 0.000087654);
INSERT INTO num_typemod_test VALUES (123456789, 123456, 123.456, 0.123456, 0.000123456);
INSERT INTO num_typemod_test VALUES (987654321, 987654, 987.654, 0.987654, 0.000987654);
INSERT INTO num_typemod_test VALUES ('NaN', 'NaN', 'NaN', 'NaN', 'NaN');
SELECT scale(millions), * FROM num_typemod_test ORDER BY millions;
select 4790999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
select 4789999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
select 4770999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
select 4769999999999999999999999999999999999999999999999999999999999999999999999999999999999999 * 9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
select trim_scale((0.1 - 2e-16383) * (0.1 - 3e-16383));
select 999999999999999999999::numeric/1000000000000000000000;
select mod(999999999999999999999::numeric,1000000000000000000000);
select div(-9999999999999999999999::numeric,1000000000000000000000)*1000000000000000000000 + mod(-9999999999999999999999::numeric,1000000000000000000000);
select mod (70.0,70);
select div (70.0,70);
select 70.0 / 70;
select 12345678901234567890 % 123;
select 12345678901234567890 / 123;
select div(12345678901234567890, 123) * 123 + 12345678901234567890 % 123;
select sqrt(1.000000000000003::numeric);
select 10.0 ^ -2147483648 as rounds_to_zero;
select 10.0 ^ -2147483647 as rounds_to_zero;
select 3.789 ^ 21.0000000000000000;
select 3.789 ^ 35.0000000000000000;
select 1.2 ^ 345;
select 0.12 ^ (-20);
select 1.000000000123 ^ (-2147483648);
select coalesce(nullif(0.9999999999 ^ 23300000000000, 0), 0) as rounds_to_zero;
select 0.12 ^ (-25);
select 0.5678 ^ (-85);
select coalesce(nullif(0.9999999999 ^ 70000000000000, 0), 0) as underflows;
select (-1.0) ^ 2147483646;
select (-1.0) ^ 2147483647;
select (-1.0) ^ 2147483648;
select (-1.0) ^ 1000000000000000;
select (-1.0) ^ 1000000000000001;
select n, 10.0 ^ n as "10^n", (10.0 ^ n) * (10.0 ^ (-n)) = 1 as ok
from generate_series(-20, 20) n;
select 0.0 ^ 0.0;
select (-12.34) ^ 0.0;
select 12.34 ^ 0.0;
select 0.0 ^ 12.34;
select 'NaN'::numeric ^ 'NaN'::numeric;
select 'NaN'::numeric ^ 0;
select 'NaN'::numeric ^ 1;
select 0 ^ 'NaN'::numeric;
select 1 ^ 'NaN'::numeric;
select 32.1 ^ 9.8;
select 32.1 ^ (-9.8);
select 12.3 ^ 45.6;
select 12.3 ^ (-45.6);
select 1.234 ^ 5678;
select exp(0.0);
select coalesce(nullif(exp(-5000::numeric), 0), 0) as rounds_to_zero;
select coalesce(nullif(exp(-10000::numeric), 0), 0) as underflows;
select * from generate_series(0.0::numeric, 4.0::numeric);
select (i / (10::numeric ^ 131071))::numeric(1,0)
	from generate_series(6 * (10::numeric ^ 131071),
			     9 * (10::numeric ^ 131071),
			     10::numeric ^ 131071) as a(i);
select * from generate_series(1::numeric, 3::numeric) i, generate_series(i,3) j;
select * from generate_series(1::numeric, 3::numeric) i, generate_series(1,i) j;
select * from generate_series(1::numeric, 3::numeric) i, generate_series(1,5,i) j;
select ln(1.2345678e-28);
select log(1.234567e-89);
select min_scale(numeric 'NaN') is NULL;
SELECT SUM(9999::numeric) FROM generate_series(1, 100000);
CREATE TABLE num_variance (a numeric);
INSERT INTO num_variance VALUES (0);
INSERT INTO num_variance VALUES (3e-500);
INSERT INTO num_variance VALUES (-3e-500);
INSERT INTO num_variance VALUES (4e-500 - 1e-16383);
INSERT INTO num_variance VALUES (-4e-500 + 1e-16383);
BEGIN;
ALTER TABLE num_variance SET (parallel_workers = 4);
SET LOCAL parallel_setup_cost = 0;
SET LOCAL max_parallel_workers_per_gather = 4;
ROLLBACK;
DELETE FROM num_variance;
INSERT INTO num_variance SELECT 9e131071 + x FROM generate_series(1, 5) x;
SELECT variance(a) FROM num_variance;
BEGIN;
ALTER TABLE num_variance SET (parallel_workers = 4);
SET LOCAL parallel_setup_cost = 0;
SET LOCAL max_parallel_workers_per_gather = 4;
ROLLBACK;
DROP TABLE num_variance;
SELECT a, b, gcd(a, b), gcd(a, -b), gcd(-b, a), gcd(-b, -a)
FROM (VALUES (0::numeric, 0::numeric),
             (0::numeric, numeric 'NaN'),
             (0::numeric, 46375::numeric),
             (433125::numeric, 46375::numeric),
             (43312.5::numeric, 4637.5::numeric),
             (4331.250::numeric, 463.75000::numeric),
             ('inf', '0'),
             ('inf', '42'),
             ('inf', 'inf')
     ) AS v(a, b);
SELECT a,b, lcm(a, b), lcm(a, -b), lcm(-b, a), lcm(-b, -a)
FROM (VALUES (0::numeric, 0::numeric),
             (0::numeric, numeric 'NaN'),
             (0::numeric, 13272::numeric),
             (13272::numeric, 13272::numeric),
             (423282::numeric, 13272::numeric),
             (42328.2::numeric, 1327.2::numeric),
             (4232.820::numeric, 132.72000::numeric),
             ('inf', '0'),
             ('inf', '42'),
             ('inf', 'inf')
     ) AS v(a, b);
SELECT factorial(4);
SELECT pg_lsn(23783416::numeric);
