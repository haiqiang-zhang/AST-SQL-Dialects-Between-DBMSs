DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (id INT) engine=innodb;
SET DEBUG_SYNC='ha_admin_try_alter SIGNAL optimize_started WAIT_FOR table_altered';
SET DEBUG_SYNC='now WAIT_FOR optimize_started';
ALTER TABLE t1 engine=memory;
SET DEBUG_SYNC='now SIGNAL table_altered';
DROP TABLE t1;
SET DEBUG_SYNC='RESET';
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT) ENGINE= InnoDB;
SET DEBUG_SYNC= "ha_admin_open_ltable SIGNAL opening WAIT_FOR dropped";
SET DEBUG_SYNC= "now WAIT_FOR opening";
DROP TABLE t1;
SET DEBUG_SYNC= "now SIGNAL dropped";
SET DEBUG_SYNC= "RESET";
DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1(a INT) Engine=InnoDB;
CREATE TABLE t2(id INT);
INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES(connection_id());
SET DEBUG_SYNC= "open_and_process_table SIGNAL opening WAIT_FOR killed";
SET DEBUG_SYNC= "now WAIT_FOR opening";
SELECT ((@id := id) - id) FROM t2;
SET DEBUG_SYNC= "now SIGNAL killed";
DROP TABLE t1, t2;
SET DEBUG_SYNC= "RESET";
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (1), (2);
let $ID= `SELECT connection_id()`;
SET DEBUG_SYNC= 'ha_admin_open_ltable SIGNAL waiting WAIT_FOR killed';
SET DEBUG_SYNC= 'now WAIT_FOR waiting';
SET DEBUG_SYNC= 'now SIGNAL killed';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';
DROP DATABASE IF EXISTS db1;
DROP TABLE IF EXISTS t1;
CREATE DATABASE db1;
CREATE TABLE db1.t1(id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, value INT) engine=innodb;
INSERT INTO db1.t1(value) VALUES (1), (2);
SET DEBUG_SYNC= "alter_table_inplace_after_lock_downgrade SIGNAL manage WAIT_FOR query";
SET DEBUG_SYNC= "now WAIT_FOR manage";
USE db1;
SELECT * FROM t1;
SET DEBUG_SYNC= "now SIGNAL query";
DROP DATABASE db1;

CREATE TABLE t1(a INT NOT NULL, b INT NOT NULL) engine=innodb;
SET DEBUG_SYNC= "alter_table_inplace_after_lock_downgrade SIGNAL manage WAIT_FOR query";
SET DEBUG_SYNC= "now WAIT_FOR manage";
USE test;
SELECT * FROM t1;
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for table metadata lock'
  AND info='UPDATE t1 SET a=NULL';
SET DEBUG_SYNC= "now SIGNAL query";
ALTER TABLE t1 DROP INDEX a;
SET DEBUG_SYNC= "alter_table_inplace_after_lock_downgrade SIGNAL manage WAIT_FOR query";
SET DEBUG_SYNC= "now WAIT_FOR manage";
SELECT * FROM t1;
let $wait_condition= SELECT COUNT(*)= 1 FROM information_schema.processlist
  WHERE state= 'Waiting for table metadata lock'
  AND info='UPDATE t1 SET a=NULL';
SET DEBUG_SYNC= "now SIGNAL query";
SET DEBUG_SYNC= "alter_table_inplace_after_lock_downgrade SIGNAL manage WAIT_FOR query";
SET DEBUG_SYNC= "now WAIT_FOR manage";
SELECT * FROM t1;
SET DEBUG_SYNC= "now SIGNAL query";
SET DEBUG_SYNC= "RESET";
DROP TABLE t1;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT NOT NULL, b INT NOT NULL) engine=innodb;
INSERT INTO t1 VALUES (1, 12345), (2, 23456);
SET SESSION debug= "+d,alter_table_rollback_new_index";
ALTER TABLE t1 ADD PRIMARY KEY(a);
SELECT * FROM t1;
SELECT * FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
DROP DATABASE IF EXISTS db1;

CREATE TABLE t1(a int) engine=InnoDB;
CREATE DATABASE db1;
SET DEBUG_SYNC= 'after_innobase_rename_table SIGNAL locked WAIT_FOR continue';
SET DEBUG_SYNC= 'now WAIT_FOR locked';
let $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE state = "Waiting for schema metadata lock" and
        info = "DROP DATABASE db1";
