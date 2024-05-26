OPTIMIZE TABLE lwd_merge;
SELECT count() FROM system.parts WHERE database = currentDatabase() AND table = 'lwd_merge' AND active = 1;
DELETE FROM lwd_merge WHERE id % 10 > 0;
OPTIMIZE TABLE lwd_merge;
ALTER TABLE lwd_merge MODIFY SETTING exclude_deleted_rows_for_part_size_in_merge = 1;
DELETE FROM lwd_merge WHERE id % 100 == 0;
OPTIMIZE TABLE lwd_merge;
DROP TABLE IF EXISTS lwd_merge;
