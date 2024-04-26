CREATE TABLE t1 (
 id int(10) unsigned NOT NULL auto_increment,
 k int(10) unsigned NOT NULL default '0',
 c char(120) NOT NULL default '',
 pad char(60) NOT NULL default '',
 PRIMARY KEY (id),
 KEY k (k)
) charset latin1 engine=innodb;
let $count= 140;
{
  eval insert into t1(id, k) values ($count, $count);
  dec $count;

SET @@session.sort_buffer_size=32768;
SELECT c FROM t1 WHERE id between 2 and 1002 ORDER BY c;

SET @@session.sort_buffer_size=DEFAULT;

DROP TABLE t1;