SET DEBUG_SYNC= 'now SIGNAL continue';
SET DEBUG_SYNC= 'RESET';
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT PRIMARY KEY, b INT) engine=InnoDB;
INSERT INTO t1 VALUES (1,1), (2,2);
SET DEBUG_SYNC= 'RESET';
SET SESSION lock_wait_timeout= 1;
SET DEBUG_SYNC= 'alter_opened_table SIGNAL opened WAIT_FOR continue1';
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_upgrade SIGNAL upgraded WAIT_FOR continue2';
SET DEBUG_SYNC= 'alter_table_inplace_before_commit SIGNAL beforecommit WAIT_FOR continue3';
SET DEBUG_SYNC= 'alter_table_before_main_binlog SIGNAL binlog WAIT_FOR continue4';
SET DEBUG_SYNC= 'now WAIT_FOR opened';
SELECT * FROM t1;
INSERT INTO t1 VALUES (3,3);

SET DEBUG_SYNC= 'now SIGNAL continue1';
SET DEBUG_SYNC= 'now WAIT_FOR upgraded';
SELECT * FROM t1;
INSERT INTO t1 VALUES (4,4);

SET DEBUG_SYNC= 'now SIGNAL continue2';
SET DEBUG_SYNC= 'now WAIT_FOR beforecommit';
SELECT * FROM t1;
INSERT INTO t1 VALUES (5,5);

SET DEBUG_SYNC= 'now SIGNAL continue3';
SET DEBUG_SYNC= 'now WAIT_FOR binlog';
SELECT * FROM t1;
INSERT INTO t1 VALUES (6,6);

SET DEBUG_SYNC= 'now SIGNAL continue4';
SET DEBUG_SYNC= 'RESET';
DELETE FROM t1 WHERE a= 3;

SET DEBUG_SYNC= 'alter_opened_table SIGNAL opened WAIT_FOR continue1';
SET DEBUG_SYNC= 'alter_table_copy_after_lock_upgrade SIGNAL upgraded WAIT_FOR continue2';
SET DEBUG_SYNC= 'alter_table_before_main_binlog SIGNAL binlog WAIT_FOR continue3';
SET DEBUG_SYNC= 'now WAIT_FOR opened';
SELECT * FROM t1;
INSERT INTO t1 VALUES (3,3);

SET DEBUG_SYNC= 'now SIGNAL continue1';
SET DEBUG_SYNC= 'now WAIT_FOR upgraded';
SELECT * FROM t1;
INSERT INTO t1 VALUES (4,4);

SET DEBUG_SYNC= 'now SIGNAL continue2';
SET DEBUG_SYNC= 'now WAIT_FOR binlog';
SELECT * FROM t1 limit 1;
INSERT INTO t1 VALUES (5,5);

SET DEBUG_SYNC= 'now SIGNAL continue3';
SET DEBUG_SYNC= 'RESET';
DELETE FROM t1 WHERE a= 3;
SET DEBUG_SYNC= 'alter_opened_table SIGNAL opened WAIT_FOR continue1';
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_upgrade SIGNAL upgraded WAIT_FOR continue2';
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_downgrade SIGNAL downgraded WAIT_FOR continue3';
SET DEBUG_SYNC= 'alter_table_inplace_before_commit SIGNAL beforecommit WAIT_FOR continue4';
SET DEBUG_SYNC= 'alter_table_before_main_binlog SIGNAL binlog WAIT_FOR continue5';
SET DEBUG_SYNC= 'now WAIT_FOR opened';
SELECT * FROM t1;
INSERT INTO t1 VALUES (3,3);

SET DEBUG_SYNC= 'now SIGNAL continue1';
SET DEBUG_SYNC= 'now WAIT_FOR upgraded';
SELECT * FROM t1;
INSERT INTO t1 VALUES (4,4);

SET DEBUG_SYNC= 'now SIGNAL continue2';
SET DEBUG_SYNC= 'now WAIT_FOR downgraded';
SELECT * FROM t1;
INSERT INTO t1 VALUES (5,5);

SET DEBUG_SYNC= 'now SIGNAL continue3';
SET DEBUG_SYNC= 'now WAIT_FOR beforecommit';
SELECT * FROM t1;
INSERT INTO t1 VALUES (6,6);

SET DEBUG_SYNC= 'now SIGNAL continue4';
SET DEBUG_SYNC= 'now WAIT_FOR binlog';
SELECT * FROM t1;
INSERT INTO t1 VALUES (7,7);

