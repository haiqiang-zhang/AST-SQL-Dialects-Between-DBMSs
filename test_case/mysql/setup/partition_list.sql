drop table if exists t1;
CREATE TABLE t1 (a INT);
ALTER TABLE t1
PARTITION BY LIST(a)
(PARTITION p1 VALUES IN (1,2,3,4,5,6,7,8,9,10,
                         11,12,13,14,15,16,17,18,19,20));
ALTER TABLE t1 ADD PARTITION
(PARTITION p2 VALUES IN (21,22,23,24,25,26,27,28,29,30,
                         31,32,33,34,35,36,37,38,39,40));
ALTER TABLE t1
PARTITION BY LIST COLUMNS (a)
(PARTITION p1 VALUES IN (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20));
ALTER TABLE t1 ADD PARTITION
(PARTITION p2 VALUES IN (21,22,23,24,25,26,27,28,29,30,
                         31,32,33,34,35,36,37,38,39,40));
DROP TABLE t1;
CREATE TABLE t1
(a INT,
 b CHAR(2))
PARTITION BY LIST COLUMNS (a, b)
(PARTITION p0_a VALUES IN
((0, "a0"), (0, "a1"), (0, "a2"), (0, "a3"), (0, "a4"), (0, "a5"), (0, "a6"),
 (0, "a7"), (0, "a8"), (0, "a9"), (0, "aa"), (0, "ab"), (0, "ac"), (0, "ad"),
 (0, "ae"), (0, "af"), (0, "ag"), (0, "ah"), (0, "ai"), (0, "aj"), (0, "ak"),
 (0, "al")));
ALTER TABLE t1 ADD PARTITION
(PARTITION p1_a VALUES IN
((1, "a0"), (1, "a1"), (1, "a2"), (1, "a3"), (1, "a4"), (1, "a5"), (1, "a6"),
 (1, "a7"), (1, "a8"), (1, "a9"), (1, "aa"), (1, "ab"), (1, "ac"), (1, "ad"),
 (1, "ae"), (1, "af"), (1, "ag"), (1, "ah"), (1, "ai"), (1, "aj"), (1, "ak"),
 (1, "al")));
ALTER TABLE t1 ADD PARTITION
(PARTITION p2_a VALUES IN
(((1 + 1), "a0"), (2, "a1"), (2, "a2"), (2, "a3"), (2, "a4"), (2, "a5"),
 (2, "a6"), (2, "a7"), (2, "a8"), (2, "a9"), (2, "aa"), (2, "ab"), (2, "ac"),
 (2, "ad"), (2, "ae"), (2, "af"), (2, "ag"), (2, "ah"), (2, "ai"), (2, "aj"),
 (2, "ak"), (2, "al")));
ALTER TABLE t1 ADD PARTITION
(PARTITION p3_a VALUES IN ((1 + 1 + 1, "a0")));
DROP TABLE t1;
create table t1 (a int unsigned)
partition by list (a)
(partition p0 values in (0),
 partition p1 values in (1),
 partition pnull values in (null),
 partition p2 values in (2));
insert into t1 values (null),(0),(1),(2);
