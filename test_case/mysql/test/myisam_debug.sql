
CREATE TABLE `t1` (
`id` BIGINT(20) ,
`id1` BIGINT(20) AUTO_INCREMENT,
 KEY(id1), KEY(id)
) ENGINE=MyISAM;

CREATE TABLE `t2` (
`id` BIGINT(20) ,
`id1` BIGINT(20) AUTO_INCREMENT,
 KEY (id1), KEY(id)
) ENGINE=MyISAM;

INSERT INTO t2 (id) VALUES (123);

let $i = 10;
{
  INSERT INTO t2 (id) SELECT id  FROM t2;
  dec $i;
SET SESSION debug='+d,wait_in_enable_indexes';

let $wait_condition=
  SELECT COUNT(*) = 1 FROM INFORMATION_SCHEMA.PROCESSLIST
  WHERE STATE = "wait_in_enable_indexes" AND 
  INFO = "INSERT INTO t1(id) SELECT id  FROM t2";

SELECT ID FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE STATE = 'wait_in_enable_indexes' AND 
INFO = "INSERT INTO t1(id) SELECT id  FROM t2" 
INTO @thread_id;
DROP TABLE t1,t2;