SET DEBUG_SYNC= 'now SIGNAL continue5';
SET DEBUG_SYNC= 'RESET';
DELETE FROM t1 WHERE a= 3 OR a= 4;
SET DEBUG_SYNC= 'alter_opened_table SIGNAL opened WAIT_FOR continue1';
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_upgrade SIGNAL upgraded WAIT_FOR continue2';
SET DEBUG_SYNC= 'alter_table_inplace_before_commit SIGNAL beforecommit WAIT_FOR continue3';
SET DEBUG_SYNC= 'alter_table_before_main_binlog SIGNAL binlog WAIT_FOR continue4';
SET DEBUG_SYNC= 'now WAIT_FOR opened';
SELECT * FROM t1;
INSERT INTO t1 VALUES (3,3);

SET DEBUG_SYNC= 'now SIGNAL continue1';
SET DEBUG_SYNC= 'now WAIT_FOR upgraded';
SELECT * FROM t1;
INSERT INTO t1 VALUES (4,4);

SET DEBUG_SYNC= 'now SIGNAL continue2';
SET DEBUG_SYNC= 'now WAIT_FOR beforecommit';
SELECT * FROM t1;
INSERT INTO t1 VALUES (5,5);

SET DEBUG_SYNC= 'now SIGNAL continue3';
SET DEBUG_SYNC= 'now WAIT_FOR binlog';
SELECT * FROM t1;
INSERT INTO t1 VALUES (6,6);

SET DEBUG_SYNC= 'now SIGNAL continue4';
SET DEBUG_SYNC= 'RESET';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';

SET DEBUG_SYNC= 'alter_table_inplace_after_lock_downgrade SIGNAL downgraded WAIT_FOR continue';
CREATE TABLE t1(fld1 INT, fld2 INT, fld3 INT) ENGINE= INNODB;
INSERT INTO t1 VALUES (155, 45, 55);
SET DEBUG_SYNC= 'now WAIT_FOR downgraded';
INSERT INTO t1 VALUES (10, 11, 12);
UPDATE t1 SET fld1= 20 WHERE fld1= 155;
DELETE FROM t1 WHERE fld1= 20;
SELECT * from t1;
SET DEBUG_SYNC= 'now SIGNAL continue';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';

SET DEBUG_SYNC= 'alter_table_inplace_after_lock_downgrade SIGNAL downgraded WAIT_FOR continue';
CREATE TABLE t1(fld1 INT) ENGINE= INNODB PARTITION BY HASH(fld1) PARTITIONS 4;
INSERT INTO t1 VALUES(10);
SET DEBUG_SYNC= 'now WAIT_FOR downgraded';
INSERT INTO t1 VALUES (30);
UPDATE t1 SET fld1= 20 WHERE fld1= 10;
DELETE FROM t1 WHERE fld1= 20;
SELECT * from t1;
SET DEBUG_SYNC= 'now SIGNAL continue';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(fld1 INT, fld2 INT);
INSERT INTO t1 VALUES(10, 20);
ALTER TABLE t1 FORCE;
ALTER TABLE t1 ENGINE=INNODB;
SET SESSION old_alter_table= TRUE;
ALTER TABLE t1 FORCE;
ALTER TABLE t1 ENGINE= INNODB;

SET DEBUG_SYNC= 'alter_table_copy_after_lock_upgrade SIGNAL upgraded';
SET DEBUG_SYNC= 'now WAIT_FOR upgraded';
INSERT INTO t1 VALUES(10, 20);
SET DEBUG_SYNC= 'RESET';
SET SESSION old_alter_table= FALSE;
ALTER TABLE t1 FORCE, ALGORITHM= COPY;
ALTER TABLE t1 ENGINE= INNODB, ALGORITHM= COPY;
DROP TABLE t1;

