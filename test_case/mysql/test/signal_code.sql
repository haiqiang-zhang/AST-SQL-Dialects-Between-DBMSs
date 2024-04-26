
-- source include/have_debug.inc

use test;
drop procedure if exists signal_proc;
drop function if exists signal_func;

create procedure signal_proc()
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

create function signal_func() returns int
begin
  DECLARE foo CONDITION FOR SQLSTATE '12345';
end $$

delimiter ;
drop procedure signal_proc;
drop function signal_func;
