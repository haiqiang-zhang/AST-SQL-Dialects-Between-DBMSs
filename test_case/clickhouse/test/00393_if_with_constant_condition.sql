SELECT 1 ? 1 : 0;
SELECT 0 ? not_existing_column : 1 FROM system.numbers LIMIT 1;
SELECT 1 ? (0 ? not_existing_column : 2) : 0 FROM system.numbers LIMIT 1;
/* scalar subquery optimization */
SELECT (SELECT toUInt8(number + 1) FROM system.numbers LIMIT 1) ? 1 : 2 FROM system.numbers LIMIT 1;
