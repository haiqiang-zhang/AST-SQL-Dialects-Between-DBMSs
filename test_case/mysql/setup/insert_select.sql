drop table if exists t1,t2,t3;
create table t1 (bandID MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY, payoutID SMALLINT UNSIGNED NOT NULL);
insert into t1 (bandID,payoutID) VALUES (1,6),(2,6),(3,4),(4,9),(5,10),(6,1),(7,12),(8,12);
create table t2 (payoutID SMALLINT UNSIGNED NOT NULL PRIMARY KEY);
insert into t2 (payoutID) SELECT DISTINCT payoutID FROM t1;
insert ignore into t2 (payoutID) SELECT payoutID+10 FROM t1;
