PRAGMA enable_verification;
CREATE TABLE p(loc int8);;
INSERT INTO p VALUES (1);;
WITH RECURSIVE t(y, arr) AS
(
  SELECT 1, array[1,2,3,4,5,6]
    UNION ALL
  SELECT y+1, arr[:loc]
  FROM   t, p
  WHERE y < 10
) SELECT * FROM t;;
WITH RECURSIVE t(y, arr) AS
(
  SELECT 1, array[1,2,3,4,5,6]
    UNION ALL
  SELECT y+1, arr
  FROM   t, p
  WHERE y < 10
    AND y = loc
) SELECT * FROM t;;
WITH RECURSIVE t(y, arr) AS
(
  SELECT 1, array[1,2,3,4,5,6]
    UNION ALL
  SELECT y+1, arr[:loc]
  FROM   t, p
  WHERE y < 10
    AND y = loc
) SELECT * FROM t;;
WITH RECURSIVE t(arr) AS
(
  SELECT array[1,2,3,4,5,6]
    UNION ALL
  SELECT  arr[arr[1]+1:6]
  FROM   t
  WHERE arr[1] < 6
) SELECT * FROM t;;
