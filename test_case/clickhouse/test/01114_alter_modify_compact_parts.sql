ALTER TABLE mt_compact MODIFY COLUMN s UInt64;
SELECT sum(s) from mt_compact;
DROP TABLE IF EXISTS mt_compact;
