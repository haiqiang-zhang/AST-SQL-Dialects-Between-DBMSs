
-- This test case are added in order to test code that is not covered by
-- existing test cases, focusing gcov test coverage.


--echo --
--echo -- A) Test code handling virtual columns in mysqldump tool.
--echo --

SET timestamp=1;
CREATE DATABASE test1;
use test1;
CREATE TABLE t1 (a1 INTEGER,
                 a2 INTEGER GENERATED ALWAYS AS (a1 * 2) STORED,
                 a3 INTEGER GENERATED ALWAYS AS (a1 * 3) VIRTUAL,
                 KEY (a1) );

DROP TABLE t1;
DROP DATABASE test1;
