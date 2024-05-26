SELECT id, `n.a`, `n.b`, toTypeName(`n.b`) FROM t_nested_modify ORDER BY id;
ALTER TABLE t_nested_modify MODIFY COLUMN `n.b` String;
DETACH TABLE t_nested_modify;
ATTACH TABLE t_nested_modify;
DROP TABLE t_nested_modify;
