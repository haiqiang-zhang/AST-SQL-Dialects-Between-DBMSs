CREATE VIEW v1 AS
    SELECT *
    FROM t1 INNER JOIN t2 ON t1.b=t2.b AND t2.x>0
    RIGHT JOIN t3 ON t1.c=t3.c AND t3.y>0
    LEFT JOIN t4 ON t1.d=t4.d AND t4.z>0;
BEGIN;
