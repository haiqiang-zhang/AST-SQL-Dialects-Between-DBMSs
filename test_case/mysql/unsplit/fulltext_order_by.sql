DROP TABLE IF EXISTS t1,t2,t3;
CREATE TABLE t1 (
  a INT AUTO_INCREMENT PRIMARY KEY,
  message CHAR(20),
  FULLTEXT(message)
) comment = 'original testcase by sroussey@network54.com';
INSERT INTO t1 (message) VALUES ("Testing"),("table"),("testbug"),
        ("steve"),("is"),("cool"),("steve is cool");
SELECT a, FORMAT(MATCH (message) AGAINST ('steve'),6) FROM t1 WHERE MATCH (message) AGAINST ('steve');
SELECT a, MATCH (message) AGAINST ('steve' IN BOOLEAN MODE) FROM t1 WHERE MATCH (message) AGAINST ('steve');
SELECT a, FORMAT(MATCH (message) AGAINST ('steve'),6) as rel FROM t1 ORDER BY rel;
SELECT a, MATCH (message) AGAINST ('steve' IN BOOLEAN MODE) as rel FROM t1 ORDER BY rel;
alter table t1 add key m (message);
SELECT message FROM t1 WHERE MATCH (message) AGAINST ('steve') ORDER BY message desc;
drop table t1;
CREATE TABLE t1 (
  a INT AUTO_INCREMENT PRIMARY KEY,
  message CHAR(20),
  FULLTEXT(message)
);
INSERT INTO t1 (message) VALUES ("testbug"),("testbug foobar");
SELECT a, MATCH (message) AGAINST ('t* f*' IN BOOLEAN MODE) as rel FROM t1;
SELECT a, MATCH (message) AGAINST ('t* f*' IN BOOLEAN MODE) as rel FROM t1 ORDER BY rel,a;
drop table t1;
CREATE TABLE t1 (
  id int(11) NOT NULL auto_increment,
  thread int(11) NOT NULL default '0',
  beitrag longtext NOT NULL,
  PRIMARY KEY  (id),
  KEY thread (thread),
  FULLTEXT KEY beitrag (beitrag)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 AUTO_INCREMENT=7923;
CREATE TABLE t2 (
  id int(11) NOT NULL auto_increment,
  text varchar(100) NOT NULL default '',
  PRIMARY KEY  (id),
  KEY text (text)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 AUTO_INCREMENT=63;
CREATE TABLE t3 (
  id int(11) NOT NULL auto_increment,
  forum int(11) NOT NULL default '0',
  betreff varchar(70) NOT NULL default '',
  PRIMARY KEY  (id),
  KEY forum (forum),
  FULLTEXT KEY betreff (betreff)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 AUTO_INCREMENT=996;
select distinct b.id, b.betreff from t3 b 
order by match(betreff) against ('+abc' in boolean mode) desc;
drop table t1,t2,t3;
