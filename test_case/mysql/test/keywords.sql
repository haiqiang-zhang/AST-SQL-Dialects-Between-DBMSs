
--
-- Test keywords as fields
--

--disable_warnings
drop table if exists t1;

create table t1 (time time, date date, timestamp timestamp,
quarter int, week int, year int, timestampadd int, timestampdiff int);
insert into t1 values ("12:22:22","97:02:03","1997-01-02",1,2,3,4,5);
select * from t1;
select t1.time+0,t1.date+0,t1.timestamp+0,concat(date," ",time),
       t1.quarter+t1.week, t1.year+timestampadd,  timestampdiff from t1;
drop table t1;
create table events(binlog int);
insert into events values(1);
select events.binlog from events;
drop table events;

-- End of 4.1 tests

--
-- Bug#19939 "AUTHORS is not a keyword"
--
delimiter |;
create procedure p1()
begin
   declare n int default 2;
     set n = n -1;
   end while authors;
create procedure p2()
begin
   declare n int default 2;
     set n = n -1;
   end while contributors;
drop procedure p1;
drop procedure p2;

-- End of 5.1 tests

--
-- Bug#12204 - CONNECTION should not be a reserved word
--

create table t1 (connection int, b int);
create procedure p1()
begin
  declare connection int;
  select max(t1.connection) into connection from t1;
  select concat("max=",connection) 'p1';
insert into t1 (connection) values (1);
drop procedure p1;
drop table t1;

-- End of 5.0 tests

--
-- BUG#57899: Certain reserved words should not be reserved
--

--
-- We are looking for SYNTAX ERRORS here, so no need to 
-- log the queries
--

CREATE TABLE slow (slow INT, general INT, master_heartbeat_period INT, ignore_server_ids INT);
INSERT INTO slow(slow, general, master_heartbeat_period, ignore_server_ids) VALUES (1,2,3,4), (5,6,7,8);
INSERT INTO slow(slow, general, master_heartbeat_period) VALUES (1,2,3), (5,6,7);
INSERT INTO slow(slow, general) VALUES (1,2), (5,6);
INSERT INTO slow(slow) VALUES (1), (5);
SELECT slow, general, master_heartbeat_period, ignore_server_ids FROM slow ORDER BY slow;
SELECT slow, general, master_heartbeat_period FROM slow ORDER BY slow;
SELECT slow, master_heartbeat_period FROM slow ORDER BY slow;
SELECT slow FROM slow ORDER BY slow;
DROP TABLE slow;
CREATE TABLE general (slow INT, general INT, master_heartbeat_period INT, ignore_server_ids INT);
INSERT INTO general(slow, general, master_heartbeat_period, ignore_server_ids) VALUES (1,2,3,4), (5,6,7,8);
INSERT INTO general(slow, general, master_heartbeat_period) VALUES (1,2,3), (5,6,7);
INSERT INTO general(slow, general) VALUES (1,2), (5,6);
INSERT INTO general(slow) VALUES (1), (5);
SELECT slow, general, master_heartbeat_period, ignore_server_ids FROM general ORDER BY slow;
SELECT slow, general, master_heartbeat_period FROM general ORDER BY slow;
SELECT slow, master_heartbeat_period FROM general ORDER BY slow;
SELECT slow FROM general ORDER BY slow;
DROP TABLE general;
CREATE TABLE master_heartbeat_period (slow INT, general INT, master_heartbeat_period INT, ignore_server_ids INT);
INSERT INTO master_heartbeat_period(slow, general, master_heartbeat_period, ignore_server_ids) VALUES (1,2,3,4), (5,6,7,8);
INSERT INTO master_heartbeat_period(slow, general, master_heartbeat_period) VALUES (1,2,3), (5,6,7);
INSERT INTO master_heartbeat_period(slow, general) VALUES (1,2), (5,6);
INSERT INTO master_heartbeat_period(slow) VALUES (1), (5);
SELECT slow, general, master_heartbeat_period, ignore_server_ids FROM master_heartbeat_period ORDER BY slow;
SELECT slow, general, master_heartbeat_period FROM master_heartbeat_period ORDER BY slow;
SELECT slow, master_heartbeat_period FROM master_heartbeat_period ORDER BY slow;
SELECT slow FROM master_heartbeat_period ORDER BY slow;
DROP TABLE master_heartbeat_period;
CREATE TABLE ignore_server_ids (slow INT, general INT, master_heartbeat_period INT, ignore_server_ids INT);
INSERT INTO ignore_server_ids(slow, general, master_heartbeat_period, ignore_server_ids) VALUES (1,2,3,4), (5,6,7,8);
INSERT INTO ignore_server_ids(slow, general, master_heartbeat_period) VALUES (1,2,3), (5,6,7);
INSERT INTO ignore_server_ids(slow, general) VALUES (1,2), (5,6);
INSERT INTO ignore_server_ids(slow) VALUES (1), (5);
SELECT slow, general, master_heartbeat_period, ignore_server_ids FROM ignore_server_ids ORDER BY slow;
SELECT slow, general, master_heartbeat_period FROM ignore_server_ids ORDER BY slow;
SELECT slow, master_heartbeat_period FROM ignore_server_ids ORDER BY slow;
SELECT slow FROM ignore_server_ids ORDER BY slow;
DROP TABLE ignore_server_ids;

CREATE TABLE t1 (slow INT, general INT, ignore_server_ids INT, master_heartbeat_period INT);
INSERT INTO t1 VALUES (1,2,3,4);
CREATE PROCEDURE p1()
BEGIN
  DECLARE slow INT;

  SELECT max(t1.slow) INTO slow FROM t1;
  SELECT max(t1.general) INTO general FROM t1;
  SELECT max(t1.ignore_server_ids) INTO ignore_server_ids FROM t1;
  SELECT max(t1.master_heartbeat_period) INTO master_heartbeat_period FROM t1;

  SELECT slow, general, ignore_server_ids, master_heartbeat_period;

CREATE PROCEDURE p2()
BEGIN

   DECLARE n INT DEFAULT 2;
     SET n = n -1;
   END WHILE general;

   SET n = 2;
     SET n = n -1;
   END WHILE slow;

   SET n = 2;
     SET n = n -1;
   END WHILE ignore_server_ids;

   SET n = 2;
     SET n = n -1;
   END WHILE master_heartbeat_period;
DROP PROCEDURE p1;
DROP PROCEDURE p2;
DROP TABLE t1;
