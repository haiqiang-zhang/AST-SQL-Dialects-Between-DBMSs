pragma threads=2;
pragma verify_parallelism;
CREATE TABLE a AS SELECT * FROM range(0, 10000, 1) t1(i);
DELETE FROM a WHERE i >= 2000 AND i < 5000;
