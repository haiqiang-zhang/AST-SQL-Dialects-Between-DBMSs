ANALYZE;
SELECT a,b,c FROM t1 
  WHERE b IN (234, 345) AND c BETWEEN 6 AND 6.5 AND a='abc' 
  ORDER BY a, b;
SELECT a,b,c FROM t1 
  WHERE b IN (234, 345) AND c BETWEEN 6 AND 7 AND a='abc' 
  ORDER BY a, b;
SELECT a,b,c FROM t1 
  WHERE b IN (234, 345) AND c >=6 AND a='abc' 
  ORDER BY a, b;
SELECT a,b,c FROM t1 
  WHERE b IN (234, 345) AND c<=7 AND a='abc' 
  ORDER BY a, b;
SELECT a,b,c FROM t1 WHERE b IN (235, 345) AND c<=3 AND a='abc' ORDER BY a, b;
