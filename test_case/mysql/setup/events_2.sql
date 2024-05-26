drop database if exists events_test;
create database events_test;
create event e_26 on schedule at '2037-01-01 00:00:00' disable do set @a = 5;
