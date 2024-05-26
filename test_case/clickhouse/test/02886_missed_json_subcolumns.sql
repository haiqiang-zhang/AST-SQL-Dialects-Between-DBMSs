OPTIMIZE TABLE t_missed_subcolumns FINAL;
SELECT count(), min(id) FROM t_missed_subcolumns;
ALTER TABLE t_missed_subcolumns DELETE WHERE obj.k4 = 5;
DELETE FROM t_missed_subcolumns WHERE obj.k1.k3 = 'fee';
DROP TABLE IF EXISTS t_missed_subcolumns;