SET DEBUG_SYNC= 'alter_table_copy_after_lock_upgrade SIGNAL upgraded';
CREATE TABLE t1(fld1 CHAR(10), FULLTEXT(fld1)) ENGINE= INNODB;
INSERT INTO t1 VALUES("String1");
SET DEBUG_SYNC= 'now WAIT_FOR upgraded';
INSERT INTO t1 VALUES("String2");
SET DEBUG_SYNC= 'RESET';
DROP TABLE t1;
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_downgrade SIGNAL downgraded WAIT_FOR continue';
CREATE TABLE t1(fld1 INT) ENGINE= INNODB PARTITION BY HASH(fld1) PARTITIONS 4;
INSERT INTO t1 VALUES(10);
SET DEBUG_SYNC= 'now WAIT_FOR downgraded';
INSERT INTO t1 VALUES (30);
UPDATE t1 SET fld1= 20 WHERE fld1= 10;
DELETE FROM t1 WHERE fld1= 20;
SELECT * from t1;
SET DEBUG_SYNC= 'now SIGNAL continue';
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'alter_table_inplace_after_lock_downgrade SIGNAL downgraded WAIT_FOR continue';
SET DEBUG_SYNC= 'now WAIT_FOR downgraded';
INSERT INTO t1 VALUES (30);
UPDATE t1 SET fld1= 20 WHERE fld1= 10;
DELETE FROM t1 WHERE fld1= 20;
SELECT * from t1;
SET DEBUG_SYNC= 'now SIGNAL continue';
SET DEBUG_SYNC= 'RESET';
ALTER TABLE t1;
SET DEBUG_SYNC = 'row_log_table_apply1_before SIGNAL rebuild';
SET DEBUG_SYNC= 'now WAIT_FOR rebuild';

SET DEBUG_SYNC= 'RESET';

SET DEBUG_SYNC = 'row_log_table_apply1_before SIGNAL rebuild';
SET DEBUG_SYNC= 'now WAIT_FOR rebuild';

SET DEBUG_SYNC= 'RESET';
DROP TABLE t1;

CREATE TABLE t1(f1 INT NOT NULL, PRIMARY KEY(f1)) ENGINE=INNODB;
CREATE TABLE t2(f2 INT NOT NULL, foreign key(f2) REFERENCES t1(f1)
                ON DELETE CASCADE)ENGINE=INNODB;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1);
SET DEBUG_SYNC= 'alter_after_copy_table SIGNAL delete_parent WAIT_FOR delete_child';
SET DEBUG_SYNC= 'now WAIT_FOR delete_parent';
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                     WHERE INFO='DELETE FROM t1 WHERE f1 = 1' and
                     STATE='Waiting for table metadata lock';
SET DEBUG_SYNC= 'now SIGNAL delete_child';
SELECT * FROM t2;
SELECT * FROM t1;
DROP TABLE t2, t1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(f1 INT NOT NULL, PRIMARY KEY(f1))ENGINE=INNODB;
CREATE TABLE t2(f2 INT NOT NULL, FOREIGN KEY(f2) REFERENCES t1(f1) ON DELETE CASCADE)ENGINE=INNODB;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1);

SET DEBUG_SYNC='innodb_commit_inplace_alter_table_enter SIGNAL delete_parent WAIT_FOR alter_child';
SET DEBUG_SYNC='now WAIT_FOR delete_parent';
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                     WHERE INFO='DELETE FROM t1 WHERE f1 = 1' and
                     STATE='Waiting for table metadata lock';
SET DEBUG_SYNC='now signal alter_child';
DROP TABLE t2, t1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(f1 INT NOT NULL, PRIMARY KEY(f1)) ENGINE=INNODB;
CREATE TABLE t2(f2 INT NOT NULL, f3 INT NOT NULL, FOREIGN KEY(f2)
                REFERENCES t1(f1) ON DELETE CASCADE,
                PRIMARY KEY(f3))ENGINE=INNODB;
CREATE TABLE t3(f4 INT NOT NULL, FOREIGN KEY(f4) REFERENCES t2(f3)
                ON DELETE CASCADE) ENGINE=INNODB;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1, 2);
INSERT INTO t3 VALUES(2);
SET DEBUG_SYNC= 'alter_after_copy_table SIGNAL delete_parent_parent WAIT_FOR delete_child';
SET DEBUG_SYNC= 'now WAIT_FOR delete_parent_parent';
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                     WHERE INFO='DELETE FROM t1 WHERE f1 = 1' and
                     STATE='Waiting for table metadata lock';
SET DEBUG_SYNC= 'now SIGNAL delete_child';
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM t3;

DROP TABLE t3, t2, t1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(f1 INT NOT NULL, PRIMARY KEY(f1))ENGINE=INNODB;
CREATE TABLE t2(f2 INT NOT NULL, f3 INT NOT NULL, FOREIGN KEY(f2)
                REFERENCES t1(f1) ON DELETE CASCADE,
                PRIMARY KEY(f3))ENGINE=INNODB;
CREATE TABLE t3(f4 INT NOT NULL, FOREIGN KEY(f4) REFERENCES t2(f3)
                ON DELETE CASCADE) ENGINE=INNODB;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1, 2);
