CREATE TABLE t1(a, b, c);
CREATE TABLE t2(d, e, f);
INSERT INTO t1 VALUES( 2,  4,  6);
INSERT INTO t1 VALUES( 8, 10, 12);
INSERT INTO t1 VALUES(14, 16, 18);
INSERT INTO t2 VALUES(3,   6,  9);
INSERT INTO t2 VALUES(12, 15, 18);
INSERT INTO t2 VALUES(21, 24, 27);
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT a FROM t1 UNION ALL SELECT d FROM t2;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2) ORDER BY 1;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 ORDER BY 1;
SELECT * FROM 
      (SELECT a FROM t1 UNION ALL SELECT d FROM t2) 
    WHERE a>10 ORDER BY 1;
SELECT a FROM t1 WHERE a>10 UNION ALL SELECT d FROM t2 WHERE d>10 ORDER BY 1;
SELECT * FROM 
      (SELECT a FROM t1 UNION ALL SELECT d FROM t2) 
    WHERE a>10 ORDER BY a;
SELECT a FROM t1 WHERE a>10 
      UNION ALL 
    SELECT d FROM t2 WHERE d>10 
    ORDER BY a;
SELECT * FROM 
      (SELECT a FROM t1 UNION ALL SELECT d FROM t2 WHERE d > 12) 
    WHERE a>10 ORDER BY a;
SELECT a FROM t1 WHERE a>10
      UNION ALL 
    SELECT d FROM t2 WHERE d>12 AND d>10
    ORDER BY a;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2) ORDER BY 1 
    LIMIT 2;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 ORDER BY 1 LIMIT 2;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2) ORDER BY 1 
    LIMIT 2 OFFSET 3;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 ORDER BY 1 LIMIT 2 OFFSET 3;
SELECT * FROM (
      SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    );
SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1;
SELECT * FROM (
      SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    ) ORDER BY 1;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    ORDER BY 1;
SELECT * FROM (
      SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    ) WHERE a>=10 ORDER BY 1 LIMIT 3;
SELECT a FROM t1 WHERE a>=10 UNION ALL SELECT d FROM t2 WHERE d>=10
    UNION ALL SELECT c FROM t1 WHERE c>=10
    ORDER BY 1 LIMIT 3;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 2);
SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 2;
CREATE INDEX i1 ON t1(a);
CREATE INDEX i2 ON t2(d);
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT a FROM t1 UNION ALL SELECT d FROM t2;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2) ORDER BY 1;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 ORDER BY 1;
SELECT * FROM 
      (SELECT a FROM t1 UNION ALL SELECT d FROM t2) 
    WHERE a>10 ORDER BY 1;
SELECT a FROM t1 WHERE a>10 UNION ALL SELECT d FROM t2 WHERE d>10 ORDER BY 1;
SELECT * FROM 
      (SELECT a FROM t1 UNION ALL SELECT d FROM t2) 
    WHERE a>10 ORDER BY a;
SELECT a FROM t1 WHERE a>10 
      UNION ALL 
    SELECT d FROM t2 WHERE d>10 
    ORDER BY a;
SELECT * FROM 
      (SELECT a FROM t1 UNION ALL SELECT d FROM t2 WHERE d > 12) 
    WHERE a>10 ORDER BY a;
SELECT a FROM t1 WHERE a>10
      UNION ALL 
    SELECT d FROM t2 WHERE d>12 AND d>10
    ORDER BY a;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2) ORDER BY 1 
    LIMIT 2;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 ORDER BY 1 LIMIT 2;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2) ORDER BY 1 
    LIMIT 2 OFFSET 3;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 ORDER BY 1 LIMIT 2 OFFSET 3;
SELECT * FROM (
      SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    );
SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1;
SELECT * FROM (
      SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    ) ORDER BY 1;
SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    ORDER BY 1;
SELECT * FROM (
      SELECT a FROM t1 UNION ALL SELECT d FROM t2 UNION ALL SELECT c FROM t1
    ) WHERE a>=10 ORDER BY 1 LIMIT 3;
SELECT a FROM t1 WHERE a>=10 UNION ALL SELECT d FROM t2 WHERE d>=10
    UNION ALL SELECT c FROM t1 WHERE c>=10
    ORDER BY 1 LIMIT 3;
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 2);
SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 2;
DROP INDEX i1;
DROP INDEX i2;
SELECT DISTINCT * FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c HAVING count(*)>1;
SELECT t4.c, t3.a FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) AS t4, t1 AS t3
      WHERE t3.a=14
      ORDER BY 1;
SELECT d FROM t2 
      EXCEPT 
      SELECT a FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2)
      EXCEPT 
      SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT c FROM t1
      EXCEPT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2);
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT c FROM t1
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY c;
SELECT c FROM t1 UNION SELECT e FROM t2 UNION ALL SELECT f FROM t2
      ORDER BY c;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT c FROM t1
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT c FROM t1
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4
      ) LIMIT 2;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4 OFFSET 2
      ) LIMIT 2;
