SELECT '---';
SET allow_experimental_object_type = 1;
CREATE TABLE tab
(
    id UInt64,
    tup Tuple(UInt64, UInt64) SETTINGS (min_compress_block_size = 81920, max_compress_block_size = 163840),
    json JSON SETTINGS (min_compress_block_size = 81920, max_compress_block_size = 163840),
)
ENGINE = MergeTree
ORDER BY id
SETTINGS min_bytes_for_wide_part = 1;
INSERT INTO TABLE tab SELECT number, tuple(number, number), concat('{"key": ', toString(number), ' ,"value": ', toString(rand(number+1)), '}') FROM numbers(1000);
SELECT tup, json.key AS key FROM tab ORDER BY key LIMIT 10;
DROP TABLE tab;
SELECT '---';
