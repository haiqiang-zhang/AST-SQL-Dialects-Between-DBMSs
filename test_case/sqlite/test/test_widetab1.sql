WITH RECURSIVE c(x) AS (VALUES(0) UNION ALL SELECT x+1000 FROM c WHERE x<9000)
  INSERT INTO t1 SELECT
    x+00, x+01, x+02, x+03, x+04, x+05, x+06, x+07, x+08, x+09,
    x+10, x+11, x+12, x+13, x+14, x+15, x+16, x+17, x+18, x+19,
    x+20, x+21, x+22, x+23, x+24, x+25, x+26, x+27, x+28, x+29,
    x+30, x+31, x+32, x+33, x+34, x+35, x+36, x+37, x+38, x+39,
    x+40, x+41, x+42, x+43, x+44, x+45, x+46, x+47, x+48, x+49,
    x+50, x+51, x+52, x+53, x+54, x+55, x+56, x+57, x+58, x+59,
    x+60, x+61, x+62, x+63, x+64, x+65, x+66, x+67, x+68, x+69,
    x+70, x+71, x+72, x+73, x+74, x+75, x+76, x+77, x+78, x+79,
    x+80, x+81, x+82, x+83, x+84, x+85, x+86, x+87, x+88, x+89,
    x+90, x+91, x+92, x+93, x+94, x+95, x+96, x+97, x+98, x+99,
    x+100, x+101, x+102, x+103, x+104 FROM c;
SELECT sum(c62) FROM t1;
BEGIN;
UPDATE t1 SET c62=c62+1 WHERE c00=1000;
UPDATE t1 SET c65=c65+1 WHERE c00=1000;
BEGIN;
SELECT count(*) FROM t1;
DELETE FROM t1 WHERE c=3102;
SELECT COUNT(*) FROM t1;
BEGIN;
DELETE FROM t1 WHERE c=3102 AND d=3103;
BEGIN;
DELETE FROM t1 WHERE (c,d) IN (VALUES(3102,3103),(4102,4103),(5102,5103),(1,2));
DROP INDEX t1cd;
DROP INDEX t1x1;
DROP INDEX t1x2;
CREATE INDEX t1x3 ON t1(c00,c05,c08);
DROP INDEX t1x3;
CREATE TABLE t2 AS SELECT * FROM t1;
CREATE INDEX t1x4 ON t1(c00, c62, a, b);
CREATE INDEX t2x4 ON t2(c01, c62, c63, b, c);
SELECT t1.b, t2.b FROM t1 JOIN t2 ON t2.c01=t1.c00+1 WHERE +t1.b<7000
   ORDER BY +t1.b;
