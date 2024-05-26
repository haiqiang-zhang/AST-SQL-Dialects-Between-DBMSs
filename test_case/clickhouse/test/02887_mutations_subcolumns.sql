OPTIMIZE TABLE t_mutations_subcolumns FINAL;
SELECT count(), min(id) FROM t_mutations_subcolumns;
SET mutations_sync = 2;
ALTER TABLE t_mutations_subcolumns DELETE WHERE obj.k3 = 5;
DELETE FROM t_mutations_subcolumns WHERE obj.k1.k2 = 'fee';
ALTER TABLE t_mutations_subcolumns DELETE WHERE obj.k1 = ('foo', 'baz');
ALTER TABLE t_mutations_subcolumns UPDATE n = 'ttt' WHERE obj.k1.k2 = 'foo';
SELECT id, n FROM t_mutations_subcolumns;
DROP TABLE IF EXISTS t_mutations_subcolumns;
CREATE TABLE t_mutations_subcolumns (a UInt64, obj Object(Nullable('json')))
ENGINE = MergeTree ORDER BY a PARTITION BY a;
INSERT INTO t_mutations_subcolumns VALUES (1, '{"k1": 1}');
INSERT INTO t_mutations_subcolumns VALUES (2, '{"k2": 1}');
INSERT INTO t_mutations_subcolumns VALUES (3, '{"k3": 1}');
ALTER TABLE t_mutations_subcolumns DELETE WHERE obj.k2 = 1;
SELECT a, arrayFilter(x -> not isNull(x.2), tupleToNameValuePairs(obj)) FROM t_mutations_subcolumns ORDER BY a;
ALTER TABLE t_mutations_subcolumns DELETE WHERE isNull(obj.k1);
DROP TABLE t_mutations_subcolumns;
