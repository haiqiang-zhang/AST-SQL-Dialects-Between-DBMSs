SELECT length(repeat('x', 1000000));
SET max_memory_usage = 100000000;
SELECT repeat(toString(number), number) FROM system.numbers LIMIT 11;
