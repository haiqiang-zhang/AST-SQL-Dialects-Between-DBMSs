SELECT X FROM (SELECT * FROM (SELECT 1 AS X, 2 AS Y) UNION ALL SELECT 3, 4) ORDER BY X;
DROP TABLE IF EXISTS globalin;
CREATE TABLE globalin (CounterID UInt32, StartDate Date ) ENGINE = Memory;
INSERT INTO globalin VALUES (34, toDate('2017-10-02')), (42, toDate('2017-10-02')), (55, toDate('2017-10-01'));
SELECT 'NOW okay =========================:';
SELECT 'NOW BAD ==========================:';
SELECT 'finish ===========================;
';
DROP TABLE globalin;
DROP TABLE IF EXISTS union_bug;
CREATE TABLE union_bug (
    Event String,
    Datetime DateTime('Asia/Istanbul')
) Engine = Memory;
INSERT INTO union_bug VALUES ('A', 1), ('B', 2);
SELECT ' * A UNION * B:';
SELECT * FROM (
  SELECT * FROM union_bug WHERE Event = 'A'
 UNION ALL
  SELECT * FROM union_bug WHERE Event = 'B'
) ORDER BY Datetime;
SELECT ' Event, Datetime A UNION * B:';
SELECT * FROM (
  SELECT Event, Datetime FROM union_bug WHERE Event = 'A'
 UNION ALL
  SELECT * FROM union_bug WHERE Event = 'B'
) ORDER BY Datetime;
SELECT ' * A UNION Event, Datetime B:';
SELECT * FROM (
  SELECT * FROM union_bug WHERE Event = 'A'
 UNION ALL
  SELECT Event, Datetime FROM union_bug WHERE Event = 'B'
) ORDER BY Datetime;
SELECT ' Event, Datetime A UNION Event, Datetime B:';
SELECT * FROM (
  SELECT Event, Datetime FROM union_bug WHERE Event = 'A'
 UNION ALL
  SELECT Event, Datetime FROM union_bug WHERE Event = 'B'
) ORDER BY Datetime;
DROP TABLE union_bug;