CREATE TABLE t1 (  `id` int(11) NOT NULL default '0', `id2` int(11) NOT NULL default '0', `id3` int(11) NOT NULL default '0', `dummy1` char(30) default NULL, PRIMARY KEY  (`id`,`id2`), KEY `index_id3` (`id3`)) ENGINE=MyISAM;
insert into t1 (id,id2) values (1,1),(1,2),(1,3);
