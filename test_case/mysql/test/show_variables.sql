
-- Deprecation warning
SHOW GLOBAL VARIABLES WHERE Variable_name LIKE "abc";

-- No warnings
SHOW GLOBAL VARIABLES LIKE "abc";

-- Deprecation warning
SHOW SESSION VARIABLES WHERE Variable_name LIKE "abc";

-- No warnings
SHOW SESSION VARIABLES LIKE "abc";

-- Deprecation warning
SHOW VARIABLES WHERE Variable_name LIKE "abc";

-- No warnings
SHOW VARIABLES LIKE "abc";

CREATE TABLE t1 (i INT);

DROP TABLE t1;

CREATE TABLE t1(a INTEGER, b INTEGER, c INTEGER, d INTEGER);
SET @@sql_select_limit=1;
set @@sql_select_limit=2;
set @@sql_select_limit=DEFAULT;
DROP TABLE t1;
