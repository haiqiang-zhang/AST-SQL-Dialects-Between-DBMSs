create table integers(i int primary key, check (i < 10));
create table test(i varchar unique, k varchar, check(len(i || k) < 10));
create table fk_integers(j int, foreign key (j) references integers(i));
create table fk_integers_2(k int, foreign key (k) references integers(i));
