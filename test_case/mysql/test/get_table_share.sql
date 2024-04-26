CREATE TABLE ta (pk integer primary key);
CREATE TABLE tb (pk integer primary key);
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TA1 WAIT_FOR cont_TA1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TA1';
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 WAIT_FOR cont_TB1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
SET DEBUG_SYNC= 'get_share_found_share SIGNAL found_TB2';
SET DEBUG_SYNC= 'get_share_before_open HIT_LIMIT 1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.events_waits_current
    WHERE event_name LIKE '%COND_open';
SET @first_wait_id= 0;
SELECT event_id FROM performance_schema.events_waits_current
  WHERE event_name LIKE '%COND_open' INTO @first_wait_id;
SET DEBUG_SYNC= 'now SIGNAL cont_TA1';
LET $wait_condition=
  SELECT event_id != @first_wait_id
    FROM performance_schema.events_waits_current
    WHERE event_name LIKE '%COND_open';
SET DEBUG_SYNC= 'now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR found_TB2';
SET DEBUG_SYNC= 'RESET';
DROP TABLE ta, tb;
CREATE TABLE ta (pk integer primary key);
CREATE TABLE tb (pk integer primary key);
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TA1 WAIT_FOR cont_TA1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TA1';
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 WAIT_FOR cont_TB1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
SET DEBUG_SYNC= 'get_share_found_share SIGNAL found_TB2';
SET DEBUG_SYNC= 'get_share_before_open HIT_LIMIT 1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.events_waits_current
    WHERE event_name LIKE '%COND_open';
SET DEBUG_SYNC= 'now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR found_TB2';
SET DEBUG_SYNC= 'now SIGNAL cont_TA1';
SET DEBUG_SYNC= 'RESET';
DROP TABLE ta, tb;
CREATE TABLE tb (pk integer primary key);
SET SESSION debug= '+d,set_open_table_err';
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 WAIT_FOR cont_TB1';
SET DEBUG_SYNC= 'get_share_after_destroy SIGNAL del_TB1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB2';
SET DEBUG_SYNC= 'get_share_after_destroy HIT_LIMIT 1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.events_waits_current
    WHERE event_name LIKE '%COND_open';
SET DEBUG_SYNC= 'now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR del_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB2';
SET SESSION debug= '-d,set_open_table_err';
SET DEBUG_SYNC= 'RESET';
DROP TABLE tb;
CREATE TABLE tb (pk integer primary key);
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 WAIT_FOR cont_TB1';
SET DEBUG_SYNC= 'get_share_after_destroy HIT_LIMIT 1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES';
SET DEBUG_SYNC= 'now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'RESET';
DROP TABLE tb;
CREATE TABLE tb (pk integer primary key);
SET SESSION debug= '+d,set_open_table_err';
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 \
                         WAIT_FOR cont_TB1 HIT_LIMIT 2';
SET DEBUG_SYNC= 'get_share_after_destroy SIGNAL del_TB1 HIT_LIMIT 2';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES tb';
SET DEBUG_SYNC= 'now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR del_TB1';
SET SESSION debug= '-d,set_open_table_err';
SET DEBUG_SYNC= 'RESET';
DROP TABLE tb;
CREATE TABLE tb (pk integer primary key);
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1
                                       WAIT_FOR cont_open_TB1 HIT_LIMIT 2';
SET DEBUG_SYNC= 'open_table_before_retry SIGNAL retry_TB1
                                         WAIT_FOR cont_retry_TB1';
SET DEBUG_SYNC= 'get_share_found_share SIGNAL found_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'open_table_found_share SIGNAL found_TB2 WAIT_FOR finish_TB2';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM performance_schema.events_waits_current
    WHERE event_name LIKE '%COND_open';
SET DEBUG_SYNC= 'now SIGNAL cont_open_TB1';
LET $wait_condition=
  SELECT COUNT(*) = 0 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table flush' AND info LIKE 'FLUSH TABLES';
SET DEBUG_SYNC= 'now WAIT_FOR retry_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR found_TB2';
SET DEBUG_SYNC= 'now SIGNAL cont_retry_TB1';
SET DEBUG_SYNC= 'now SIGNAL finish_TB2';
SET DEBUG_SYNC= 'now WAIT_FOR found_TB1';
SET DEBUG_SYNC= 'now SIGNAL finish_TB2';
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'RESET';
DROP TABLE tb;
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 WAIT_FOR cont_TB1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
LET $wait_condition=
  SELECT COUNT(*) = 1 FROM information_schema.processlist
    WHERE state LIKE 'Waiting for table metadata lock'
      AND info LIKE 'CREATE TABLE tb%';
SET DEBUG_SYNC='now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'RESET';
DROP TABLE tb;
CREATE TABLE ta (pk integer primary key);
CREATE TABLE tb (pk integer primary key);
INSERT INTO ta VALUES(0);
SET DEBUG_SYNC= 'get_share_before_open SIGNAL open_TB1 WAIT_FOR cont_TB1';
SET DEBUG_SYNC= 'get_share_found_share HIT_LIMIT 1';
SET DEBUG_SYNC= 'now WAIT_FOR open_TB1';
SET DEBUG_SYNC= 'now SIGNAL cont_TB1';
SET DEBUG_SYNC= 'RESET';
DROP TABLE ta, tb;
