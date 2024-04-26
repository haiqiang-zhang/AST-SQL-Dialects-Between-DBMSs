

CREATE TABLE t1 (f1 INT, f2 INT, f3 CHAR(1), f4 CHAR(1), f5 CHAR(1), f6 CHAR(1), f7 CHAR(1),
PRIMARY KEY (f5, f1), KEY (f2), KEY (f3), KEY (f4), KEY(f7) );
INSERT INTO t1 VALUES (1, 1, 'a', 'h', 'i', '', ''), (2, 3, 'a', 'h', 'i', '', ''),
                      (3, 2, 'b', '', 'j', '', ''), (4, 2, 'b', '', 'j', '', '');
INSERT INTO t1 VALUES (5, 1, 'a', 'h', 'i', '', ''), (6, 3, 'a', 'h', 'i', '', ''),
                      (7, 2, 'b', '', 'j', '', ''), (8, 2, 'b', '', 'j', '', '');
INSERT INTO t1 SELECT f1 + 8, f2, f3, f4, f5, f6, f7 FROM t1;
INSERT INTO t1 SELECT f1 + 16, f2, f3, f4, f5, f6, f7 FROM t1;
INSERT INTO t1 VALUES (33, 3, 'c', 'g', '', '', ''), (34, 4, 'c', 'g', '', '', ''),
                      (35, 5, 'd', 'f', '', '', ''), (36, 6, 'd', 'f', '', '', '');
INSERT INTO t1 SELECT f1 + 36, f2, f3, f4, f5, f6, f7 FROM t1;
INSERT INTO t1 SELECT f1 + 72, f2, f3, f4, f5, f6, f7 FROM t1;
INSERT INTO t1 SELECT f1 + 144, f2, f3, f4, f5, f6, f7 FROM t1;

-- Index merge intersection without hints.
EXPLAIN SELECT COUNT(*) FROM t1 WHERE f4 = 'h' AND f2 = 2;

-- Check behavior of duplicated hints.
-- First specified hint is applied and next conflicting hints are ignored with warning.

-- Hint INDEX_MERGE(t1 f2, f3, f4) is ignored as duplicated.
EXPLAIN SELECT /*+ INDEX_MERGE(t1) INDEX_MERGE(t1 f2, f3, f4) */ f2 FROM t1 WHERE f4 = 'h' AND f2 = 2 AND f3 = 'b';

-- Check behavior of unresolved hints.
-- Hints with unresolved argument is ignored with warning.

-- Hint is ignored, since table 't5' does not exist.
EXPLAIN SELECT /*+ INDEX_MERGE(t5) */ f2 FROM t1 WHERE f4 = 'h' AND f2 = 2 AND f3 = 'b';

-- Index merge intersection
-- Turn off automatic use of index merge intersection, so that we get to
-- test that the hints below are effective.
SET optimizer_switch='index_merge_intersection=off';

-- Index merge with clustered key
-- intersect(f3,f4), since 'f4, f3' indexes are specified in the hints and
-- there is no condition for index 'f2'.
EXPLAIN SELECT /*+ INDEX_MERGE(t1 f2, f4, f3) */ COUNT(*) FROM t1 WHERE f4 = 'h' AND f3 = 'b' AND f5 = 'i';

-- no index merge, since 'index_merge_intersection' optimizer switch is off.
EXPLAIN SELECT count(*) FROM t1 WHERE f2 = 3 AND f5 > '' AND f3 = 'c';

-- intersect(f4,f3), since it's the cheapest intersection.
EXPLAIN SELECT /*+ INDEX_MERGE(t1) */ COUNT(*) FROM t1 WHERE f4 = 'd' AND f2 = 2 AND f3 = 'b';

SET optimizer_switch='index_merge=off';
SET optimizer_switch='index_merge=on';

-- No index merge intersection
SET optimizer_switch='index_merge_intersection=on';

-- NO_INDEX_MERGE with clustered key
-- intersect(f3, PRIMARY), since it's the cheapest access method.
EXPLAIN SELECT count(*) FROM t1 WHERE f2 = 3 AND f5 > '' AND f3 = 'c';


-- no index merge, since ref access by 'f3' index is the cheapest access method.
EXPLAIN SELECT COUNT(*) FROM t1 WHERE f4 = 'x' AND f2 = 5 AND f3 = 'n';

-- no intersection, since not-equal condition can not be used for intersection.
EXPLAIN SELECT /*+ INDEX_MERGE(t1 f2, f4) */ COUNT(*) FROM t1 WHERE f4 = 'h' AND f2 > 2;

-- Index merge union
SET optimizer_switch='index_merge_union=off,index_merge=off';

SET optimizer_switch='index_merge_union=on,index_merge=on';

-- no union, since ref access by 'f2' index is cheapest access method.
EXPLAIN SELECT * FROM t1 WHERE f2 = 400 AND (f3 = 'x' OR f4 = 'n');

-- Index merge sort union
SET optimizer_switch='index_merge_sort_union=off,index_merge=off';

SET optimizer_switch='index_merge_sort_union=on,index_merge=on';

-- no sort_union, since full scan is the cheapest access method.
EXPLAIN SELECT * FROM t1 WHERE (f2 BETWEEN 1 AND 200 OR f3 = 'c') AND (f2 BETWEEN 1 AND 200 OR f4 = 'f');

-- union(f2,f3,f4), since it's the cheapest access method.
EXPLAIN SELECT f1 FROM t1 WHERE (f2 = 5 OR f3 = 'c' OR f4 = 'f') AND (f2 BETWEEN 1 AND 200 OR f3 = 'c');

-- Tests for INDEX_MERGE hint with no index specified.
SET optimizer_switch=default;

-- Test with IGNORE/FORCE INDEX
-- no union, since only 'f4' index can be used for index merge due to 'IGNORE INDEX' hint.
EXPLAIN SELECT /*+ INDEX_MERGE(t1 f3, f4) */ * FROM t1 IGNORE INDEX (f3) WHERE f2 = 400 AND (f3 = 'x' OR f4 = 'n');


ALTER TABLE t1 ADD KEY idx(f3, f4);


SET optimizer_switch= default;
DROP TABLE t1;

CREATE TABLE t1(f1 INT NOT NULL, f2 INT, f3 INT, PRIMARY KEY(f1), KEY(f2), KEY(f3));
DROP TABLE t1;

CREATE TABLE t1 (
  f1 VARCHAR(10) DEFAULT NULL,
  f2 INT(11) NOT NULL,
  f3 INT(11) DEFAULT NULL,
  PRIMARY KEY (f2),
  KEY f1 (f1),
  KEY f3 (f3)
);

INSERT INTO t1 VALUES ('b',1,NULL), ('h',5,NULL);

SELECT /*+ INDEX_MERGE(t1 f3, primary) */ f2 FROM t1
WHERE f1 = 'o' AND f2 = f3 AND f3 <= 4;

DROP TABLE t1;
