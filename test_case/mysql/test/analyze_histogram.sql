
CREATE TABLE t1 (c1 INT) ENGINE=INNODB;
INSERT INTO t1 VALUES (1), (2);
SET DEBUG_SYNC="before_reset_query_plan SIGNAL first_select_ongoing WAIT_FOR second_select_finished";
SET DEBUG_SYNC="now WAIT_FOR first_select_ongoing";

-- Without the patch, this SELECT would wait indefinitely.
SELECT c1 FROM t1;

SET DEBUG_SYNC="now SIGNAL second_select_finished";
SET DEBUG_SYNC="before_reset_query_plan SIGNAL first_select_ongoing WAIT_FOR second_select_finished";
SET DEBUG_SYNC="now WAIT_FOR first_select_ongoing";

-- Without the patch, this SELECT would wait indefinitely.
SELECT c1 FROM t1;

SET DEBUG_SYNC="now SIGNAL second_select_finished";
SET DEBUG_SYNC="after_table_open SIGNAL first_histogram_acquired WAIT_FOR second_histogram_acquired";
SET DEBUG_SYNC="now WAIT_FOR first_histogram_acquired";
UPDATE t1 SET c1 = 3 WHERE c1 = 2;
SET DEBUG_SYNC="after_table_open SIGNAL second_histogram_acquired";

DROP TABLE t1;
