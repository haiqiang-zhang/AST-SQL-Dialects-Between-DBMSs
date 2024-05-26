SELECT blockSize() AS b, count() / b AS c FROM numbers_squashed GROUP BY blockSize() ORDER BY c DESC;
SET min_insert_block_size_bytes = 1000000;
INSERT INTO numbers_squashed SELECT * FROM system.numbers LIMIT 10000000;
SELECT count() FROM numbers_squashed;
DROP TABLE numbers_squashed;
