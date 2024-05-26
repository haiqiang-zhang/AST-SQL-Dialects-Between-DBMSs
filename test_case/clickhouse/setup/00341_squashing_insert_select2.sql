DROP TABLE IF EXISTS numbers_squashed;
CREATE TABLE numbers_squashed (number UInt8) ENGINE = StripeLog;
SET min_insert_block_size_rows = 100;
SET min_insert_block_size_bytes = 0;
SET max_insert_threads = 1;
SET max_threads = 1;
INSERT INTO numbers_squashed
SELECT arrayJoin(range(10)) AS number
UNION ALL
SELECT arrayJoin(range(100))
UNION ALL
SELECT arrayJoin(range(10));
