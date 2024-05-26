SET allow_suspicious_low_cardinality_types=1;
SELECT arrayFold((acc, x) -> (acc + (x * 2)), [1, 2, 3, 4], toInt64(3));
