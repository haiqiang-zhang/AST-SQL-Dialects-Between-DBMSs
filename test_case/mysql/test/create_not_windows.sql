
-- Non-windows specific create tests.

--source include/not_windows.inc

--
-- Bug#19479:mysqldump creates invalid dump
--
--disable_warnings
drop table if exists `about:text`;
create table `about:text` ( 
_id int not null auto_increment,
`about:text` varchar(255) not null default '',
primary key (_id)
);
drop table `about:text`;
