SELECT USER(), DATABASE();
CREATE TABLE t1(i INT, j VARCHAR(2048));
INSERT INTO t1 VALUES(1,repeat('a',1000)),(2,repeat('def',600));
SELECT * FROM t1;
SELECT SPACE(@@global.max_allowed_packet);
SELECT USER();
SELECT SLEEP(10);
SELECT 1;
SELECT "connect succeeded after account is unlocked";
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
DROP DATABASE wl11381;
