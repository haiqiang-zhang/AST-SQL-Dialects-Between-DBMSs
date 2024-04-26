
-- Table names and columns.
create table $t(id int);
drop table $t;
create table t(id int, $id int, $id2 int, `$$id` int, $ int, $1 int,
               `$$$` int, id$$$ int, 1$ int, `$$` int, _$ int, b$$lit$$ int);

-- Multiple $ should also warn. Quoted identifiers should not give warning.
select `$1`, `$$$`,`$$id`, '$someli$teral' from t where t.`$id` = 0;
SET sql_mode = sys.LIST_ADD(@@sql_mode, 'ANSI_QUOTES');
select "$id2", "$$$" from t where t."$id" = 0;
SET sql_mode = sys.LIST_DROP(@@sql_mode, 'ANSI_QUOTES');

-- This should not give any warning.
select * from t where t.`$id` = 0 or `$id2` = 0 or b$$lit$$ = 0;

-- $ following a non-whitespace character.
select id+$id+$id from t;

-- Views.
create view $view as select id, $id2 from t;
select * from $view;
drop view `$view`;

-- Bug #34785775 : Partitions with partition key having $.
-- Should not generate a warning. The internally generated SQL should quote the
-- partition key name.
create table tpart (
    firstname varchar(25) NOT NULL,
    lastname varchar(25) NOT NULL,
    username varchar(16) NOT NULL,
    email varchar(35),
    `$joined` date not null
)
partition by key(`$joined`) partitions 6;
drop table tpart;

-- Even though prepared statement text is in quoted string or in a dynamic sql,
-- occurences of $ident should be identified.
prepare $stmt from 'select `$$id`, $id, `$$` from t';
set @table_name:='t';
set @sql:=concat('select `$$id`, $id, `$$` from ', @table_name);

-- Should work across multiple object name qualifications.
create schema $s;
create table $s.$t($id int);
select $s.$t.$id from $s.$t;
select $s.`$t`.`$id` from $s.`$t`;
drop table `$s`.`$t`;
drop schema `$s`;

-- Procedures and functions: Warnings should be caught for procedure name,
-- arguments and local variables.
delimiter //;
create procedure $p(in $i int)
begin
  declare $id1 int;
  select b$$lit$$ into $id1 from t where id = $i;
drop procedure `$p`;
create function $f($i int) returns int no sql
begin
  return `$i` * 2;
select $f(2);
drop function `$f`;

-- Words prefixed with @ are not the usual identifiers. They can start with $.
create role $username@$hostname.$domainname.com;
drop role $username@$hostname.$domainname.com;
set @$myvar = true;
select count(*) from t where @$myvar;

-- No space between a float and $ident;
select 8.0 $p, 8.4$p, .0$p, 8.$p, 8.p;
select .$p;

-- Quoted JSON path $expressions should not emit warning.
SELECT JSON_EXTRACT('{"id": "3", "$name": "Barney"}', "$.id");
SELECT JSON_EXTRACT('{"id": "3", "$name": "$Barney"}', "$.$name");

-- Should not conflict with client-side commands ('\' escape char is for the shell).
--exec $MYSQL test -e "prompt \$aa"
--exec $MYSQL test -e "prompt \$aa\$"

drop table t;
