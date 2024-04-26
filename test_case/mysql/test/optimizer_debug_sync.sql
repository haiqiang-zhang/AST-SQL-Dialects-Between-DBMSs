
CREATE TABLE t(i INT NOT NULL PRIMARY KEY, f INT) ENGINE = InnoDB;
INSERT INTO t VALUES (1,1),(2,2);
UPDATE t SET f=100 WHERE i=2;

set optimizer_switch='semijoin=off,subquery_materialization_cost_based=off';

SET DEBUG_SYNC='before_index_end_in_subselect WAIT_FOR callit';
let $show_statement= SHOW PROCESSLIST;
let $field= State;
let $condition= = 'debug sync point: before_index_end_in_subselect';

let $wait_condition=
  SELECT COUNT(*) = 2 FROM information_schema.processlist 
  WHERE state = 'Optimizing' and info = 'SELECT MAX(i) FROM t FOR UPDATE';

SET DEBUG_SYNC='now SIGNAL callit';
SET DEBUG_SYNC='RESET';
DROP TABLE t;
