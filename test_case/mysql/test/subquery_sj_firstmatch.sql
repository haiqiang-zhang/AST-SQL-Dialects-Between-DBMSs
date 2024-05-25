SELECT *
FROM t2 AS nt2
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t2 AS nt2
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t2 AS nt2, t8 AS nt4
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t2 AS nt2, t8 AS nt4
WHERE 1 IN (SELECT it1.a
            FROM t1 AS it1 JOIN t6 AS it3 ON it1.a=it3.a);
SELECT *
FROM t0 AS ot1, t2 AS nt3
WHERE ot1.a IN (SELECT it2.a
                FROM t1 AS it2 JOIN t8 AS it4 ON it2.a=it4.a);
SELECT *
FROM t0 as ot1, t2 AS nt3
WHERE ot1.a IN (SELECT it2.a
                FROM t1 AS it2 JOIN t8 AS it4 ON it2.a=it4.a);
DROP TABLE t0, t1, t2, t6, t8;
