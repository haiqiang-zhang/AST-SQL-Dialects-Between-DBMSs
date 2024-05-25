SELECT * FROM t1 WHERE t1.f1 < 1;
SELECT MIN(t3.f1)
FROM (t2 JOIN (t3 JOIN (SELECT t1.*
                        FROM t1
                        WHERE t1.f2 < t1.f2) AS dt
               ON (dt.f1 = t3.f1))
      ON (dt.f2 = t3.f2))
WHERE (dt.f2 <> ANY (SELECT t1.f1 FROM t1 WHERE t1.f2 = dt.f2));
DROP TABLE t1, t2, t3;
