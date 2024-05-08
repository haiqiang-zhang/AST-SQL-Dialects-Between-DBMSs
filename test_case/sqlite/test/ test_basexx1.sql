CREATE TEMP TABLE rb( len int, b blob ) STRICT;
INSERT INTO rb(len) VALUES (1),(2),(3),(4),(5),(150),(151),(152),(153),(1054);
UPDATE rb SET b = randomblob(len);
CREATE TEMP TABLE junk(j text, rank int);
INSERT INTO junk VALUES ('',0),(' ',1),('~',2);
CREATE TABLE bs(b blob, num);
INSERT INTO bs SELECT randomblob(4000 + n%3), n 
   FROM ( 
     WITH RECURSIVE seq(n) AS (
      VALUES(1) UNION ALL SELECT n+1
      FROM seq WHERE n<100
     ) SELECT n FROM seq);
