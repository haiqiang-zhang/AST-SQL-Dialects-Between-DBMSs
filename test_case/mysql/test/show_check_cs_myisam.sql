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
