SELECT accurateCastOrDefault(-1, 'UInt8'), accurateCastOrDefault(5, 'UInt8');
SELECT accurateCastOrDefault(number + 127, 'Int8') AS x, accurateCastOrDefault(number + 127, 'Int8', toInt8(5)) AS x_with_default FROM numbers (2) ORDER BY number;