INSERT INTO t3 VALUES(2);

SET DEBUG_SYNC='innodb_commit_inplace_alter_table_enter SIGNAL delete_parent_parent WAIT_FOR alter_child';
SET DEBUG_SYNC='now WAIT_FOR delete_parent_parent';
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                     WHERE INFO='DELETE FROM t1 WHERE f1 = 1' and
                     STATE='Waiting for table metadata lock';
SET DEBUG_SYNC='now signal alter_child';
DROP TABLE t3, t2, t1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(f1 INT NOT NULL, PRIMARY KEY(f1)) ENGINE=INNODB;
CREATE TABLE t2(f2 INT NOT NULL, FOREIGN KEY(f2) REFERENCES t1(f1)
                ON DELETE CASCADE)ENGINE=INNODB;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1);
SET DEBUG_SYNC= 'alter_after_copy_table SIGNAL delete_parent_parent WAIT_FOR delete_child';
SET DEBUG_SYNC= 'now WAIT_FOR delete_parent_parent';
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                     WHERE INFO='DELETE FROM t1 WHERE f1 = 1' and
                     STATE='Waiting for table metadata lock';
SET DEBUG_SYNC= 'now SIGNAL delete_child';
SELECT * FROM t1;
SELECT * FROM t2;

DROP TABLE t2, t1;
SET DEBUG_SYNC= 'RESET';

CREATE TABLE t1(f1 INT NOT NULL, PRIMARY KEY(f1))ENGINE=INNODB;
CREATE TABLE t2(f2 INT NOT NULL, FOREIGN KEY(f2) REFERENCES t1(f1)
                ON DELETE CASCADE)ENGINE=INNODB;
INSERT INTO t1 VALUES(1);
INSERT INTO t2 VALUES(1);

SET DEBUG_SYNC='innodb_commit_inplace_alter_table_enter SIGNAL delete_parent_parent WAIT_FOR alter_child';
SET DEBUG_SYNC='now WAIT_FOR delete_parent_parent';
let $wait_condition= SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
                     WHERE INFO='DELETE FROM t1 WHERE f1 = 1' and
                     STATE='Waiting for table metadata lock';
SET DEBUG_SYNC='now signal alter_child';
DROP TABLE t2, t1;
SET DEBUG_SYNC= 'RESET';
CREATE TABLE t1 (fld1 VARCHAR(300), fld2 INT, KEY idx1(fld2, fld1(200)))
ENGINE=InnoDB;
SET debug="+d,innodb_index_drop_count_zero";
ALTER TABLE t1 FORCE;
DROP TABLE t1;
SET debug="-d,innodb_index_drop_count_zero";
CREATE TABLE t1 (fld1 CHAR(10), KEY idx1(fld1(5))) ENGINE=InnoDB;
SET debug="+d,innodb_index_drop_count_one";
ALTER TABLE t1 MODIFY fld1 CHAR(5);
DROP TABLE t1;
SET debug="-d,innodb_index_drop_count_one";
CREATE TABLE t1 (fld1 CHAR(10), KEY idx1(fld1)) ENGINE=InnoDB;
SET debug="+d,innodb_index_drop_count_one";
ALTER TABLE t1 MODIFY fld1 CHAR(5);
DROP TABLE t1;
SET debug="-d,innodb_index_drop_count_one";
CREATE TABLE t1 (fld1 CHAR(10), KEY idx1(fld1(5))) ENGINE=InnoDB;
SET debug="+d,innodb_index_drop_count_zero";
ALTER TABLE t1 MODIFY fld1 CHAR(20);
DROP TABLE t1;
SET debug="-d,innodb_index_drop_count_zero";

CREATE TABLE t1(fld1 VARCHAR(5), KEY(fld1)) ENGINE= InnoDB;
SET DEBUG="+d,innodb_index_drop_count_zero";
ALTER TABLE t1 MODIFY fld1 VARCHAR(7), ALGORITHM= INPLACE;
ALTER TABLE t1 MODIFY fld1 VARCHAR(9), ALGORITHM= INPLACE;

SET DEBUG="-d,innodb_index_drop_count_zero";
ALTER TABLE t1 MODIFY fld1 VARCHAR(3), ALGORITHM= INPLACE;
ALTER TABLE t1 MODIFY fld1 VARCHAR(256), ALGORITHM= INPLACE;

DROP TABLE t1;
