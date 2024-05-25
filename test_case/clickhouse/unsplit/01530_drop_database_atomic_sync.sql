-- Tag no-parallel: creates database

drop database if exists db_01530_atomic sync;
create database db_01530_atomic Engine=Atomic;
drop database db_01530_atomic sync;
create database db_01530_atomic Engine=Atomic;
drop database db_01530_atomic sync;
set database_atomic_wait_for_drop_and_detach_synchronously=1;
create database db_01530_atomic Engine=Atomic;
drop database db_01530_atomic;
create database db_01530_atomic Engine=Atomic;
drop database db_01530_atomic;
set database_atomic_wait_for_drop_and_detach_synchronously=0;
create database db_01530_atomic Engine=Atomic;
drop database db_01530_atomic;
create database db_01530_atomic Engine=Atomic;
set database_atomic_wait_for_drop_and_detach_synchronously=1;
drop database db_01530_atomic sync;
