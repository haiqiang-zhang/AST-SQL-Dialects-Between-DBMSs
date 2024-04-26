
--
-- Bug #28499: crash for grouping query when tmp_table_size is too small
--

DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
  a varchar(32) character set utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  b varchar(32) character set utf8mb3 COLLATE utf8mb3_bin NOT NULL )
DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES
  ('AAAAAAAAAA','AAAAAAAAAA'), ('AAAAAAAAAB','AAAAAAAAAB '),
  ('AAAAAAAAAB','AAAAAAAAAB'), ('AAAAAAAAAC','AAAAAAAAAC'),
  ('AAAAAAAAAD','AAAAAAAAAD'), ('AAAAAAAAAE','AAAAAAAAAE'),
  ('AAAAAAAAAF','AAAAAAAAAF'), ('AAAAAAAAAG','AAAAAAAAAG'),
  ('AAAAAAAAAH','AAAAAAAAAH'), ('AAAAAAAAAI','AAAAAAAAAI'),
  ('AAAAAAAAAJ','AAAAAAAAAJ'), ('AAAAAAAAAK','AAAAAAAAAK');

set session internal_tmp_mem_storage_engine='memory';
set tmp_table_size=1024;

-- Set debug flag so an error is returned when
-- tmp table in query is converted from heap to myisam
set session debug="d,raise_error";
SELECT MAX(a) FROM t1 GROUP BY a,b;

-- Same with a CTE, referenced multiple times;
(
  SELECT 1 FROM t1, t1 t2, t1 t3, t1 t4 LIMIT 100000000
)
SELECT * FROM qn qn0 WHERE z = (SELECT z FROM qn qn1 LIMIT 1);

set tmp_table_size=default;
set session internal_tmp_mem_storage_engine=default;
DROP TABLE t1;
CREATE TABLE t1 (a INT(100) NOT NULL);
INSERT INTO t1 VALUES (1), (0), (2);
SET SESSION debug='+d,alter_table_only_index_change';
ALTER TABLE t1 ADD INDEX a(a);
SET SESSION debug=DEFAULT;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1(a BLOB);
SET SESSION debug="+d,bug42064_simulate_oom";
INSERT INTO t1 VALUES("");
SET SESSION debug=DEFAULT;

DROP TABLE t1;

-- echo --
-- echo -- Bug#41660: Sort-index_merge for non-first join table may require 
-- echo -- O(#scans) memory
-- echo --

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE t2 (a INT, b INT, filler CHAR(100), KEY(a), KEY(b));
INSERT INTO t2 SELECT 1000, 1000, 'filler' FROM t1 A, t1 B, t1 C;
INSERT INTO t2 VALUES (1, 1, 'data');

SET SESSION debug = '+d,only_one_Unique_may_be_created';
SELECT * FROM t1 LEFT JOIN t2 ON ( t2.a < 10 OR t2.b < 10 );
SELECT * FROM t1 LEFT JOIN t2 ON ( t2.a < 10 OR t2.b < 10 );

SET SESSION debug = DEFAULT;

DROP TABLE t1, t2;

-- filesort.cc
create table t1(a int) ;
insert into t1 values(1),(2),(3);

-- Do not mtr.add_suppression here, avoid "Deadlock found ..." messages in log.
set debug='d,bug19656296';
select * from t1 order by a;
drop table t1;
SET debug= DEFAULT;
