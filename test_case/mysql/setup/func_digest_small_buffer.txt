CREATE TABLE t1 AS SELECT statement_digest_text( 'select 1, 2, 3' ) AS digest;
DROP TABLE t1;
