SELECT count(), sum(v), arraySort(groupUniqArray(id % 10)) FROM t_lwd_mutations;
SELECT count(), sum(rows), sum(has_lightweight_delete) FROM system.parts WHERE database = currentDatabase() AND table = 't_lwd_mutations' AND active;
ALTER TABLE t_lwd_mutations UPDATE v = 1 WHERE id % 4 = 0, DELETE WHERE id % 10 = 1;
DELETE FROM t_lwd_mutations WHERE id % 10 = 2;
ALTER TABLE t_lwd_mutations UPDATE v = 1 WHERE id % 4 = 1, DELETE WHERE id % 10 = 3;
ALTER TABLE t_lwd_mutations UPDATE _row_exists = 0 WHERE id % 10 = 4, DELETE WHERE id % 10 = 5;
ALTER TABLE t_lwd_mutations DELETE WHERE id % 10 = 6, UPDATE _row_exists = 0 WHERE id % 10 = 7;
ALTER TABLE t_lwd_mutations APPLY DELETED MASK;
DROP TABLE IF EXISTS t_lwd_mutations;
