DROP TABLE IF EXISTS t_local;
DROP TABLE IF EXISTS t_dist;
create table t_local(a int) engine Log;
set distributed_foreground_insert = 1;
DROP TABLE t_local;
