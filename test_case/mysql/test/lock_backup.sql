
CREATE TABLE t1 (a INT);
SET lock_wait_timeout= 1;
SET autocommit= 0;

let $con1_id= `SELECT CONNECTION_ID()`;
CREATE TABLE t2 (a INT);
INSERT INTO t1 VALUES (100);
SELECT * FROM t1;
SET lock_wait_timeout= 10000000;
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for backup lock" AND id = $con1_id;

let $default_con_id= `SELECT CONNECTION_ID()`;

let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = 'Waiting for backup lock' AND id = $default_con_id;
let $wait_condition=
  SELECT count(*) = 0 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = 'Waiting for backup lock' AND id = $default_con_id;
CREATE USER u1;
DROP USER u1;
DROP TABLE t1, t2, t3;

CREATE TABLE t1 (a INT);

DROP TABLE t1;

CREATE DATABASE db1;
use db1;
CREATE TABLE t1 (a INT);
let $con1_id= `SELECT CONNECTION_ID()`;
use db1;
let $wait_condition=
  SELECT count(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE state = "Waiting for backup lock" AND id = $con1_id;
DROP DATABASE db1;
