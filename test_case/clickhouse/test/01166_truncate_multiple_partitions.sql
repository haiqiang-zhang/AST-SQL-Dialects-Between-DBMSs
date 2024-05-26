select count(), sum(n) from trunc;
alter table trunc detach partition all;
alter table trunc attach partition id '0';
alter table trunc attach partition id '1';
alter table trunc attach partition id '2';
alter table trunc attach partition id '3';
truncate trunc;
drop table trunc;
