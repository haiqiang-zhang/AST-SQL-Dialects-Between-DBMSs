drop table if exists t1;
create table t1 (
    id  int(5) not null,    
    tt  char(255) not null
) character set latin2 collate latin2_czech_cs;
insert into t1 values (1,'Aa');
insert into t1 values (2,'Aas');
alter table t1 add primary key aaa(tt);