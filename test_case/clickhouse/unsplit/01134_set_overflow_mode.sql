SET max_block_size = 10;
SET max_rows_in_set = 20;
SET set_overflow_mode = 'throw';
SELECT arrayJoin([5, 25]) IN (SELECT DISTINCT toUInt8(intDiv(number, 10)) FROM numbers(190));
SET set_overflow_mode = 'break';
SELECT '---';
