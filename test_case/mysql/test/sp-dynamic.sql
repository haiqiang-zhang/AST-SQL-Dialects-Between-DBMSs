prepare stmt_alter from "alter table t1 add (b int)";
deallocate prepare stmt_alter;
deallocate prepare stmt;
select @tab_name;
select @drop_sql;
select @create_sql;
select @insert_sql;
select @select_sql;
prepare stmt from "create table t1 (a int)";
deallocate prepare stmt;
create table t1 (id integer not null primary key,
                   name varchar(20) not null);
insert into t1 (id, name) values (1, 'aaa'), (2, 'bbb'), (3, 'ccc');
prepare stmt from "select name from t1";
select name from t1;
prepare stmt from
    "select name from t1 where name=(select name from t1 where id=2)";
select name from t1 where name=(select name from t1 where id=2);
deallocate prepare stmt;
drop table if exists t1, t2;
select @rsql;
select @rsql;
drop table if exists t1, t2;
