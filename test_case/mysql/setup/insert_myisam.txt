create table t1 (sid char(20), id int(2) NOT NULL auto_increment, key(sid, id)) engine=myisam;
insert into t1 values ('skr',NULL),('skr',NULL),('test',NULL);
