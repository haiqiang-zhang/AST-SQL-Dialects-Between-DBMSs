drop table if exists t1;
CREATE TABLE t1 (a int, unique (a), b int not null, unique(b), c int not null, index(c));
