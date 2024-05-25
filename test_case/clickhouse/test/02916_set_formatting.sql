DROP VIEW IF EXISTS v1;
CREATE TABLE t1 (v UInt64, s String) ENGINE=MergeTree() ORDER BY v;
CREATE VIEW v1 (v UInt64) AS SELECT v FROM t1 SETTINGS additional_table_filters = {'default.t1': 's != \'s1%\''};
DROP VIEW v1;
DROP TABLE t1;
