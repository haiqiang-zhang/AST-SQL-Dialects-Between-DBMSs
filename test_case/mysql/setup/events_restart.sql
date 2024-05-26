drop database if exists events_test;
create database events_test;
create table execution_log(name char(10));
create event abc1 on schedule every 1 second do
  insert into execution_log value('abc1');
create event abc2 on schedule every 1 second do
  insert into execution_log value('abc2');
create event abc3 on schedule every 1 second do 
  insert into execution_log value('abc3');
