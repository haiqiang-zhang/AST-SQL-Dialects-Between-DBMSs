SELECT blockSize() AS b, count() / b AS c FROM numbers_squashed GROUP BY blockSize() ORDER BY c DESC, b ASC;
SELECT count() FROM numbers_squashed;
INSERT INTO numbers_squashed
SELECT arrayJoin(range(100)) AS number
UNION ALL
SELECT arrayJoin(range(10))
UNION ALL
SELECT arrayJoin(range(100));
INSERT INTO numbers_squashed
SELECT arrayJoin(range(10)) AS number
UNION ALL
SELECT arrayJoin(range(100))
UNION ALL
SELECT arrayJoin(range(100));
INSERT INTO numbers_squashed
SELECT arrayJoin(range(10)) AS number
UNION ALL
SELECT arrayJoin(range(10))
UNION ALL
SELECT arrayJoin(range(10))
UNION ALL
SELECT arrayJoin(range(100))
UNION ALL
SELECT arrayJoin(range(10));
SET min_insert_block_size_rows = 10;
INSERT INTO numbers_squashed
SELECT arrayJoin(range(10)) AS number
UNION ALL
SELECT arrayJoin(range(10))
UNION ALL
SELECT arrayJoin(range(10))
UNION ALL
SELECT arrayJoin(range(100))
UNION ALL
SELECT arrayJoin(range(10));
DROP TABLE numbers_squashed;
