CREATE TABLE 02987_logical_optimizer_table (key Int, value Int) ENGINE=Memory();
CREATE VIEW v1 AS SELECT * FROM 02987_logical_optimizer_table;
CREATE TABLE 02987_logical_optimizer_merge AS v1 ENGINE=Merge(currentDatabase(), 'v1');
