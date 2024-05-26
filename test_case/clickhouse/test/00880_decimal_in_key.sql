SELECT count() FROM t1;
INSERT INTO t2 SELECT toString(number), toDecimal64(number, 8) FROM system.numbers LIMIT 1000000;
DROP TABLE t1;
DROP TABLE t2;
