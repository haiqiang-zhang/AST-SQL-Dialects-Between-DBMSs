
--
-- bug in bulk insert optimization
-- test case by Fournier Jocelyn <joc@presence-pc.com>
--

SET sql_mode = 'NO_ENGINE_SUBSTITUTION';

CREATE TABLE `t1` (
  `numeropost` bigint(20) unsigned NOT NULL default '0',
  `icone` tinyint(4) unsigned NOT NULL default '0',
  `numreponse` bigint(20) unsigned NOT NULL auto_increment,
  `contenu` text NOT NULL,
  `pseudo` varchar(50) NOT NULL default '',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `ip` bigint(11) NOT NULL default '0',
  `signature` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`numeropost`,`numreponse`)
  ,KEY `ip` (`ip`),
  KEY `date` (`date`),
  KEY `pseudo` (`pseudo`),
  KEY `numreponse` (`numreponse`)
) ENGINE=MyISAM;

CREATE TABLE `t2` (
  `numeropost` bigint(20) unsigned NOT NULL default '0',
  `icone` tinyint(4) unsigned NOT NULL default '0',
  `numreponse` bigint(20) unsigned NOT NULL auto_increment,
  `contenu` text NOT NULL,
  `pseudo` varchar(50) NOT NULL default '',
  `date` datetime NOT NULL default '0000-00-00 00:00:00',
  `ip` bigint(11) NOT NULL default '0',
  `signature` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`numeropost`,`numreponse`),
  KEY `ip` (`ip`),
  KEY `date` (`date`),
  KEY `pseudo` (`pseudo`),
  KEY `numreponse` (`numreponse`)
) ENGINE=MyISAM;

INSERT INTO t2
(numeropost,icone,numreponse,contenu,pseudo,date,ip,signature) VALUES
(9,1,56,'test','joce','2001-07-25 13:50:53'
,3649052399,0);


INSERT INTO t1 (numeropost,icone,contenu,pseudo,date,signature,ip)
SELECT 1618,icone,contenu,pseudo,date,signature,ip FROM t2
WHERE numeropost=9 ORDER BY numreponse ASC;

INSERT INTO t1 (numeropost,icone,contenu,pseudo,date,signature,ip)
SELECT 1718,icone,contenu,pseudo,date,signature,ip FROM t2
WHERE numeropost=9 ORDER BY numreponse ASC;

DROP TABLE t1,t2;

--
-- Another problem from Bug #2012
--

CREATE TABLE t1(
 Month date NOT NULL,
 Type tinyint(3) unsigned NOT NULL auto_increment,
 Field int(10) unsigned NOT NULL,
 Count int(10) unsigned NOT NULL,
 UNIQUE KEY Month (Month,Type,Field)
)engine=myisam;

insert into t1 Values
(20030901, 1, 1, 100),
(20030901, 1, 2, 100),
(20030901, 2, 1, 100),
(20030901, 2, 2, 100),
(20030901, 3, 1, 100);

select * from t1;

Select null, Field, Count From t1 Where Month=20030901 and Type=2;

create table t2(No int not null, Field int not null, Count int not null);

insert into t2 Select null, Field, Count From t1 Where Month=20030901 and Type=2;

select * from t2;

drop table t1, t2;

--
-- BUG#6034 - Error code 124:  Wrong medium type
--
CREATE TABLE t1 (
  ID           int(11) NOT NULL auto_increment,
  NO           int(11) NOT NULL default '0',
  SEQ          int(11) NOT NULL default '0',
  PRIMARY KEY  (ID),
  KEY t1$NO    (SEQ,NO)
) ENGINE=MyISAM;
INSERT INTO t1 (SEQ, NO) SELECT "1" AS SEQ, IF(MAX(NO) IS NULL, 0, MAX(NO)) + 1 AS NO FROM t1 WHERE (SEQ = 1);
select SQL_BUFFER_RESULT * from t1 WHERE (SEQ = 1);
drop table t1;
create table t1(f1 int);
insert into t1 values(1),(2),(3);
create table t2 (key(f1)) engine=myisam select sql_buffer_result f1 from t1;
drop table t1,t2;
