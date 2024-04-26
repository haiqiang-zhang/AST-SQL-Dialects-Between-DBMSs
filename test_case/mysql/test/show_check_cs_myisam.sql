
--
-- Check of show index
-- Added engine=myisam for table t1, as repair is supported by MyISAM only
create table t1 (f1 int not null, f2 int not null, f3 int not null, f4 int not null, primary key(f1,f2,f3,f4)) engine=myisam;
insert into t1 values (1,1,1,0),(1,1,2,0),(1,1,3,0),(1,2,1,0),(1,2,2,0),(1,2,3,0),(1,3,1,0),(1,3,2,0),(1,3,3,0),(1,1,1,1),(1,1,2,1),(1,1,3,1),(1,2,1,1),(1,2,2,1),(1,2,3,1),(1,3,1,1),(1,3,2,1),(1,3,3,1);
drop table t1;
--

create table t1 (a int not null, b VARCHAR(10), INDEX (b) ) AVG_ROW_LENGTH=10 CHECKSUM=1 COMMENT="test" ENGINE=MYISAM MIN_ROWS=10 MAX_ROWS=100 PACK_KEYS=1 DELAY_KEY_WRITE=1 ROW_FORMAT=fixed;
alter table t1 MAX_ROWS=200 ROW_FORMAT=dynamic PACK_KEYS=0;
ALTER TABLE t1 AVG_ROW_LENGTH=0 CHECKSUM=0 COMMENT="" MIN_ROWS=0 MAX_ROWS=0 PACK_KEYS=DEFAULT DELAY_KEY_WRITE=0 ROW_FORMAT=default;
drop table t1;

--
-- Do a create table that tries to cover all types and options
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1 (
type_bool bool not null default 0,
type_tiny tinyint not null auto_increment primary key,
type_short smallint(3),
type_mediumint mediumint,
type_bigint bigint,
type_decimal decimal(5,2),
type_numeric numeric(5,2),
empty_char char(0),
type_char char(2),
type_varchar varchar(10),
type_timestamp timestamp not null default current_timestamp on update current_timestamp,
type_date date not null default '0000-00-00',
type_time time not null default '00:00:00',
type_datetime datetime not null default '0000-00-00 00:00:00',
type_year year,
type_enum enum ('red', 'green', 'blue'),
type_set enum ('red', 'green', 'blue'),
type_tinyblob tinyblob,
type_blob blob,
type_medium_blob mediumblob,
type_long_blob longblob,
index(type_short)
) AVG_ROW_LENGTH=10 CHECKSUM=1 COMMENT="test" ENGINE=MYISAM MIN_ROWS=10 MAX_ROWS=100 PACK_KEYS=1 DELAY_KEY_WRITE=1 ROW_FORMAT=fixed CHARSET=latin1;

-- Not tested above: UNION INSERT_METHOD DATA DIRECTORY INDEX DIRECTORY
show create table t1;
insert into t1 (type_timestamp) values ("2003-02-07 10:00:01");
select * from t1;
drop table t1;
SET sql_mode = default;

-- Test that USING <keytype> is always shown in SHOW CREATE TABLE when it was
-- specified during table creation, but not otherwise. (Bug#7235)
CREATE TABLE t1 (i int, KEY (i)) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING HASH (i)) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING BTREE (i)) ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY (i)) ENGINE=MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING BTREE (i)) ENGINE=MyISAM;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY (i)) ENGINE=MyISAM;
ALTER TABLE t1 ENGINE=MEMORY;
DROP TABLE t1;
CREATE TABLE t1 (i int, KEY USING BTREE (i)) ENGINE=MyISAM;
ALTER TABLE t1 ENGINE=MEMORY;
DROP TABLE t1;

--
-- Bug#28808 log_queries_not_using_indexes variable dynamic change is ignored
--
flush status;

CREATE TABLE `tab1` (
  `c1` int(11) default NULL,
  `c2` char(20) default NULL,
  `c3` char(20) default NULL,
  KEY `k1` (`c2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
INSERT INTO tab1 values(1, "hello", "world");
INSERT INTO tab1 values(2, "hello2", "world2");
INSERT INTO tab1 values(3, "hello3", "world3");

select SQL_NO_CACHE * from tab1;
set global log_queries_not_using_indexes=OFF;
select SQL_NO_CACHE * from tab1;
set global log_queries_not_using_indexes=ON;
select SQL_NO_CACHE * from tab1;

drop table tab1;

--
-- Bug#30088 Can't disable myisam-recover by a value of ""
--
show variables like 'myisam_recover_options';

--
-- Bug#37301 Length and Max_length differ with no obvious reason
--
CREATE TABLE t1 (
 Codigo int(10) unsigned NOT NULL auto_increment,
 Nombre varchar(255) default NULL,
 Telefono varchar(255) default NULL,
 Observaciones longtext,
 Direccion varchar(255) default NULL,
 Dni varchar(255) default NULL,
 CP int(11) default NULL,
 Provincia varchar(255) default NULL,
 Poblacion varchar(255) default NULL,
 PRIMARY KEY  (Codigo)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
drop table t1;
