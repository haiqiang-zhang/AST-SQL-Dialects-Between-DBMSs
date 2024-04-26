
-- Skip the test incase MyISAM is not available
--source include/have_myisam.inc
--
-- Some special cases with empty tables
--

call mtr.add_suppression("The table 't1' is full");
drop table if exists t1;

set global myisam_data_pointer_size=2;
CREATE TABLE t1 (a int auto_increment primary key not null, b longtext) ENGINE=MyISAM;
let $1= 303;
{
  INSERT INTO t1 SET b=repeat('a',200);
  dec $1;

DELETE FROM t1 WHERE a=1 or a=5;
INSERT INTO t1 SET b=repeat('a',600);
UPDATE t1 SET b=repeat('a', 800) where a=10;

INSERT INTO t1 SET b=repeat('a',400);

DELETE FROM t1 WHERE a=2 or a=6;
UPDATE t1 SET b=repeat('a', 600) where a=11;
drop table t1;

set global myisam_data_pointer_size=default;
