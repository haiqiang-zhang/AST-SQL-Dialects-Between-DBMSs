drop database if exists db_01870;
create database db_01870;
create table db_01870.a_data_01870 as system.numbers Engine=TinyLog();
create table db_01870.z_buffer_01870 as system.numbers Engine=Buffer(db_01870, a_data_01870, 1,
    100, 100, /* time */
    100, 100, /* rows */
    100, 1e6  /* bytes */
);
insert into db_01870.z_buffer_01870 select * from system.numbers limit 5;
select count() from db_01870.a_data_01870;
detach database db_01870;
attach database db_01870;
drop database db_01870;