SELECT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT DISTINCT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT * FROM (SELECT * FROM t1 UNION ALL SELECT * FROM t2) ORDER BY a+b;
SELECT * FROM (SELECT 345 UNION ALL SELECT d FROM t2) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x+y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) WHERE y+x NOT NULL ORDER BY 1;
SELECT DISTINCT * FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c HAVING count(*)>1;
SELECT t4.c, t3.a FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) AS t4, t1 AS t3
      WHERE t3.a=14
      ORDER BY 1;
SELECT d FROM t2 
      EXCEPT 
      SELECT a FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2)
      EXCEPT 
      SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT c FROM t1
      EXCEPT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2);
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT c FROM t1
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY c;
SELECT c FROM t1 UNION SELECT e FROM t2 UNION ALL SELECT f FROM t2
      ORDER BY c;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT c FROM t1
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT c FROM t1
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4
      ) LIMIT 2;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4 OFFSET 2
      ) LIMIT 2;
SELECT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT DISTINCT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT * FROM (SELECT * FROM t1 UNION ALL SELECT * FROM t2) ORDER BY a+b;
SELECT * FROM (SELECT 345 UNION ALL SELECT d FROM t2) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x+y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) WHERE y+x NOT NULL ORDER BY 1;
CREATE INDEX i1 ON t1(a);
CREATE INDEX i2 ON t1(b);
CREATE INDEX i3 ON t1(c);
CREATE INDEX i4 ON t2(d);
CREATE INDEX i5 ON t2(e);
CREATE INDEX i6 ON t2(f);
SELECT DISTINCT * FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c HAVING count(*)>1;
SELECT t4.c, t3.a FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) AS t4, t1 AS t3
      WHERE t3.a=14
      ORDER BY 1;
SELECT d FROM t2 
      EXCEPT 
      SELECT a FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2)
      EXCEPT 
      SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT c FROM t1
      EXCEPT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2);
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT c FROM t1
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY c;
SELECT c FROM t1 UNION SELECT e FROM t2 UNION ALL SELECT f FROM t2
      ORDER BY c;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT c FROM t1
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT c FROM t1
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4
      ) LIMIT 2;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4 OFFSET 2
      ) LIMIT 2;
SELECT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT DISTINCT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT * FROM (SELECT * FROM t1 UNION ALL SELECT * FROM t2) ORDER BY a+b;
SELECT * FROM (SELECT 345 UNION ALL SELECT d FROM t2) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x+y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) WHERE y+x NOT NULL ORDER BY 1;
SELECT DISTINCT * FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c ORDER BY 1;
SELECT c, count(*) FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) 
      GROUP BY c HAVING count(*)>1;
SELECT t4.c, t3.a FROM 
        (SELECT c FROM t1 UNION ALL SELECT e FROM t2) AS t4, t1 AS t3
      WHERE t3.a=14
      ORDER BY 1;
SELECT d FROM t2 
      EXCEPT 
      SELECT a FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2)
      EXCEPT 
      SELECT * FROM (SELECT a FROM t1 UNION ALL SELECT d FROM t2);
SELECT c FROM t1
      EXCEPT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2);
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      EXCEPT 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT c FROM t1
      ORDER BY c DESC;
SELECT c FROM t1
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY c;
SELECT c FROM t1 UNION SELECT e FROM t2 UNION ALL SELECT f FROM t2
      ORDER BY c;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      UNION 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT c FROM t1
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT c FROM t1
      ORDER BY 1;
SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      INTERSECT 
      SELECT * FROM (SELECT e FROM t2 UNION ALL SELECT f FROM t2)
      ORDER BY 1;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4
      ) LIMIT 2;
SELECT * FROM (
        SELECT a FROM t1 UNION ALL SELECT d FROM t2 LIMIT 4 OFFSET 2
      ) LIMIT 2;
SELECT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT DISTINCT * FROM (
        SELECT DISTINCT (a/10) FROM t1 UNION ALL SELECT DISTINCT(d%2) FROM t2
      );
SELECT * FROM (SELECT * FROM t1 UNION ALL SELECT * FROM t2) ORDER BY a+b;
SELECT * FROM (SELECT 345 UNION ALL SELECT d FROM t2) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x, y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) ORDER BY 1;
SELECT x+y FROM (
        SELECT a AS x, b AS y FROM t1
        UNION ALL
        SELECT a*10 + 0.1, f*10 + 0.1 FROM t1 LEFT JOIN t2 ON (c=d)
        UNION ALL
        SELECT a*100, b*100 FROM t1
      ) WHERE y+x NOT NULL ORDER BY 1;