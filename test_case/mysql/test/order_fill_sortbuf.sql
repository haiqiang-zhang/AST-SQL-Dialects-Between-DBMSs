
--
-- This test does a create-select with ORDER BY, where there is so many
-- rows MySQL needs to use a merge during the sort phase.
--

--disable_warnings
drop table if exists t1,t2;

SET sort_buffer_size=32804;

CREATE TABLE `t1` (
  `id` int(11) NOT NULL default '0',
  `id2` int(11) NOT NULL default '0',
  `id3` int(11) NOT NULL default '0');
let $1=4000;
 {
   eval insert into t1 (id,id2,id3) values ($1,$1,$1);
   dec $1;
create table t2 select id2 from t1 order by id3;
select count(*) from t2;
drop table t1,t2;

SET sort_buffer_size=DEFAULT;
