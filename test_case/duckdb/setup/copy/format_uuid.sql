PRAGMA enable_verification;
PRAGMA verify_parallelism;
PRAGMA threads=4;
CREATE TABLE test2 as SELECT i as a, (i*2) as b, power(i,2) as c from range(0,10) tbl(i);
CREATE TABLE test3 as SELECT i as a, (i*3) as b, power(i,3) as c from range(0,10) tbl(i);
CREATE TABLE test4 as SELECT i as a, (i*4) as b, power(i,4) as c from range(0,10) tbl(i);
CREATE TABLE test5 as SELECT i as a, (i*5) as b, power(i,5) as c from range(0,10) tbl(i);
CREATE TABLE testpto as SELECT i as a, (i*10) as b, (i*100) as c from range(0,10000) tbl(i);
