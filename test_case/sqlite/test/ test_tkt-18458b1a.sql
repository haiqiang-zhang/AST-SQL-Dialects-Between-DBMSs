CREATE VIEW v0(c0, c1) AS SELECT DISTINCT t0.c0, 'a' FROM t0;
SELECT count(*) FROM v0 WHERE c1 >= c0;
SELECT count(*) FROM v0 WHERE NOT NOT (c1 >= c0);
SELECT count(*) FROM v0 WHERE ((c1 >= c0) OR 0+0);
INSERT INTO t0(c0) VALUES ('B');
SELECT count(*) FROM v0 WHERE c1 >= c0;
SELECT count(*) FROM v0 WHERE NOT NOT (c1 >= c0);
SELECT count(*) FROM v0 WHERE ((c1 >= c0) OR 0+0);
