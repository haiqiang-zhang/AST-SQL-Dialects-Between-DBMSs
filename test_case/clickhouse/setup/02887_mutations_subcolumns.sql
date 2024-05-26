DROP TABLE IF EXISTS t_mutations_subcolumns;
SET allow_experimental_object_type = 1;
CREATE TABLE t_mutations_subcolumns (id UInt64, n String, obj Object(Nullable('json')))
ENGINE = MergeTree ORDER BY id;
INSERT INTO t_mutations_subcolumns VALUES (1, 'aaa', '{"k1": {"k2": "foo"}, "k3": 5}');
INSERT INTO t_mutations_subcolumns VALUES (2, 'bbb', '{"k1": {"k2": "fee"}, "k3": 4}');
INSERT INTO t_mutations_subcolumns VALUES (3, 'ccc', '{"k1": {"k2": "foo", "k4": "baz"}, "k3": 4}');
INSERT INTO t_mutations_subcolumns VALUES (4, 'ddd', '{"k1": {"k2": "foo"}, "k3": 4}');
INSERT INTO t_mutations_subcolumns VALUES (5, 'eee', '{"k1": {"k2": "foo"}, "k3": 4}');
INSERT INTO t_mutations_subcolumns VALUES (6, 'fff', '{"k1": {"k2": "foo"}, "k3": 4}');
