

--
-- Bug#26325 TEMPORARY TABLE "corrupt" after first read, according to CHECK TABLE
--

-- Repair table is supported only by MyISAM engine

let $global_tmp_storage_engine  = `select @@global.default_tmp_storage_engine`;
let $session_tmp_storage_engine = `select @@session.default_tmp_storage_engine`;

SET @@GLOBAL.default_tmp_storage_engine = MyISAM;
SET @@session.default_tmp_storage_engine = MyISAM;

SELECT @@global.default_tmp_storage_engine;
SELECT @@session.default_tmp_storage_engine;

CREATE TEMPORARY TABLE t1(a INT);
DROP TABLE t1;

-- Reset the variables to MTR default
eval SET @@global.default_tmp_storage_engine = $global_tmp_storage_engine;

SELECT @@global.default_tmp_storage_engine;
SELECT @@session.default_tmp_storage_engine;

CREATE TEMPORARY TABLE t1(a INT);
DROP TABLE t1;
CREATE TABLE t2(i INT) ENGINE=MYISAM;

ALTER TABLE t2 CHANGE COLUMN i j INT, ALGORITHM=INPLACE;

ALTER TABLE t2 CHANGE COLUMN j k INT, ALGORITHM=COPY;
DROP TABLE t2;
