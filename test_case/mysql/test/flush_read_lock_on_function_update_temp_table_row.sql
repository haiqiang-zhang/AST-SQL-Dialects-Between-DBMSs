--    CALL statement should be compatible with FTWRL.
-- 2. DO which calls SF updating temporary table should be
--    compatible with FTWRL.
-- 3. SELECT which calls SF updating temporary table should be
--    compatible with FTWRL.
-- 4. Ordinary SET which calls SF updating temporary table
--    should be compatible with FTWRL.
--
-- ==== References ====
--
-- flush_read_lock.test
-- Bug #28258992  FUNCTION CALL NOT WRITTEN TO BINLOG IF IT CONTAIN DML ALONG WITH DROP TEMP TABLE

--source include/have_binlog_format_row.inc
-- We need the Debug Sync Facility.
--source include/have_debug_sync.inc
-- Save the initial number of concurrent sessions.
--source include/count_sessions.inc
--source include/force_myisam_default.inc
--source include/have_myisam.inc

create temporary table t1_temp(i int);
create procedure p2(i int) begin end;
create function f2_temp() returns int
begin
  insert into t1_temp values (1);

let $con_aux1=con1;
let $con_aux2=con2;
let $cleanup_stmt2= ;
let $skip_3rd_check= ;
let $statement= call p2(f2_temp());
let $cleanup_stmt1= ;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
let $statement= do f2_temp();
let $cleanup_stmt= delete from t1_temp limit 1;
let $statement= select f2_temp();
let $cleanup_stmt= delete from t1_temp limit 1;
let $statement= set @a:= f2_temp();
let $cleanup_stmt= delete from t1_temp limit 1;
let $skip_3rd_check= 1;
let $skip_3rd_check= ;
drop procedure p2;
drop function f2_temp;
drop temporary tables t1_temp;
