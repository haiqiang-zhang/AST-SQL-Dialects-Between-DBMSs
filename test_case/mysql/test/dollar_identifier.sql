create table $t(id int);
drop table $t;
create table t(id int, $id int, $id2 int, `$$id` int, $ int, $1 int,
               `$$$` int, id$$$ int, 1$ int, `$$` int, _$ int, b$$lit$$ int);
select `$1`, `$$$`,`$$id`, '$someli$teral' from t where t.`$id` = 0;
select * from t where t.`$id` = 0 or `$id2` = 0 or b$$lit$$ = 0;
select id+$id+$id from t;
create view $view as select id, $id2 from t;
select * from $view;
drop view `$view`;
create table tpart (
    firstname varchar(25) NOT NULL,
    lastname varchar(25) NOT NULL,
    username varchar(16) NOT NULL,
    email varchar(35),
    `$joined` date not null
)
partition by key(`$joined`) partitions 6;
drop table tpart;
prepare $stmt from 'select `$$id`, $id, `$$` from t';
create schema $s;
create table $s.$t($id int);
drop table `$s`.`$t`;
drop schema `$s`;
select count(*) from t where @$myvar;
select 8.0 $p, 8.4$p, .0$p, 8.$p, 8.p;
SELECT JSON_EXTRACT('{"id": "3", "$name": "Barney"}', "$.id");
SELECT JSON_EXTRACT('{"id": "3", "$name": "$Barney"}', "$.$name");
drop table t;
