SET max_block_size = 3;
INSERT INTO mem_test SELECT
    number,
    number
FROM numbers(100);
ALTER TABLE mem_test
    UPDATE a = 0 WHERE b = 99;
ALTER TABLE mem_test
    UPDATE a = 0 WHERE b = 99;
ALTER TABLE mem_test
    UPDATE a = 0 WHERE b = 99;
ALTER TABLE mem_test
    UPDATE a = 0 WHERE b = 99;
ALTER TABLE mem_test
    UPDATE a = 0 WHERE b = 99;
DROP TABLE mem_test;
