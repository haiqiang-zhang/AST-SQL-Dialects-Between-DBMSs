-- Tag no-tsan: Fine thresholds on memory usage
-- Tag no-asan: Fine thresholds on memory usage
-- Tag no-msan: Fine thresholds on memory usage

-- each uniqCombined state should not use > sizeof(HLL) in memory,
-- sizeof(HLL) is (2^K * 6 / 8)
-- hence max_memory_usage for 100 rows = (96<<10)*100 = 9830400

SET use_uncompressed_cache = 0;
SELECT 'UInt32';
SET max_memory_usage = 4000000;
SELECT sum(u) FROM (SELECT intDiv(number, 8192) AS k, uniqCombined(number % 8192) u FROM numbers(8192 * 100) GROUP BY k);
SET max_memory_usage = 9830400;
SELECT sum(u) FROM (SELECT intDiv(number, 8192) AS k, uniqCombined(number % 8192) u FROM numbers(8192 * 100) GROUP BY k);
SELECT 'UInt64';
SET max_memory_usage = 4000000;
SELECT sum(u) FROM (SELECT intDiv(number, 4096) AS k, uniqCombined(reinterpretAsString(number % 4096)) u FROM numbers(4096 * 100) GROUP BY k);
SET max_memory_usage = 9830400;
SELECT sum(u) FROM (SELECT intDiv(number, 4096) AS k, uniqCombined(reinterpretAsString(number % 4096)) u FROM numbers(4096 * 100) GROUP BY k);
SELECT 'K=16';
SELECT 'UInt32';
SET max_memory_usage = 2000000;
SELECT sum(u) FROM (SELECT intDiv(number, 4096) AS k, uniqCombined(16)(number % 4096) u FROM numbers(4096 * 100) GROUP BY k);
SET max_memory_usage = 4915200;
SELECT sum(u) FROM (SELECT intDiv(number, 4096) AS k, uniqCombined(16)(number % 4096) u FROM numbers(4096 * 100) GROUP BY k);
SELECT 'UInt64';
SET max_memory_usage = 2000000;
SELECT sum(u) FROM (SELECT intDiv(number, 2048) AS k, uniqCombined(16)(reinterpretAsString(number % 2048)) u FROM numbers(2048 * 100) GROUP BY k);
SET max_memory_usage = 4915200;
SELECT sum(u) FROM (SELECT intDiv(number, 2048) AS k, uniqCombined(16)(reinterpretAsString(number % 2048)) u FROM numbers(2048 * 100) GROUP BY k);
SELECT 'K=18';
SELECT 'UInt32';
SET max_memory_usage = 8000000;
SELECT sum(u) FROM (SELECT intDiv(number, 16384) AS k, uniqCombined(18)(number % 16384) u FROM numbers(16384 * 100) GROUP BY k);
SET max_memory_usage = 19660800;
SELECT sum(u) FROM (SELECT intDiv(number, 16384) AS k, uniqCombined(18)(number % 16384) u FROM numbers(16384 * 100) GROUP BY k);
SELECT 'UInt64';
SET max_memory_usage = 8000000;
SELECT sum(u) FROM (SELECT intDiv(number, 8192) AS k, uniqCombined(18)(reinterpretAsString(number % 8192)) u FROM numbers(8192 * 100) GROUP BY k);
SET max_memory_usage = 19660800;
SELECT sum(u) FROM (SELECT intDiv(number, 8192) AS k, uniqCombined(18)(reinterpretAsString(number % 8192)) u FROM numbers(8192 * 100) GROUP BY k);