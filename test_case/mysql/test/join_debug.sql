
CREATE TABLE t1(f1 INTEGER, f2 INTEGER, KEY(f1), KEY(f2));
CREATE TABLE t2 LIKE t1;
CREATE TABLE t3 LIKE t1;

SET debug= '+d,bug35208539_raise_error';
SELECT * FROM t1 WHERE t1.f1 < 1;
SET debug= '-d,bug35208539_raise_error';
SELECT MIN(t3.f1)
FROM (t2 JOIN (t3 JOIN (SELECT t1.*
                        FROM t1
                        WHERE t1.f2 < t1.f2) AS dt
               ON (dt.f1 = t3.f1))
      ON (dt.f2 = t3.f2))
WHERE (dt.f2 <> ANY (SELECT t1.f1 FROM t1 WHERE t1.f2 = dt.f2));

DROP TABLE t1, t2, t3;
