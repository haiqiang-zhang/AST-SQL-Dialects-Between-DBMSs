CREATE MATERIALIZED VIEW mv1 TO test1 AS SELECT a FROM test2;
CREATE MATERIALIZED VIEW mv2 TO test2 AS SELECT a FROM test1;
DROP TABLE test1;
DROP TABLE test2;
DROP TABLE mv1;
DROP TABLE mv2;