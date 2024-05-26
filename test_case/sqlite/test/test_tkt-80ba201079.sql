SELECT * FROM t1, t2 WHERE
    (a='A' AND d='E') OR
    (b='B' AND c IN ('C', 'D', 'E'));
SELECT * FROM t1, t2 WHERE
    (a='A' AND d='E') OR
    (b='B' AND c IN (SELECT c FROM t1));
SELECT * FROM t1, t2 WHERE
      (a='A' AND d='E') OR
      (b='B' AND c IN (SELECT 'B' UNION SELECT 'C' UNION SELECT 'D'));
SELECT * FROM t1, t2 WHERE
    (b='B' AND c IN ('C', 'D', 'E')) OR
    (a='A' AND d='E');
SELECT * FROM t1, t2 WHERE
    (b='B' AND c IN (SELECT c FROM t1)) OR
    (a='A' AND d='E');
SELECT * FROM t1, t2 WHERE
      (b='B' AND c IN (SELECT 'B' UNION SELECT 'C' UNION SELECT 'D')) OR
      (a='A' AND d='E');
