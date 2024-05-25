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
