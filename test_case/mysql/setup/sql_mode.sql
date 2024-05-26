drop table if exists t1,t2,v1,v2;
drop view if exists t1,t2,v1,v2;
CREATE TABLE `t1` (
  a int not null auto_increment,
  `pseudo` varchar(35) character set latin2 NOT NULL default '',
  `email` varchar(60) character set latin2 NOT NULL default '',
  PRIMARY KEY  (a),
  UNIQUE KEY `email` USING BTREE (`email`)
) ENGINE=HEAP CHARSET=latin1 ROW_FORMAT DYNAMIC;
drop table t1;
create table t1 ( min_num   dec(6,6)     default .000001);
drop table t1;
create table t1 ( min_num   dec(6,6)     default 0.000001);
drop table t1;
create table t1 ( min_num   dec(6,6)     default .000001);
drop table t1;
create table t1
(f1 integer auto_increment primary key,
 f2 timestamp not null default current_timestamp on update current_timestamp);
drop table t1;
CREATE TABLE t1 (p int not null auto_increment, a varchar(20), primary key(p)) charset latin1;
INSERT t1 (a) VALUES
('\\'),
('\n'),
('\b'),
('\r'),
('\t'),
('\x'),
('\a'),
('\aa'),
('\\a'),
('\\aa'),
('_'),
('\_'),
('\\_'),
('\\\_'),
('\\\\_'),
('%'),
('\%'),
('\\%'),
('\\\%'),
('\\\\%');
