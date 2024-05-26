SET default_null_order='nulls_first';
PRAGMA enable_verification;
create table mads as select range r from range(20) union all values (NULL), (NULL), (NULL);
CREATE TABLE coverage AS SELECT * FROM (VALUES
	(1), (2), (3), (1)
	) tbl(r);
