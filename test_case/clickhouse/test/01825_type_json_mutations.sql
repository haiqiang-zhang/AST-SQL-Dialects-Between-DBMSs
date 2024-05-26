SELECT * FROM t_json_mutations ORDER BY id;
ALTER TABLE t_json_mutations DELETE WHERE id = 2;
SELECT * FROM t_json_mutations ORDER BY id;
ALTER TABLE t_json_mutations DROP COLUMN s, DROP COLUMN obj, ADD COLUMN t String DEFAULT 'foo';
SELECT * FROM t_json_mutations ORDER BY id;
DROP TABLE t_json_mutations;
