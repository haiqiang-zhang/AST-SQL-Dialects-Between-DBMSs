CREATE VIEW v1 AS SELECT 42;
SELECT * FROM pg_views

query IIIIII nosort pg_view
SELECT * FROM pg_catalog.pg_views

query II
SELECT viewname, viewowner FROM pg_views WHERE viewname='v1';
