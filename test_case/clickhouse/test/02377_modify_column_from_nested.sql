SELECT id, `n.a`, `n.b`, toTypeName(`n.b`) FROM t_nested_modify ORDER BY id;
ALTER TABLE t_nested_modify MODIFY COLUMN `n.b` String;
SELECT id, `n.a`, `n.b`, toTypeName(`n.b`) FROM t_nested_modify ORDER BY id;
DETACH TABLE t_nested_modify;
ATTACH TABLE t_nested_modify;
SELECT id, `n.a`, `n.b`, toTypeName(`n.b`) FROM t_nested_modify ORDER BY id;
DROP TABLE t_nested_modify;
