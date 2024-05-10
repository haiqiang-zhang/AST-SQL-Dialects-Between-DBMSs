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
SELECT i8 FROM t1 WHERE i8 IN (1, 2, 5);
SELECT i8 FROM t1 WHERE i8 IN (@int_one, @int_two, @int_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE i8 IN (?, ?, ?)";
SELECT i8 FROM t1 WHERE dc IN (1.1, 2.2, 5.5);
SELECT i8 FROM t1 WHERE dc IN (@dec_one, @dec_two, @dec_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE dc IN (?, ?, ?)";
SELECT i8 FROM t1 WHERE r8 IN (1.1e100, 2.2e100, 5.5e100);
SELECT i8 FROM t1 WHERE r8 IN (@dbl_one, @dbl_two, @dbl_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE r8 IN (?, ?, ?)";
SELECT i8 FROM t1 WHERE vc IN ('1', '2', '5');
SELECT i8 FROM t1 WHERE vc IN (@str_one, @str_two, @str_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE vc IN (?, ?, ?)";
SELECT i8 FROM t1
WHERE d IN (DATE'2020-01-01', DATE'2020-02-02', DATE'2020-05-05');
SELECT i8 FROM t1 WHERE d IN (@date_one, @date_two, @date_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE d IN (?, ?, ?)";
SELECT i8 FROM t1
WHERE t IN (TIME'01:01:01', TIME'02:02:02', TIME'05:05:05');
SELECT i8 FROM t1 WHERE t IN (@time_one, @time_two, @time_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE t IN (?, ?, ?)";
SELECT i8 FROM t1
WHERE dt IN (TIMESTAMP'2020-01-01 01:01:01',
             TIMESTAMP'2020-02-02 02:02:02',
             TIMESTAMP'2020-05-05 05:05:05');
SELECT i8 FROM t1 WHERE dt IN (@dt_one, @dt_two, @dt_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE dt IN (?, ?, ?)";
SELECT i8 FROM t1
WHERE j IN (CAST('{"i":1, "s":"1"}' AS JSON),
            CAST('{"i":2, "s":"2"}' AS JSON),
            CAST('{"i":5, "s":"5"}' AS JSON));
SELECT i8 FROM t1
WHERE j IN (CAST(@json_one AS JSON),
            CAST(@json_two AS JSON),
            CAST(@json_five AS JSON));
PREPARE ps FROM "
SELECT i8 FROM t1 WHERE j IN (CAST(? AS JSON), CAST(? AS JSON), CAST(? AS JSON))";
SELECT i8 FROM t1 WHERE ji IN (1, 2, 5);
SELECT i8 FROM t1 WHERE ji IN (@int_one, @int_two, @int_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE ji IN (?, ?, ?)";
SELECT i8 FROM t1 WHERE js IN ('1', '2', '5');
SELECT i8 FROM t1 WHERE js IN (@str_one, @str_two, @str_five);
PREPARE ps FROM "SELECT i8 FROM t1 WHERE js IN (?, ?, ?)";
SELECT i8
FROM t1
WHERE (i8, dc, vc) IN ((1, 1.1, '1'), (2, 2.2, '2'), (5, 5.5, '5'));
SELECT i8
FROM t1
WHERE (i8, dc, vc) IN ((@int_one, @dec_one, @str_one),
                       (@int_two, @dec_two, @str_two),
                       (@int_five, @dec_five, @str_five));
PREPARE ps FROM "
SELECT i8 FROM t1 WHERE (i8, dc, vc) IN ((?, ?, ?), (?, ?, ?), (?, ?, ?))";
DEALLOCATE PREPARE ps;
DROP TABLE t1;
