
-- Does not contain the sync points;

SET @old_debug= @@session.debug;

CREATE TABLE g9(a INT) ENGINE=INNODB;

let $query=SELECT 1 FROM g9
RIGHT JOIN (SELECT 1 FROM g9) AS d1 ON 1 LEFT JOIN
(SELECT 1 FROM g9) AS d2 ON 1;

SET debug= '+d,bug13820776_1';
SET debug= '-d,bug13820776_1';

SET debug= '+d,bug13820776_2';
SET debug= '-d,bug13820776_2';

DROP TABLE g9;
SET debug= @old_debug;

CREATE TABLE g1(a INT PRIMARY KEY, b INT) ENGINE=INNODB;
INSERT INTO g1 VALUES (1,2),(2,3),(4,5);
CREATE TABLE g2(a INT PRIMARY KEY, b INT) ENGINE=INNODB;
INSERT INTO g2 VALUES (1,2),(2,3),(4,5);

let $query=UPDATE IGNORE g1,g2 SET g1.b=0 WHERE g1.a=g2.a;

SET debug= '+d,bug13820776_2';
SET debug= '-d,bug13820776_2';

SET debug= '+d,bug13822652_1';
SET debug= '-d,bug13822652_1';

let $query=INSERT IGNORE INTO g1(a) SELECT b FROM g1 WHERE a<=0 LIMIT 5;

SET debug= '+d,bug13822652_2';
SET debug= '-d,bug13822652_2';

DROP TABLE g1,g2;

SET GLOBAL innodb_limit_optimistic_insert_debug = 2;

CREATE TABLE t_innodb(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL,
                      c3 char(20),
                      KEY c3_idx(c3))ENGINE=INNODB;

INSERT INTO t_innodb VALUES (1, 1, 'a'), (2,2,'a'), (3,3,'a');

SET debug= '+d,bug28079850';
SELECT COUNT(*) FROM t_innodb;
SELECT COUNT(*) FROM performance_schema.table_handles;
SET debug= '-d,bug28079850';

DROP TABLE t_innodb;

SET debug= @old_debug;
SET DEBUG_SYNC='before_command_dispatch SIGNAL kill_query WAIT_FOR continue';
SET DEBUG_SYNC='now WAIT_FOR kill_query';
SET DEBUG_SYNC='now SIGNAL continue';
SET DEBUG_SYNC='RESET';

SET GLOBAL innodb_limit_optimistic_insert_debug = 0;
