SELECT count() FROM sorted;
SELECT x FROM (SELECT DISTINCT x FROM sorted) ORDER BY x;
INSERT INTO sorted (x) SELECT (intHash64(number) % 1000 = 0 ? 999 : intDiv(number, 100000)) AS x FROM system.numbers LIMIT 1000000;
SELECT x FROM (SELECT DISTINCT x FROM sorted) ORDER BY x;
DROP TABLE sorted;
