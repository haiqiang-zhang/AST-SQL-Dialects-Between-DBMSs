DROP TABLE IF EXISTS arena;
CREATE TABLE arena (k UInt8, d String) ENGINE = Memory;
INSERT INTO arena SELECT number % 10 AS k, hex(intDiv(number, 10) % 1000) AS d FROM system.numbers LIMIT 10000000;
SELECT length(groupUniqArrayIf(d, d != hex(0))) FROM arena GROUP BY k;
DROP TABLE IF EXISTS arena;
SELECT min(x), max(x) FROM (SELECT length(arrayReduce('groupUniqArray', [hex(number), hex(number+1), hex(number)])) AS x FROM system.numbers LIMIT 100000);
SET max_bytes_before_external_group_by = 0;
