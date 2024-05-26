DROP TEMPORARY TABLE IF EXISTS temp_tab;
CREATE TEMPORARY TABLE temp_tab (number UInt64);
INSERT INTO temp_tab SELECT number FROM system.numbers LIMIT 1;
