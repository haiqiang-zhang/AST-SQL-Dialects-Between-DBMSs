ALTER TABLE add_materialized_column_after ADD COLUMN y String MATERIALIZED toString(x) AFTER x;
DESC TABLE add_materialized_column_after;
DROP TABLE add_materialized_column_after;
