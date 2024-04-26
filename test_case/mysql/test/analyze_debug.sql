
CREATE TABLE t1 (c1 INT PRIMARY KEY) ENGINE=INNODB;
INSERT INTO t1 VALUES (1);

CREATE TABLE t2 (c2 INT PRIMARY KEY) ENGINE=INNODB
PARTITION BY HASH (c2)
PARTITIONS 4;
INSERT INTO t2 VALUES (2);
SET DEBUG_SYNC="before_reset_query_plan SIGNAL first_select_ongoing WAIT_FOR second_select_finished";
SET DEBUG_SYNC="now WAIT_FOR first_select_ongoing";
SELECT c1 FROM t1;

SET DEBUG_SYNC="now SIGNAL second_select_finished";

SET DEBUG_SYNC="before_reset_query_plan SIGNAL first_select_ongoing WAIT_FOR second_select_finished";
SET DEBUG_SYNC="now WAIT_FOR first_select_ongoing";
SELECT c2 FROM t2;

SET DEBUG_SYNC="now SIGNAL second_select_finished";

DROP TABLE t1, t2;
