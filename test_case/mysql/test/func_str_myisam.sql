SELECT bugdesc, REPLACE(bugdesc, 'xxxxxxxxxxxxxxxxxxxx', 'bbbbbbbbbbbbbbbbbbbb') from t1 group by bugdesc;
drop table t1;
CREATE TABLE t1 (id int(11) NOT NULL auto_increment, tmp text NOT NULL, KEY id (id)) ENGINE=MyISAM;
INSERT INTO t1 VALUES (1, 'a545f661efdd1fb66fdee3aab79945bf');
SELECT 1 FROM t1 WHERE tmp=AES_DECRYPT(tmp,"password");
DROP TABLE t1;
CREATE TABLE t1 (
  wid int(10) unsigned NOT NULL auto_increment,
  data_podp date default NULL,
  status_wnio enum('nowy','podp','real','arch') NOT NULL default 'nowy',
  PRIMARY KEY(wid)
);
INSERT INTO t1 VALUES (8,NULL,'real');
INSERT INTO t1 VALUES (9,NULL,'nowy');
SELECT elt(status_wnio,data_podp) FROM t1 GROUP BY wid;
DROP TABLE t1;
CREATE TABLE t1 (title text) ENGINE=MyISAM;
INSERT INTO t1 VALUES ('Congress reconvenes in September to debate welfare and adult education');
INSERT INTO t1 VALUES ('House passes the CAREERS bill');
SELECT CONCAT("</a>",RPAD("",(55 - LENGTH(title)),".")) from t1;
DROP TABLE t1;
CREATE TABLE t1 (
  id int(11) NOT NULL auto_increment,
  a bigint(20) unsigned default NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM;
INSERT INTO t1 VALUES
('0','16307858876001849059');
SELECT CONV('e251273eb74a8ee3', 16, 10);
SELECT id
  FROM t1
  WHERE a = 16307858876001849059;
SELECT id
  FROM t1
  WHERE a = CONV('e251273eb74a8ee3', 16, 10);
DROP TABLE t1;
create table t1 (a bigint not null)engine=myisam;
insert into t1 set a = 1024*1024*1024*4;
drop table t1;
create table t1 (a char(36) not null)engine=myisam;
insert ignore into t1 set a = ' ';
insert ignore into t1 set a = ' ';
select * from t1 order by (oct(a));
drop table t1;
