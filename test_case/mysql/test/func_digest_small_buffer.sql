
let $statement_digest_a=statement_digest( 'SELECT 1' );
let $statement_digest_b=statement_digest( 'SELECT 1 FROM DUAL' );

let $compare_digests_fn=statement_digest;
let $compare_digests_query=SELECT $statement_digest_a IS NULL;
let $compare_digests_pfs_query=SELECT $statement_digest_b IS NULL;
let $compare_digests_pfs_column=digest;

let $compare_digests_fn=statement_digest_text;
let $compare_digests_query=SELECT $statement_digest_a IS NULL;
let $compare_digests_pfs_query=SELECT $statement_digest_b IS NULL;
let $compare_digests_pfs_column=digest_text;
CREATE TABLE t1 AS SELECT statement_digest_text( 'select 1, 2, 3' ) AS digest;
DROP TABLE t1;

SELECT statement_digest_text( 'SELECT 1' );
