SELECT bitCount(number) FROM numbers(10);
SELECT avg(bitCount(number)) FROM numbers(256);
SELECT bitCount(0);
SELECT x, bitCount(x), hex(reinterpretAsString(x)) FROM VALUES ('x Float64', (1), (-1), (inf));
SELECT length(replaceAll(bin('clickhouse cloud'), '0', ''));
SELECT length(replaceAll(bin('clickhouse cloud'), '0', '')) = bitCount('clickhouse cloud');
