SELECT id FROM t
ANY LEFT JOIN joint ON t.id = joint.id;
DROP TABLE joint;
DROP TABLE t;
