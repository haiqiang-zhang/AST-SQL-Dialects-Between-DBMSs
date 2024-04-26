CREATE TABLE t1
(a smallint,
 b smallint,
 c smallint,
 KEY  a (a),
 KEY  b (b)
) ENGINE=InnoDB
PARTITION BY HASH(c) PARTITIONS 3;
INSERT INTO t1 VALUES (1,1,1), (1,1,1+3), (1,1,1+6), (1,1,1+9);
INSERT INTO t1 VALUES (1,2,1+12), (2,2,2+15), (2,2,2+18), (1,2,3+21);
INSERT INTO t1 VALUES (2,2,1+24);
INSERT INTO t1 VALUES (2,1,1+27);
CREATE TABLE t2 (a int primary key) ENGINE = InnoDB;
INSERT INTO t2 VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);
INSERT INTO t1 SELECT 1, 1, 97 FROM t2 LIMIT 10;
INSERT INTO t1 SELECT 2, 1, 98 FROM t2 LIMIT 4;
INSERT INTO t1 SELECT 1, 2, 99 FROM t2 LIMIT 4;

SET @old_opt_switch = @@session.optimizer_switch;
SET SESSION optimizer_switch="index_merge=on";
SET SESSION optimizer_switch="index_merge_intersection=on";
SET SESSION optimizer_switch="index_merge_sort_union=off";
SET SESSION optimizer_switch="index_merge_union=off";
SET SESSION optimizer_trace="enabled=on";
SELECT TRACE FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SELECT a,b,c FROM t1 WHERE b = 2 AND a = 2 AND  c > 0 AND c < 100;
SELECT a,b,c FROM t1 WHERE a = 2 AND b = 2 AND c IN (13,25,28);
SET SESSION optimizer_switch="index_merge_intersection=off";
SELECT a,b,c FROM t1 WHERE b = 2 AND a = 2 AND  c > 0 AND c < 100;
INSERT INTO t1 SELECT 1, 1, 97 FROM t2, t2 t3 LIMIT 32;
SET SESSION optimizer_switch="index_merge_union=on";
SELECT TRACE FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;

-- first row from both indexes done, first is b, 0x207 c = 24
-- Get next from b
-- b finds no more rows in p0.
-- b returns row from p2 (0x205) c = 17
-- Fetching whole row for (0x207) c = 24 (1,2,24) and sends it
-- b reads row N+2 (0x206) from p2 c = 20
-- b returns row from p2 (0x206) c = 20
-- No duplicate (0x206 != 0x208)
-- Fetching whole row for (0x205) c = 17 (2,2,17) and sends it
-- b finds no more rows in p2
-- b returns row from p1 (0x204) c = 13
-- No duplicate (0x205 != 0x206)
-- Fetching whole row for (0x206) c = 20 (2,2,20) and sends it
-- b reads row N+4 (0x208) from p1 c = 25
-- b returns row from p1 (0x208) c = 25
-- No duplicate (0x204 != 0x206)
-- Fetching whole row for (0x204) c = 13 (1,2,13) and sends it
-- Fetching whole row for (0x208) c = 25 (2,2,25)
-- a reads row N+5 (0x209) from p1 c = 28
-- a returns row from p1 (0x209) c = 28
-- Duplicate (0x209 == 0x209)
-- a returns row from p2 (0x205)
-- Fetching whole row for (0x209) c = 28 (2,1,28)
-- a reads row N+2 (0x206) from p2 c = 20
-- Fetching whole row for (0x205) c = 17 (2,2,17)
-- Fetching whole row for (0x206) c = 20 (2,2,20)

--sorted_result
SELECT a,b,c FROM t1 WHERE (b = 2 OR a = 2) AND  c > 0 AND c < 100;
SET SESSION optimizer_switch="index_merge_union=off";
SELECT a,b,c FROM t1 WHERE (b = 2 OR a = 2) AND  c > 0 AND c < 100;
INSERT INTO t1 SELECT 1, 1, 97 FROM t2, t2 t3 LIMIT 48;
SET SESSION optimizer_switch="index_merge_sort_union=on";
SELECT TRACE FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SET SESSION optimizer_trace="enabled=off";
SELECT a,b,c FROM t1 WHERE (b >= 2 OR a >= 2) AND  c > 0 AND c < 100;
SET SESSION optimizer_switch="index_merge_sort_union=off";
SELECT a,b,c FROM t1 WHERE (b >= 2 OR a >= 2) AND  c > 0 AND c < 100;

SET @@session.optimizer_switch = @old_opt_switch;
DROP TABLE t1, t2;
