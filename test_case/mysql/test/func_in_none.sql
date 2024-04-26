-- 
-- Run func_in.inc without any of the socalled 6.0 features.
--

--disable_query_log
if (`select locate('semijoin', @@optimizer_switch) > 0`) 
{
  set optimizer_switch='semijoin=off';
{
  set optimizer_switch='materialization=off';
{
  set optimizer_switch='index_condition_pushdown=off';
{
  set optimizer_switch='mrr=off';

set optimizer_switch=default;

CREATE TABLE t1
 (i8 BIGINT,
  dc DECIMAL(20, 4),
  r8 DOUBLE,
  fc CHAR(64),
  vc VARCHAR(64),
  d  DATE,
  t  TIME,
  dt DATETIME,
  j  JSON,
  ji JSON,
  js JSON);

INSERT INTO t1 VALUES
 (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
 (1, 1.1, 1.1e100, '1', '1', DATE'2020-01-01', TIME'01:01:01',
  TIMESTAMP'2020-01-01 01:01:01', '{"i":1, "s":"1"}', '1', '"1"'),
 (2, 2.2, 2.2e100, '2', '2', DATE'2020-02-02', TIME'02:02:02',
  TIMESTAMP'2020-02-02 02:02:02', '{"i":2, "s":"2"}', '2', '"2"'),
 (3, 3.3, 3.3e100, '3', '3', DATE'2020-03-03', TIME'03:03:03',
  TIMESTAMP'2020-03-03 03:03:03', '{"i":3, "s":"3"}', '3', '"3"'),
 (4, 4.4, 4.4e100, '4', '4', DATE'2020-04-04', TIME'04:04:04',
  TIMESTAMP'2020-04-04 04:04:04', '{"i":4, "s":"4"}', '4', '"4"'),
 (5, 5.5, 5.5e100, '5', '5', DATE'2020-05-05', TIME'05:05:05',
  TIMESTAMP'2020-05-05 05:05:05', '{"i":5, "s":"5"}', '5', '"5"');

set @null = NULL;

set @int_one = 1;
set @dec_one = 1.1;
set @dbl_one = 1.1e100;
set @str_one = '1';
set @date_one = '2020-01-01';
set @time_one = '01:01:01';
set @dt_one = '2020-01-01 01:01:01';
set @json_one = '{"i":1, "s":"1"}';

set @int_two = 2;
set @dec_two = 2.2;
set @dbl_two = 2.2e100;
set @str_two = '2';
set @date_two = '2020-02-02';
set @time_two = '02:02:02';
set @dt_two = '2020-02-02 02:02:02';
set @json_two = '{"i":2, "s":"2"}';

set @int_five = 5;
set @dec_five = 5.5;
set @dbl_five = 5.5e100;
set @str_five = '5';
set @date_five = '2020-05-05';
set @time_five = '05:05:05';
set @dt_five = '2020-05-05 05:05:05';
set @json_five = '{"i":5, "s":"5"}';

SELECT i8 FROM t1 WHERE i8 IN (1, 2, 5);
SELECT i8 FROM t1 WHERE i8 IN (@int_one, @int_two, @int_five);

SELECT i8 FROM t1 WHERE dc IN (1.1, 2.2, 5.5);
SELECT i8 FROM t1 WHERE dc IN (@dec_one, @dec_two, @dec_five);

SELECT i8 FROM t1 WHERE r8 IN (1.1e100, 2.2e100, 5.5e100);
SELECT i8 FROM t1 WHERE r8 IN (@dbl_one, @dbl_two, @dbl_five);

SELECT i8 FROM t1 WHERE vc IN ('1', '2', '5');
SELECT i8 FROM t1 WHERE vc IN (@str_one, @str_two, @str_five);

SELECT i8 FROM t1
WHERE d IN (DATE'2020-01-01', DATE'2020-02-02', DATE'2020-05-05');

SELECT i8 FROM t1 WHERE d IN (@date_one, @date_two, @date_five);

SELECT i8 FROM t1
WHERE t IN (TIME'01:01:01', TIME'02:02:02', TIME'05:05:05');

SELECT i8 FROM t1 WHERE t IN (@time_one, @time_two, @time_five);

SELECT i8 FROM t1
WHERE dt IN (TIMESTAMP'2020-01-01 01:01:01',
             TIMESTAMP'2020-02-02 02:02:02',
             TIMESTAMP'2020-05-05 05:05:05');

SELECT i8 FROM t1 WHERE dt IN (@dt_one, @dt_two, @dt_five);

SELECT i8 FROM t1
WHERE j IN (CAST('{"i":1, "s":"1"}' AS JSON),
            CAST('{"i":2, "s":"2"}' AS JSON),
            CAST('{"i":5, "s":"5"}' AS JSON));
SELECT i8 FROM t1
WHERE j IN (CAST(@json_one AS JSON),
            CAST(@json_two AS JSON),
            CAST(@json_five AS JSON));
SELECT i8 FROM t1 WHERE j IN (CAST(? AS JSON), CAST(? AS JSON), CAST(? AS JSON))";

SELECT i8 FROM t1 WHERE ji IN (1, 2, 5);
SELECT i8 FROM t1 WHERE ji IN (@int_one, @int_two, @int_five);

SELECT i8 FROM t1 WHERE js IN ('1', '2', '5');
SELECT i8 FROM t1 WHERE js IN (@str_one, @str_two, @str_five);

SELECT i8
FROM t1
WHERE (i8, dc, vc) IN ((1, 1.1, '1'), (2, 2.2, '2'), (5, 5.5, '5'));
SELECT i8
FROM t1
WHERE (i8, dc, vc) IN ((@int_one, @dec_one, @str_one),
                       (@int_two, @dec_two, @str_two),
                       (@int_five, @dec_five, @str_five));
SELECT i8 FROM t1 WHERE (i8, dc, vc) IN ((?, ?, ?), (?, ?, ?), (?, ?, ?))";
                 @int_five, @dec_five, @str_five;
                 @int_five, @dec_five, @str_five;
                 @int_five, @dec_five, @str_five;
                 @int_five, @dec_five, @null;
                 @int_five, @dec_five, @str_five;

DROP TABLE t1;

SET @e:=1;
