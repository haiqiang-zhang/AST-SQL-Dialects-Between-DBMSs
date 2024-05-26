drop table if exists t1,t2;
CREATE TABLE `t1` (
  `id` int(11) NOT NULL default '0',
  `id2` int(11) NOT NULL default '0',
  `id3` int(11) NOT NULL default '0');
create table t2 select id2 from t1 order by id3;
