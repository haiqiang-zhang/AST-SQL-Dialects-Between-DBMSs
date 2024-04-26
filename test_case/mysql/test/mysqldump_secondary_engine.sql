
CREATE TABLE t1 (a INT) SECONDARY_ENGINE=gizmo;

SET SESSION show_create_table_skip_secondary_engine=on;
SET SESSION show_create_table_skip_secondary_engine=default;

DROP TABLE t1;
