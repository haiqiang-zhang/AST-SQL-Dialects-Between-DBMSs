alter table t1 MAX_ROWS=200 ROW_FORMAT=dynamic PACK_KEYS=0;
ALTER TABLE t1 AVG_ROW_LENGTH=0 CHECKSUM=0 COMMENT="" MIN_ROWS=0 MAX_ROWS=0 PACK_KEYS=DEFAULT DELAY_KEY_WRITE=0 ROW_FORMAT=default;
drop table t1;
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
select SQL_NO_CACHE * from tab1;
select SQL_NO_CACHE * from tab1;
drop table tab1;
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
