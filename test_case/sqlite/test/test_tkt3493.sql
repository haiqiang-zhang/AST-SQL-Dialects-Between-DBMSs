SELECT 
      CASE 
         WHEN B.val = 1 THEN 'XYZ' 
         ELSE A.val 
      END AS Col1
    FROM B  
    LEFT OUTER JOIN A_B ON B.id = A_B.B_id  
    LEFT OUTER JOIN A ON A.id = A_B.A_id
    ORDER BY Col1 ASC;
SELECT DISTINCT
      CASE 
         WHEN B.val = 1 THEN 'XYZ' 
         ELSE A.val 
      END AS Col1
    FROM B  
    LEFT OUTER JOIN A_B ON B.id = A_B.B_id  
    LEFT OUTER JOIN A ON A.id = A_B.A_id
    ORDER BY Col1 ASC;
SELECT b.val, CASE WHEN b.val = 1 THEN 'xyz' ELSE b.val END AS col1 FROM b;
SELECT DISTINCT 
      b.val, 
      CASE WHEN b.val = 1 THEN 'xyz' ELSE b.val END AS col1 
    FROM b;
SELECT DISTINCT 
      b.val, 
      CASE WHEN b.val = '1' THEN 'xyz' ELSE b.val END AS col1 
    FROM b;
CREATE TABLE t1(a TEXT, b INT);
INSERT INTO t1 VALUES(123, 456);
SELECT a=123 FROM t1 GROUP BY a;
SELECT a=123 FROM t1;
SELECT a='123' FROM t1;
SELECT count(*), a=123 FROM t1;
SELECT b='456' FROM t1 GROUP BY a;
SELECT b='456' FROM t1 GROUP BY b;
SELECT b='456' FROM t1;
SELECT typeof(a), a FROM t1 GROUP BY a HAVING a=123;
CREATE TABLE t2(a COLLATE NOCASE, b COLLATE BINARY);
INSERT INTO t2 VALUES('aBc', 'DeF');
SELECT a='abc' FROM t2 GROUP BY a;
SELECT a='abc' FROM t2;
SELECT a>b FROM t2 GROUP BY a, b;
SELECT a>b COLLATE BINARY FROM t2 GROUP BY a, b;
SELECT b>a FROM t2 GROUP BY a, b;
SELECT b>a COLLATE NOCASE FROM t2 GROUP BY a, b;
